using System;
using System.Collections.Generic;

namespace Banks
{
    internal class Deposit : Account
    {
        private bool _firstMoneyCheck;
        private float _firstMoney;
        private DateTime _dateLimit;
        private DateTime _bonusday;
        private readonly LinkedList<Tuple<float, DepositType, float>> _percentRest;
        private float _persent;

        public Deposit(float money, LinkedList<Tuple<float, DepositType, float>> percentRest, DateTime dateLimit)
        {
            AccountType = AccountTypes.Deposit;
            this.Money = money;
            this._percentRest = percentRest;
            this._bonusday = DateTime.Now;
            this._dateLimit = dateLimit;
            this.Frozen = true;
            while (this._bonusday.Day != 30)
            {
                this._bonusday = this._bonusday.AddDays(1);
            }
        }

        public float GetBonus(float money)
        {
            var temp = _percentRest.First;
            while (temp != null)
            {
                if (temp.Value.Item2 == DepositType.Less)
                {
                    if (temp.Value.Item1 < _firstMoney)
                    {
                        _persent = temp.Value.Item3 / 365;
                    }
                }

                if (temp.Value.Item2 == DepositType.More)
                {
                    if (temp.Value.Item1 > _firstMoney)
                    {
                        _persent = temp.Value.Item3 / 365;
                    }
                }

                temp = temp.Next;
            }

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
                Bonus += money * _persent;
                return 0;
            }
        }

        public override void AddMoney(float money)
        {
            if (_dateLimit > DateTime.Now)
            {
                throw new Exception("Date limit is not yet done.");
            }

            if (_firstMoneyCheck == false)
            {
                _firstMoneyCheck = true;
                _firstMoney = money;
            }

            if (Frozen == false)
            {
                Money += money;
                Money += GetBonus(money);
            }
            else
            {
                throw new Exception("Account is frozen.");
            }
        }

        public override void RaiseMoney(float money)
        {
            if (Frozen == false)
            {
                Money -= money;
            }
            else
            {
                throw new Exception("Account is frozen");
            }
        }
    }
}