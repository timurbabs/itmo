using System;
using System.Collections.Generic;

namespace Banks
{
    public abstract class Creator
    {
        protected float Money;
        public abstract Account FactoryMethod();

        public void ChangeMoney(float money)
        {
            this.Money = money;
        }
    }

    class DebitCreator : Creator
    {
        private readonly float _percent;

        public DebitCreator(float percent)
        {
            this._percent = percent;
        }

        public override Account FactoryMethod()
        {
            return new Debit(Money, _percent);
        }
    }

    class DepositCreator : Creator
    {
        private readonly LinkedList<Tuple<float, DepositType, float>> _percentRest;
        private readonly DateTime _dateLimit;

        public DepositCreator(LinkedList<Tuple<float, DepositType, float>> percentRest, DateTime dateLimit)
        {
            _percentRest = percentRest;
            this._dateLimit = dateLimit;
        }

        public override Account FactoryMethod()
        {
            return new Deposit(Money, _percentRest, _dateLimit);
        }
    }

    class CreditCreator : Creator
    {
        private readonly float _limit;
        private readonly float _comission;

        public CreditCreator(float limit, float comission)
        {
            this._limit = limit;
            this._comission = comission;
        }

        public override Account FactoryMethod()
        {
            return new Credit(Money, _limit, _comission);
        }
    }
}