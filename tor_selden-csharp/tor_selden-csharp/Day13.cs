using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace tor_selden_csharp
{
    class Day13
    {
        
        static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input13.txt"));

        static Dictionary<int, int> fireWall = new Dictionary<int, int>();

        public static void AB()
        {            
            ParseInput();

            //A
            var serverity = fireWall.Where(l => Caught(l.Key, 0)).Sum(c => c.Key * c.Value);
            Console.WriteLine(serverity); 
            
            //B
            bool isCaught = true;
            int delay = 1;
            while (isCaught)
            {
                isCaught = false;
                foreach (int layer in fireWall.Keys)
                {
                    if (Caught(layer, delay))
                    {
                        isCaught = true;
                        break;
                    }
                }
                if (!isCaught)
                {
                    Console.WriteLine(delay);
                }
                delay++;
            }
        }

        private static bool Caught(int layer, int delay)
        {
            int enterTime = layer + delay;
            int period = (fireWall[layer] - 1) * 2;
            int state = enterTime % period;
            return state == 0;
        }

        private static void ParseInput()
        {
            foreach (var layer in input)
            {
                var temp = layer.Split(new[] { ": " }, StringSplitOptions.RemoveEmptyEntries);
                int depth = int.Parse(temp[0]);
                int width = int.Parse(temp[1]);
                fireWall.Add(depth, width);
            }
        }        
    }
}