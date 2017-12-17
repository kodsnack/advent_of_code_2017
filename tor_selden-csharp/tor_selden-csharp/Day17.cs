using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day17
    {
        static int steps = 363;
        static List<int> buffer = new List<int> { 0 };
        static LinkedList<int> linkedBuffer = new LinkedList<int>();

        internal static void A()
        {
            int currentPos = 0;

            for (int i = 1; i < 2018; i++)
            {
                currentPos = (currentPos + steps) % buffer.Count;
                buffer.Insert(++currentPos, i);
            }

            var resultPos = (buffer.IndexOf(2017) + 1) % buffer.Count;
            var result = buffer[resultPos];

            Console.WriteLine(result);
        }

        internal static void B()
        {
            int currentPos = 0;
            int zeroPos = 0;
            int result = 0;

            for (int i = 1; i <= 50000000; i++)
            {
                currentPos = (currentPos + steps) % (i );
                if (currentPos < zeroPos)
                {
                    zeroPos++;
                }
                else if (currentPos == zeroPos)
                {
                    result = i;
                }
                currentPos++;
            }

            Console.WriteLine(result);
        }
    }
}
