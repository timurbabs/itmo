using System;
using System.Collections.Generic;

namespace Banks
{
    internal class Program
    {
        public static void Main(string[] args)
        {
            try
            {
                var builder = new ClientBuilder();
                builder.AddName("Aaaaaa", "Bbbbbbb");
                builder.AddAddress("*************");
                builder.AddPassport("AB73AAA84A");
                var test = builder.GetClient();

                builder.AddName("Cccccc", "Ddddddd");
                builder.AddAddress("*************");
                builder.AddPassport("KJDKJ838BH2");
                var test2 = builder.GetClient();


                var bankbuilder = new BankBuilder();
                bankbuilder.AddName("aaaaaaa");
                bankbuilder.CreditOptions(20000, 200);
                bankbuilder.DebitOptions(10);
                LinkedList<Tuple<float, DepositType, float>> testDeposit =
                    new LinkedList<Tuple<float, DepositType, float>>();
                testDeposit.AddFirst(Tuple.Create(30000f, DepositType.Less, 3.4f));
                bankbuilder.DepositOptions(testDeposit, DateTime.Now);
                var bank = bankbuilder.GetBank();


                var clientId = bank.AddClient(test);
                var accountId = bank.AddClientAccount(clientId, AccountTypes.Debit);
                var clientId2 = bank.AddClient(test2);
                var accountId2 = bank.AddClientAccount(clientId2, AccountTypes.Debit);

                bank.Command(new AddMoney(clientId, accountId, 20000));
                var undoInfo = bank.Command(new MoveMoney(clientId, accountId, clientId2, accountId2, 15000));
                bank.Undo(undoInfo);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }
    }
}