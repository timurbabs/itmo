using System;
using System.Collections.Generic;

namespace Banks
{
    public abstract class Command
    {
        public Guid Id;
        public LinkedList<Tuple<Guid, Guid, float>> data = new LinkedList<Tuple<Guid, Guid, float>>();
        public abstract void Execute(Bank bank);
        public abstract void Undo(Bank bank, Command commandUndo);

        protected void AddMoneyFunc(Bank bank)
        {
            if (bank.AccountsData.ContainsKey(data.First.Value.Item1))
            {
                var search = bank.AccountsData[data.First.Value.Item1].First;
                while (search != null)
                {
                    if (search.Value.Id == data.First.Value.Item2)
                    {
                        if (bank.ClientsData[data.First.Value.Item1].Doubtful)
                        {
                            search.Value.AddMoney(data.First.Value.Item3);
                            return;
                        }

                        throw new Exception("Account is not dountful");
                    }

                    search = search.Next;
                }

                if (search == null)
                {
                    throw new Exception("Wrond account ID");
                }
            }
        }

        protected void RaiseMoneyFunc(Bank bank)
        {
            if (bank.AccountsData.ContainsKey(data.First.Value.Item1))
            {
                var search = bank.AccountsData[data.First.Value.Item1].First;
                while (search != null)
                {
                    if (search.Value.Id == data.First.Value.Item2)
                    {
                        if (bank.ClientsData[data.First.Value.Item1].Doubtful)
                        {
                            search.Value.RaiseMoney(data.First.Value.Item3);
                            return;
                        }

                        throw new Exception("Account is not dountful");
                    }

                    search = search.Next;
                }

                if (search == null)
                {
                    throw new Exception("Wrond account ID");
                }
            }
        }

        protected void AddMoneyUndoFunc(Bank bank, Command commandUndo)
        {
            if (bank.AccountsData.ContainsKey(commandUndo.data.First.Value.Item1))
            {
                var search = bank.AccountsData[commandUndo.data.First.Value.Item1].First;
                while (search != null)
                {
                    if (search.Value.Id == data.First.Value.Item2)
                    {
                        if (bank.ClientsData[data.First.Value.Item1].Doubtful)
                        {
                            search.Value.RaiseMoney(data.First.Value.Item3);
                            return;
                        }

                        throw new Exception("Account is not dountful");
                    }

                    search = search.Next;
                }

                if (search == null)
                {
                    throw new Exception("Wrond account ID");
                }
            }
        }

        protected void RaiseMoneyUndoFunc(Bank bank, Command commandUndo)
        {
            if (bank.AccountsData.ContainsKey(commandUndo.data.First.Value.Item1))
            {
                var search = bank.AccountsData[commandUndo.data.First.Value.Item1].First;
                while (search != null)
                {
                    if (search.Value.Id == data.First.Value.Item2)
                    {
                        if (bank.ClientsData[data.First.Value.Item1].Doubtful)
                        {
                            search.Value.AddMoney(data.First.Value.Item3);
                            return;
                        }

                        throw new Exception("Account is not dountful");
                    }

                    search = search.Next;
                }

                if (search == null)
                {
                    throw new Exception("Wrond account ID");
                }
            }
        }
    }
}