using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

public enum PointType
{
    Incremental,
    Full,
};

public enum CleanType
{
    Max,
    Min,
};

namespace BackUps
{
    public class Backup
    {
        private readonly string _name;
        public LinkedList<RestorePoint> _points { get; }
        private readonly LinkedList<FileInfo> _files;
        private string _path;

        public Backup(string name)
        {
            this._name = name;
            _points = new LinkedList<RestorePoint>();
            _files = new LinkedList<FileInfo>();
        }

        public void SetSavePath(string SavePath)
        {
            _path = SavePath;
        }

        public void AddFullRestorePoint()
        {
            var point = new RestorePoint(PointType.Full, _files);
            _points.AddLast(point);
        }

        public void AddIncrementalRestorePoint()
        {
            if (_points.Count == 0)
            {
                throw new Exception("You need to add FullRestorePoint first.");
            }

            var addFiles = new LinkedList<FileInfo>();
            var fakePoint = new RestorePoint(PointType.Incremental, _files);
            var latestPoint = _points.Last;
            foreach (var file1 in latestPoint.Value.Files)
            {
                foreach (var file2 in fakePoint.Files)
                {
                    if (file2.Value.Name != file1.Value.Name || file1.Key == file2.Key) continue;
                    var exists = addFiles.Any(u => u.Name == file1.Value.Name);
                    if (exists == false)
                    {
                        addFiles.AddLast(file1.Value);
                    }
                }
            }

            var newRestorePoint = new RestorePoint(PointType.Incremental, addFiles);
            _points.AddLast(newRestorePoint);
        }

        public void CleanPoints(CleanType type, params IBackupCleanStrategy[] algorithms)
        {
            var pointsDel = algorithms.Select(temp => temp.Execute()).ToList();
            pointsDel.Sort();
            switch (type)
            {
                case CleanType.Max:
                {
                    this.DeletePoints(pointsDel.Last());
                    break;
                }
                case CleanType.Min:
                {
                    this.DeletePoints(pointsDel.First());
                    break;
                }
                default:
                    throw new Exception("Wrong type.");
            }
        }

        public void SaveBackup(IBackupSaveStrategy algorithms)
        {
            algorithms.Save(_path);
        }

        public void AddFile(string path)
        {
            var temp = new FileInfo(@path);
            _files.AddLast(temp);
        }

        public void AddFile(params string[] path)
        {
            foreach (var curePath in path)
            {
                var temp = new FileInfo(@curePath);
                _files.AddLast(temp);
            }
        }

        public void DeleteFile(string file)
        {
            foreach (var temp in _files.Where(temp => file == temp.FullName))
            {
                _files.Remove(temp);
                return;
            }
        }

        private void DeletePoints(int delCount)
        {
            var count = 0;
            for (var i = 0; _points.Count != 0 && i < delCount && count < delCount; i++)
            {
                _points.RemoveFirst();
                count++;
                while (_points.Count != 0 && _points.First().Type != PointType.Full)
                {
                    _points.RemoveFirst();
                    count++;
                }
            }

            if (count <= delCount) return;
            var more = count - delCount;
            Console.WriteLine("Deleted {0} more than needed.", more);
        }

        public long GetSizeOfPoints()
        {
            if (this.GetCount() == 0)
            {
                throw new Exception("Backup don't have points.");
            }

            long size = 0;
            foreach (var point in _points)
            {
                if (point.Files == null)
                {
                    throw new Exception("Don't have added files.");
                }

                size += point.Files.Sum(file => file.Value.Length);
            }

            return size;
        }

        public LinkedList<long> GetSizeOfEachPoint()
        {
            if (this.GetCount() == 0)
            {
                throw new Exception("Backup don't have points.");
            }

            var sizes = new LinkedList<long>();
            var sizePoint = _points.First;
            while (sizePoint != null)
            {
                sizes.AddFirst(GetSizeOfPoint(sizePoint.Value));
                sizePoint = sizePoint.Next;
            }

            return sizes;
        }

        public LinkedList<DateTime> GetDateTimeEachPoint()
        {
            if (this.GetCount() == 0)
            {
                throw new Exception("Backup don't have points.");
            }

            var times = new LinkedList<DateTime>();
            var timePoint = _points.First;
            while (timePoint != null)
            {
                times.AddFirst(timePoint.Value.Time);
                timePoint = timePoint.Next;
            }

            return times;
        }

        public int GetCount()
        {
            return this._points.Count;
        }

        private static long GetSizeOfPoint(RestorePoint point)
        {
            return point.Files.Sum(file => file.Value.Length);
        }

        public void ShowInfo()
        {
            Console.WriteLine("\nBackup name: {0}", this._name);
            foreach (var point in _points)
            {
                Console.WriteLine("\nPoint: {0}, {1} Bytes - {2}", point.Time, GetSizeOfPoint(point), point.Type);
                foreach (var file in point.Files)
                {
                    Console.WriteLine("File: {0}, {1} Bytes - {2}", file.Key, file.Value.Length, file.Value.FullName);
                }
            }

            Console.WriteLine();
            Console.WriteLine("-------------------------------------------------------------------------------------");
            Console.WriteLine();
        }
    }
}