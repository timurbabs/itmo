using System;
using System.IO;

namespace BackUps
{
    internal static class Program
    {
        public static void Main()
        {
            try
            {
                var a = new Backup("First");
                a.AddFile(@"C:\Users\timur\RiderProjects\Lab_4\aaa.txt");
                a.AddFile(@"C:\Users\timur\RiderProjects\Lab_4\bbb.txt");
                a.AddFullRestorePoint();
                a.AddFullRestorePoint();
                using (var file = new StreamWriter(@"C:\Users\timur\RiderProjects\Lab_4\aaa.txt", true))
                {
                    file.WriteLine("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                }

                a.AddIncrementalRestorePoint();
                a.DeleteFile(@"C:\Users\timur\RiderProjects\Lab_4\aaa.txt");
                a.AddFullRestorePoint();
                a.ShowInfo();
                a.CleanPoints(CleanType.Min, new CountClean(ref a, 3), new SizeClean(ref a, 1690));
                a.ShowInfo();
                a.SetSavePath(@"C:\Users\timur");
                var b = new Backup("Second");
                b.AddFile(@"C:\Users\timur\RiderProjects\Lab_4\ccc.txt");
                b.AddFile(@"C:\Users\timur\RiderProjects\Lab_4\ddd.txt");
                b.AddFullRestorePoint();
                b.AddFullRestorePoint();
                b.CleanPoints(CleanType.Max, new SizeClean(ref b, 40000));
                b.ShowInfo();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }
    }
}