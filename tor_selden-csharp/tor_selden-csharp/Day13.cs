using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day13
    {
        static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input13.txt"));
        static Dictionary<int, (int, List<bool>)> fireWall = new Dictionary<int, (int, List<bool>)>();
        private static Dictionary<int, int> directions = new Dictionary<int, int>();

        public static void A()
        {
            ParseInput();

            int severity = Move(0);
            Console.WriteLine(severity); //A


            for (int delay = 1; delay < 100000; delay++)
            {
                severity = Move(delay);
                if (severity==0)
                {
                    Console.WriteLine(delay);
                }
            }

        }

        private static int Move(int delay)
        {
            int severity = 0;
            int currentPos = -1;
            int time = 0;

            while (currentPos < fireWall.Count-1)
            {
                //Move packet
                if (time>=delay)
                {
                    if(time % 100 == 0) Console.WriteLine(time);
                    currentPos++;
                    if (fireWall[currentPos].Item1 != 0 && fireWall[currentPos].Item2[0] == true)
                    {
                        severity += currentPos * fireWall[currentPos].Item2.Count;
                        if (severity>0) return -1;
                    } 
                }

                //Move sweepers
                foreach (var layer in fireWall.Keys)
                {
                    if (fireWall[layer].Item1 !=0)
                    {
                        int sweeperPos = fireWall[layer].Item2.IndexOf(true);

                        if (sweeperPos == fireWall[layer].Item2.Count - 1 || (sweeperPos == 0 && directions[layer] == -1))
                        {
                            directions[layer] *= -1;
                        }

                        int direction = directions[layer];
                        fireWall[layer].Item2[sweeperPos] = false;
                        fireWall[layer].Item2[sweeperPos + direction] = true; 
                    }
                }
                time++;
            }
            
            return severity;
        }

        private static void ParseInput()
        {
            for (int i = 0; i < 89; i++)
            {
                fireWall.Add(i,(0,null));
                directions.Add(i, 1);
            }

            foreach (var level in input)
            {
                var temp = level.Split(new[] { ": "}, StringSplitOptions.RemoveEmptyEntries);
                int depth = int.Parse(temp[0]);
                int width = int.Parse(temp[1]);
                fireWall[depth]= (1,new List<bool>());

                for (int i = 0; i < width; i++)
                {
                    fireWall[depth].Item2.Add(false);
                }

                foreach (var d in fireWall.Keys)
                {
                    if (fireWall[d].Item1 !=0)
                    {
                        fireWall[d].Item2[0] = true;
                        directions[d] = 1;
                    }
                }
            }
        }
    }
}
