namespace BackUps
{
    public class SizeClean : IBackupCleanStrategy
    {
        private int _countSize;
        private readonly int _limit;
        private readonly Backup _data;

        public SizeClean(ref Backup data, dynamic limit)
        {
            this._data = data;
            _limit = limit;
        }
        public int Execute()
        {
            if (_data.GetSizeOfPoints() <= _limit) return _countSize;
            var totalSize = _data.GetSizeOfPoints();
            var sizePoints = _data.GetSizeOfEachPoint();
            var sizePoint = sizePoints.First;
            while (totalSize > _limit && sizePoint != null)
            {
                totalSize -= sizePoint.Value;
                sizePoint = sizePoint.Next;
                _countSize++;
            }
            return _countSize;
        }
    }
}