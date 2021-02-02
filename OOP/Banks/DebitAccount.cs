using System;

namespace Banks
{
    internal class Debit : Account
    {
        public float _percentRest;
        private DateTime _bonusday;

        public Debit(float money, float percent)
        {
            AccountType = AccountTypes.Debit;
            this.Money = money;
            this._percentRest = percent / 365;
            this._bonusday = DateTime.Now;
            while (this._bonusday.Day != 30)
            {
                this._bonusday = this._bonusday.AddDays(1);
            }
        }

        public float GetBonus(float money)
        {
            if (this._bonusday < DateTime.Now)
            {
                while (this._bonusday.Day != 30)
                {
                    this._bonusday = this._bonusday.AddDays(1);
                }

                float trueBonus = Bonus;
                Bonus = 0;
                return trueBonus;
            }
            else
            {
                Bonus += money * _percentRest;
                return 0;
            }
        }

        public override void AddMoney(float _money)
        {
            if (Money < 0)
            {
                throw new Exception("Debit is less than zero");
            }

            if (Frozen == false)
            {
                Money += _money;
                Money += GetBonus(_money);
            }
            else
            {
                throw new Exception("Account is frozen");
            }
        }

        public override void RaiseMoney(float _money)
        {
            if (Money < 0)
            {
                throw new Exception("Debit is less than zero");
            }

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