using System;
using System.IO;
using System.Linq;

namespace tor_selden_csharp
{
    class Day2
    {
        static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input2.txt"));
        static int len = input.Length;

        internal static void A()
        {
            int checksum = 0;
            foreach (var line in input)
            {
                var row = line.Split(new char[] { '\t' }, StringSplitOptions.RemoveEmptyEntries).Select(i => int.Parse(i)).ToList();
                var row_chk = row.Max() - row.Min();
                checksum += row_chk;
            }
            Console.WriteLine(checksum);
        }

        internal static void B()
        {
            int checksum = 0;
            foreach (var line in input)
            {
                var row = line.Split(new char[] { '\t' }, StringSplitOptions.RemoveEmptyEntries).Select(i => int.Parse(i)).ToList();
                for (int i = 0; i < row.Count; i++)
                {
                    for (int j = 0; j < row.Count; j++)
                    {
                        if ((row[i] % row[j] == 0) && i != j)
                        {
                            checksum += row[i] / row[j];
                        }
                    }
                }
            }
            Console.WriteLine(checksum);
        }
    }
}
