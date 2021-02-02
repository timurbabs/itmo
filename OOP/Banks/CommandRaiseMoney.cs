using System;

namespace Banks
{
    class RaiseMoney : Command
    {
        public RaiseMoney(Guid clientId, Guid id, float money)
        {
            data.AddLast(new Tuple<Guid, Guid, float>(clientId, id, money));
        }

        public override void Execute(Bank bank)
        {
            RaiseMoneyFunc(bank);
        }

        public override void Undo(Bank bank, Command commandUndo)
        {
            RaiseMoneyUndoFunc(bank, commandUndo);
        }
    }
}