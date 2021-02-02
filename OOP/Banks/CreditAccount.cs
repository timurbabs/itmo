using System;

namespace Banks
{
    internal class Credit : Account
    {
        private float _limit;
        private float _comission;

        public Credit(float money, float limit, float comission)
        {
            AccountType = AccountTypes.Credit;
            this.Money = money;
            this._limit = limit;
            this._comission = comission;
        }

        public float GetBonus(float money)
        {
            if (money < _limit)
            {
                return _comission;
            }

            return 0;
        }

        public override void AddMoney(float _money)
        {
            if (Frozen == false)
            {
                Money += _money;
                Money += GetBonus(_money);
            }
            else
            {
                throw new Exception("Account is frozen.");
            }
        }

        public override void RaiseMoney(float _money)
        {
            if (Frozen == false)
            {
                Money -= _money;
            }
            else
            {
                throw new Exception("Account is frozen");
            }
        }
    }
}