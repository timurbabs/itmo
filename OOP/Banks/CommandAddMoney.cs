using System;

namespace Banks
{
    class AddMoney : Command
    {
        public AddMoney(Guid clientId, Guid id, float money)
        {
            data.AddLast(new Tuple<Guid, Guid, float>(clientId, id, money));
        }

        public override void Execute(Bank bank)
        {
            AddMoneyFunc(bank);
        }

        public override void Undo(Bank bank, Command commandUndo)
        {
            AddMoneyUndoFunc(bank, commandUndo);
        }
    }
}