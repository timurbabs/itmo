using System;

namespace Banks
{
    class MoveMoney : Command
    {
        public MoveMoney(Guid clientId, Guid id, Guid clientId2, Guid id2, float money)
        {
            data.AddLast(new Tuple<Guid, Guid, float>(clientId, id, money));
            data.AddLast(new Tuple<Guid, Guid, float>(clientId2, id2, money));
        }

        public override void Execute(Bank bank)
        {
            if (bank.AccountsData.ContainsKey(data.First.Value.Item1))
            {
                bool accountid = false;
                var search = bank.AccountsData[data.First.Value.Item1].First;
                while (search != null)
                {
                    if (search.Value.Id == data.First.Value.Item2)
                    {
                        if (bank.ClientsData[data.First.Value.Item1].Doubtful)
                        {
                            accountid = true;
                            search.Value.RaiseMoney(data.First.Value.Item3);
                        }
                        else
                        {
                            throw new Exception("Account is not dountful");
                        }
                    }

                    search = search.Next;
                }

                if (accountid == false)
                {
                    throw new Exception("Wrond account ID");
                }
            }

            if (bank.AccountsData.ContainsKey(data.Last.Value.Item1))
            {
                bool accountid = false;
                var search = bank.AccountsData[data.Last.Value.Item1].First;
                while (search != null)
                {
                    if (search.Value.Id == data.Last.Value.Item2)
                    {
                        if (bank.ClientsData[data.Last.Value.Item1].Doubtful)
                        {
                            accountid = true;
                            search.Value.AddMoney(data.Last.Value.Item3);
                        }
                        else
                        {
                            throw new Exception("Account is not dountful");
                        }
                    }

                    search = search.Next;
                }

                if (accountid == false)
                {
                    throw new Exception("Wrond account ID");
                }
            }
        }

        public override void Undo(Bank bank, Command commandUndo)
        {
            bool accountid1 = false;
            if (bank.AccountsData.ContainsKey(commandUndo.data.First.Value.Item1))
            {
                var search = bank.AccountsData[commandUndo.data.First.Value.Item1].First;
                while (search != null)
                {
                    if (search.Value.Id == data.First.Value.Item2)
                    {
                        if (bank.ClientsData[data.First.Value.Item1].Doubtful)
                        {
                            accountid1 = true;
                            search.Value.AddMoney(data.First.Value.Item3);
                        }
                        else
                        {
                            throw new Exception("Account is not dountful");
                        }
                    }

                    search = search.Next;
                }

                if (accountid1 == false)
                {
                    throw new Exception("Wrond account ID");
                }
            }

            if (bank.AccountsData.ContainsKey(commandUndo.data.Last.Value.Item1))
            {
                bool accountid2 = false;
                var search = bank.AccountsData[commandUndo.data.Last.Value.Item1].Last;
                while (search != null)
                {
                    if (search.Value.Id == data.Last.Value.Item2)
                    {
                        if (bank.ClientsData[data.Last.Value.Item1].Doubtful)
                        {
                            accountid2 = true;
                            search.Value.RaiseMoney(data.Last.Value.Item3);
                        }
                        else
                        {
                            throw new Exception("Account is not dountful");
                        }
                    }

                    search = search.Next;
                }

                if (accountid2 == false)
                {
                    throw new Exception("Wrond account ID");
                }
            }
        }
    }
}