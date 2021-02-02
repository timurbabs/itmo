using System;
using System.Collections.Generic;

public enum DepositType
{
    Less,
    More
}

namespace Banks
{
    public abstract class Account
    {
        public AccountTypes AccountType;
        public Guid Id = Guid.NewGuid();
        public float Money;
        public bool Frozen;
        protected float Bonus;
        public abstract void AddMoney(float money);
        public abstract void RaiseMoney(float money);
    }
}