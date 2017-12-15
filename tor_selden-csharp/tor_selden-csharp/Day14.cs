using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    public static class Day14
    {
        private static List<string> grid = new List<string>();
        public static void A()
        {

            string key = "hxtvlmkl";

            int occupied = 0;
            for (int i = 0; i < 128; i++)
            {
                string a = String.Join(String.Empty,key, "-", i);
                var knotHash = Day10.CalcKnotHash(a);
                string binarystring = String.Join(String.Empty, knotHash.Select(c => Convert.ToString(Convert.ToInt32(c.ToString(), 16), 2).PadLeft(4, '0')));
                occupied += binarystring.Where(b => b == '1').Sum(c => int.Parse(c.ToString()));
                grid.Add(binarystring);
            }

            Console.WriteLine(occupied);
        }

        public static void B()
        {
            var region = 2;
            //First row
            for (int i = 0; i < 128; i++)
            {
                if (grid[0][i] =='1')
                {
                    
                }
            }

            for (int i = 0; i < UPPER; i++)
            {
                
            }

        }


    }
}
