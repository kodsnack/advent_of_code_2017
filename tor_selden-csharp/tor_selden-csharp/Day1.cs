using System;
using System.IO;

namespace tor_selden_csharp
{
    class Day1
    {
        static string input = File.ReadAllText(Path.Combine(Program.BasePath, "input1.txt"));
        static int len = input.Length;

        internal static void A()
        {
            double sum = 0;

            for (int i = 0; i < len; i++)
            {
                if (input[i] == input[(i + 1) % len])
                    sum += Char.GetNumericValue(input[i]);
            }
            Console.WriteLine(sum);
        }

        internal static void B()
        {
            double sum = 0;

            for (int i = 0; i < len; i++)
            {
                if (input[i] == input[(i + len/2) % len])
                    sum += Char.GetNumericValue(input[i]);
            }
            Console.WriteLine(sum);

        }
    }
}
