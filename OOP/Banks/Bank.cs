using System.Collections.Generic;
using System;
using Banks;

public enum AccountTypes
{
    Deposit,
    Debit,
    Credit
}

namespace Banks
{
    public class Bank
    {
        public Guid Id { get; } = Guid.NewGuid();
        public string Name;
        public Dictionary<Guid, Client> ClientsData = new Dictionary<Guid, Client>();
        public Dictionary<Guid, LinkedList<Account>> AccountsData = new Dictionary<Guid, LinkedList<Account>>();
        public readonly LinkedList<Command> Commands = new LinkedList<Command>();
        public Creator DebitFabric;
        public Creator DepositFabric;
        public Creator CreditFabric;

        public Guid AddClient(Client client)
        {
            var temp = Guid.NewGuid();
            if (AccountsData.ContainsKey(temp))
            {
                throw new Exception("This client already added.");
            }
            else
            {
                var tempClient = (Client) client.Clone();
                tempClient.Id = temp;
                ClientsData.Add(temp, tempClient);
                AccountsData.Add(temp, new LinkedList<Account>());
                return temp;
            }
        }

        public Guid AddClientAccount(Guid clientId, AccountTypes type)
        {
            if (type == AccountTypes.Credit)
            {
                LinkedList<Account> accounts;
                if (AccountsData.ContainsKey(clientId))
                {
                    AccountsData.TryGetValue(clientId, out accounts);
                    var account = CreditFabric.FactoryMethod();
                    accounts.AddFirst(account);
                    return account.Id;
                }
                else
                {
                    throw new Exception("Don't have such clientId");
                }
            }
            else if (type == AccountTypes.Debit)
            {
                LinkedList<Account> accounts;
                if (AccountsData.ContainsKey(clientId))
                {
                    AccountsData.TryGetValue(clientId, out accounts);
                    var account = DebitFabric.FactoryMethod();
                    accounts.AddFirst(account);
                    return account.Id;
                }
                else
                {
                    throw new Exception("Don't have such clientId");
                }
            }
            else if (type == AccountTypes.Deposit)
            {
                LinkedList<Account> accounts;
                if (AccountsData.ContainsKey(clientId))
                {
                    var account = DepositFabric.FactoryMethod();
                    AccountsData.TryGetValue(clientId, out accounts);
                    accounts.AddFirst(account);
                    return account.Id;
                }
                else
                {
                    throw new Exception("Don't have such clientId");
                }
            }
            else
            {
                throw new Exception("Wrong type");
            }
        }

        public Guid Command(Command command)
        {
            command.Id = Guid.NewGuid();
            Commands.AddLast(command);
            command.Execute(this);
            return command.Id;
        }

        public void Undo(Guid id)
        {
            var temp = Commands.First;
            bool check = true;
            while (temp != null)
            {
                if (temp.Value.Id == id)
                {
                    check = false;
                    temp.Value.Undo(this, temp.Value);
                    Commands.Remove(temp);
                }

                temp = temp.Next;
            }

            if (check)
            {
                throw new Exception("Don't have such command");
            }
        }
    }
}