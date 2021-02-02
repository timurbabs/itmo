using System;

namespace BackUps
{
    public class CountClean : IBackupCleanStrategy
    {
        private int _countClean;
        private readonly int _limit;
        private readonly Backup _data;

        public CountClean(ref Backup data, dynamic limit)
        {
            this._data = data;
            _limit = limit;
        }

        public int Execute()
        {
            _countClean = 0;
            if (_data.GetCount() < _limit) return _countClean;
            var countDel = _data.GetCount();
            while (countDel > _limit - 1)
            {
                countDel--;
                _countClean++;
            }

            return _countClean;
        }
    }
}