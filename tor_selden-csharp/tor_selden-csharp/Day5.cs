using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day5
    {
        static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input5.txt"));

        internal static void A()
        {
            int[] commands = input.Select(i => int.Parse(i)).ToArray();
            int index = 0;
            int steps = 0;
            while (true)
            {
                try
                {
                    int prevIndex = index;
                    index += commands[index];
                    commands[prevIndex]++;
                    steps++;
                }
                catch (Exception)
                {
                    Console.WriteLine(steps);                    
                    return;
                }
            }
        }

        internal static void B()
        {
            int[] commands = input.Select(i => int.Parse(i)).ToArray();
            int index = 0;
            int steps = 0;
            while (true)
            {
                try
                {
                    int prevIndex = index;
                    index += commands[index];
                    if (commands[prevIndex] >= 3)
                    {
                        commands[prevIndex]--;
                    }
                    else
                    {
                        commands[prevIndex]++;
                    }
                    steps++;
                }
                catch (Exception)
                {
                    Console.WriteLine(steps);
                    return;
                }
            }
        }
    }
}
