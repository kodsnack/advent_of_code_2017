using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day6
    {

        internal static void AB()
        {
            var input = new List<int> { 14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4 };
            var result = new List<string>();
            int iterations = 0;

            while (!result.HasDuplicates())
            {
                int maxIndex = input.IndexOf(input.Max());
                int blocks = input[maxIndex];
                input[maxIndex] = 0;

                while (blocks > 0)
                {
                    input[++maxIndex % input.Count]++;
                    blocks--;
                }
                result.Add(string.Join(".", input));
                iterations++;
            }

            var duplicates = result
                            .Select((t, i) => new { Index = i, Text = t })
                            .GroupBy(g => g.Text)
                            .Where(g => g.Count() > 1)
                            .SelectMany(g => g, (g, x) => x.Index);

            Console.WriteLine($"A: {iterations}");
            Console.WriteLine($"B: {duplicates.Max() - duplicates.Min()}");
        }
    }
}
