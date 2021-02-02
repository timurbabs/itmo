namespace BackUps
{
    public interface IBackupSaveStrategy
    {
        void Save(string path);
    }
}