using System;

namespace BackUps
{
    public class DateClean : IBackupCleanStrategy
    {
        private int _countDate;
        private readonly DateTime _limit;
        private readonly Backup _data;

        public DateClean(ref Backup data, dynamic limit)
        {
            this._data = data;
            _limit = limit;
        }

        public int Execute()
        {
            var sizePoints = _data.GetDateTimeEachPoint();
            var node = sizePoints.First;
            while (node != null)
            {
                if (node.Value < _limit)
                {
                    _countDate++;
                }

                node = node.Next;
            }

            return _countDate;
        }
    }
}