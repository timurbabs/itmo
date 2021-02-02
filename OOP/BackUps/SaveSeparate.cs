using System.IO;

namespace BackUps
{
    public class SaveSeparate
    {
        private readonly RestorePoint _data;
        private static int _iteration;

        public SaveSeparate(RestorePoint data)
        {
            this._data = data;
        }

        public void Save(string path)
        {
            File.Create(path + _iteration);
            foreach (var files in _data.Files.Values)
            {
                File.WriteAllText(path + _iteration, files.FullName);
            }

            _iteration++;
        }
    }
}