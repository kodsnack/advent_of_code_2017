using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{

    class Day8
    {
        public static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input8.txt"));
        public static Dictionary<string, int> registers = input.Select(l => l.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)).Select(i => new { Key = i[0], Value = "0" }).Distinct().ToDictionary(w => w.Key, y => int.Parse(y.Value));

        internal static void A()
        {
            int maxValue = 0;
            foreach (string instructions in input)
            {
                string[] instruction = instructions.Split(new[] { ' ' }).Skip(1).Take(2).ToArray();
                string[] condition = instructions.Split(new[] { ' ' }).Skip(4).ToArray();
                string register = instructions.Split(new[] { ' ' }).First();

                if (Condition(condition))
                {
                    switch (instruction[0])
                    {
                        case "inc":
                            registers[register] += int.Parse(instruction[1]);
                            break;
                        case "dec":
                            registers[register] -= int.Parse(instruction[1]);
                            break;
                        default:
                            break;
                    }
                    maxValue = registers.Max(v => v.Value) > maxValue ? registers.Max(v => v.Value) : maxValue;
                }
            }

            Console.WriteLine($"A: { registers.Max(v => v.Value)}");
            Console.WriteLine($"B: {maxValue}");
        }

        private static bool Condition(string[] condition)
        {
            string register = condition[0];
            string op = condition[1];
            int value = int.Parse(condition[2]);

            switch (op)
            {
                case "==":
                    return registers[register] == value;
                case "!=":
                    return registers[register] != value;
                case "<":
                    return registers[register] < value;
                case ">":
                    return registers[register] > value;
                case ">=":
                    return registers[register] >= value;
                case "<=":
                    return registers[register] <= value;
                default:
                    throw new TaskCanceledException();
            }
        }
    }
}
