using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day9
    {

        internal static void A()
        {
            string input = File.ReadAllLines(Path.Combine(Program.BasePath, "input9.txt")).First();
            string parsedInput = ParseInputExclamations(input);
            (string, int) parsedNoGarbage = ParseGarbage(parsedInput);
            int points = CalculatePoints(parsedNoGarbage.Item1);
            Console.WriteLine(points);
            Console.WriteLine(parsedNoGarbage.Item2);
        }

        private static int CalculatePoints(string parsedNoGarbage)
        {
            int points = 0;
            int score = 0;

            for (int i = 0; i < parsedNoGarbage.Length; i++)
            {
                if (parsedNoGarbage[i] == '{')
                {
                    score++;
                }
                else if (parsedNoGarbage[i] == '}')
                {
                    points += score--;
                }
            }
            return points;
        }

        private static (string, int) ParseGarbage(string parsedInput)
        {
            StringBuilder parsedWithoutGarbage = new StringBuilder();
            int garbageSize = 0;

            for (int i = 0; i < parsedInput.Length; i++)
            {
                if (parsedInput[i] == '<')
                {
                    while (parsedInput[++i] != '>') { garbageSize++; }
                }
                parsedWithoutGarbage.Append(parsedInput[i]);
            }
            return (parsedWithoutGarbage.ToString(), garbageSize);
        }


        private static string ParseInputExclamations(string input)
        {
            StringBuilder parsedInput = new StringBuilder();

            for (int i = 0; i < input.Length; i++)
            {
                char symbol = input[i];
                if (symbol == '!')
                {
                    i++;
                    continue;
                }
                parsedInput.Append(symbol);
            }
            return parsedInput.ToString();
        }
    }
}
