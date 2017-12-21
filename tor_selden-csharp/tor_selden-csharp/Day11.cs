using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    public class Point
    {
        int x;
        int y;
        int z;

        public Point(int x, int y, int z)
        {
            this.x = x;
            this.y = y;
            this.z = z;
        }

        public int Distance(Point b)
        {
            return (Math.Abs(x - b.x) + Math.Abs(y - b.y) + Math.Abs(z - b.z)) / 2;            
        }
    }

    class Day11
    {
        static string input = File.ReadAllText(Path.Combine(Program.BasePath, "input11.txt"));

        public static void AB()
        {
            var directions = input.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();

            int x = 0;
            int y = 0;
            int z = 0;
            int maxDist = 0;

            var p1 = new Point(x, y, z);

            foreach (var direction in directions)
            {
                switch (direction)
                {
                    case "n":
                        y++;
                        z--;
                        break;
                    case "ne":
                        x++;
                        z--;
                        break;
                    case "se":
                        ++x;
                        --y;
                        break;
                    case "s":
                        y--;
                        z++;
                        break;
                    case "sw":
                        x--;
                        z++;
                        break;
                    case "nw":
                        y++;
                        x--;
                        break;
                    default:
                        break;
                }

                var temp = new Point(x, y, z);
                maxDist = p1.Distance(temp) > maxDist ? p1.Distance(temp) : maxDist;

            }

            var p2 = new Point(x, y, z);

            var dist = p1.Distance(p2);

            Console.WriteLine(dist); //A
            Console.WriteLine(maxDist); //B
        }        
    }
}
