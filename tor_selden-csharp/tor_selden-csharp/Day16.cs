using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day16
    {
        static string[] input = File.ReadAllText(Path.Combine(Program.BasePath, "input16.txt")).Split(new char[] { ',' });
        static int[] programs = new int[16];
        static int[] startPrograms = new int[16];

        internal static void AB()
        {
            for (int i = 'a'; i < 'a' + 16; i++)
            {
                programs[i - 'a'] = (char)i;
                startPrograms[i - 'a'] = (char)i;
            }
            
            //A
            Dance(1);
            var result = programs.Select(p => (char)p).ToArray();
            var endResult = new string(result);
            Console.WriteLine(endResult);

            //B
            int period = CalculatePeriod(1000000000);
            Dance(period);
            result = programs.Select(p => (char)p).ToArray();
            endResult = new string(result);
            Console.WriteLine(endResult);
        }

        private static void Dance(int period)
        {
            for (int i = 0; i < period; i++)
            {
                foreach (var item in input)
                {
                    switch (item[0])
                    {
                        case 's':
                            string value = Regex.Replace(item, "[a-z]", "");
                            var foo = int.Parse(value);
                            Spin(foo);
                            break;
                        case 'x':
                            value = Regex.Replace(item, "[a-z]", "");
                            var command = value.Split(new[] { '/' }).ToArray();
                            Exchange(int.Parse(command[0]), int.Parse(command[1]));
                            break;
                        case 'p':
                            value = item.Substring(1);
                            command = value.Split(new[] { '/' }).ToArray();
                            Partner(Char.Parse(command[0]), Char.Parse(command[1]));
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        private static int CalculatePeriod(int iterations)
        {
            int period = 0;

            do
            {
                Dance(1);
                period++;
            } while (!programs.SequenceEqual(startPrograms));

            return iterations % period;
        }

        private static void Partner(char a, char b)
        {
            var indexA = Array.IndexOf(programs, a);
            var indexB = Array.IndexOf(programs, b);

            var temp = programs[indexA];
            programs[indexA] = programs[indexB];
            programs[indexB] = temp;
        }

        private static void Exchange(int a, int b)
        {
            var temp = programs[a];
            programs[a] = programs[b];
            programs[b] = temp;
        }

        private static void Spin(int x)
        {
            var end = programs.Skip(16 - x).ToArray();
            var newEnd = programs.Take(16 - x).ToArray();
            programs = end.Concat(newEnd).ToArray();
        }
    }
}
