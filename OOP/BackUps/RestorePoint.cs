using System;
using System.IO;
using System.Collections.Generic;

namespace BackUps
{
    public class RestorePoint
    {
        public readonly Dictionary<DateTime, FileInfo> Files;

        public RestorePoint(PointType type)
        {
            this.Type = type;
            Time = DateTime.Now;
            Files = new Dictionary<DateTime, FileInfo>();
        }

        public RestorePoint(PointType type, IEnumerable<FileInfo> files)
        {
            this.Type = type;
            Time = DateTime.Now;
            this.Files = new Dictionary<DateTime, FileInfo>();
            foreach (var curFile in files)
            {
                var temp = new FileInfo(curFile.FullName);
                var date = temp.LastWriteTime;
                this.Files.Add(date, temp);
            }
        }

        public PointType Type { get; }
        public DateTime Time { get; }
    }
}