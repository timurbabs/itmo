using System.IO;

namespace BackUps
{
    public class SaveGeneral : IBackupSaveStrategy
    {
        private readonly RestorePoint _data;

        public SaveGeneral(RestorePoint data)
        {
            this._data = data;
        }

        public void Save(string path)
        {
            foreach (var files in _data.Files.Values)
            {
                File.WriteAllText(path, files.FullName);
            }
        }
    }
}