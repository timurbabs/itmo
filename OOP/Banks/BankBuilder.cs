using System;
using System.Collections.Generic;

namespace Banks
{
    public class BankBuilder
    {
        private Bank _bank = new Bank();

        public BankBuilder()
        {
            this.Reset();
        }

        private void Reset()
        {
            this._bank = new Bank();
        }

        public BankBuilder AddName(string name)
        {
            _bank.Name = name;
            return this;
        }

        public BankBuilder DebitOptions(float percent)
        {
            _bank.DebitFabric = new DebitCreator(percent);
            return this;
        }

        public BankBuilder DepositOptions(LinkedList<Tuple<float, DepositType, float>> percentRest, DateTime dateLimit)
        {
            _bank.DepositFabric = new DepositCreator(percentRest, dateLimit);
            return this;
        }

        public BankBuilder CreditOptions(float limit, float comission)
        {
            _bank.CreditFabric = new CreditCreator(limit, comission);
            return this;
        }

        public Bank GetBank()
        {
            var result = this._bank;
            if (_bank.CreditFabric == null || _bank.DepositFabric == null || _bank.DebitFabric == null)
            {
                throw new Exception("Bank don't have some account types.");
            }

            this.Reset();
            return result;
        }
    }
}