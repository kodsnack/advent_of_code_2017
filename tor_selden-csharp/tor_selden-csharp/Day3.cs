using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace tor_selden_csharp
{
    class Day3
    {
        static int xPos = 0;
        static int yPos = 0;

        internal static void A()
        {
            //int memoryLocation = 361527;
            int size = (int)Math.Sqrt(memoryLocation) + 2;
            int[,] memory = CreatMemory(size, memoryLocation);
            int dist = Math.Abs(size / 2 - xPos) + Math.Abs(size / 2 - yPos);
            Console.WriteLine(dist);
        }

        private static int[,] CreatMemory(int size, int memPos)
        {
            int[,] mem = new int[size, size];

            int x = size / 2;
            int y = size / 2;
            int i = 1;
            while (true)
            {
                do
                {
                    if (i == memPos) { xPos = x; yPos = y; return mem; };
                    mem[x, y] = i++;
                    x++;
                } while (mem[x, y - 1] != 0);
                do
                {
                    if (i == memPos) { xPos = x; yPos = y; return mem; };
                    mem[x, y] = i++;
                    y--;
                } while (mem[x - 1, y] != 0);
                do
                {
                    if (i == memPos) { xPos = x; yPos = y; return mem; };
                    mem[x, y] = i++;
                    x--;
                } while (mem[x, y + 1] != 0);
                do
                {
                    if (i == memPos) { xPos = x; yPos = y; return mem; };
                    mem[x, y] = i++;
                    y++;

                } while (mem[x + 1, y] != 0);

            }
        }

        private static void Debug(int[,] mem)
        {
            Console.Clear();
            int len = mem.GetLength(0);
            int j = 0;
            for (int i = 0; i < len; i++)
            {
                for (j = 0; j < len; j++)
                {
                    Console.Write($" {mem[j, i]} ");
                }
                Console.WriteLine();
                j = 0;
            }
        }

        static int memoryLocation = 361527;

        internal static void B()
        {
            int size = (int)Math.Sqrt(memoryLocation) + 10;

            int[,] memory = CreatMemoryB(size, memoryLocation);
            int memPos = memory[xPos, yPos];
            Console.WriteLine(memPos);
        }

        private static int[,] CreatMemoryB(int size, int memPos)
        {
            int[,] mem = new int[size, size];

            int x = size / 2;
            int y = size / 2;
            int i = 1;
            while (true)
            {
                do
                {
                    if (i > memPos) { xPos = x; yPos = y; return mem; };
                    i = Tot(mem, x, y);
                    mem[x, y] = i;
                    x++;
                } while (mem[x, y - 1] != 0);
                do
                {
                    if (i > memPos) { xPos = x; yPos = y; return mem; };
                    i = Tot(mem, x, y);
                    mem[x, y] = i;
                    y--;
                } while (mem[x - 1, y] != 0);
                do
                {
                    if (i > memPos) { xPos = x; yPos = y; return mem; };
                    i = Tot(mem, x, y);
                    mem[x, y] = i;
                    x--;
                } while (mem[x, y + 1] != 0);
                do
                {
                    if (i > memPos) { xPos = x; yPos = y; return mem; };
                    i = Tot(mem, x, y);
                    mem[x, y] = i;
                    y++;

                } while (mem[x + 1, y] != 0);

            }

        }

        private static int Tot(int[,] mem, int x, int y)
        {
            int tot = mem[x + 1, y] + mem[x + 1, y - 1] + mem[x + 1, y + 1] +
                        mem[x, y - 1] + mem[x, y + 1] +
                        mem[x - 1, y - 1] + mem[x - 1, y] + mem[x - 1, y + 1];
            if (tot == 0)
            {
                tot = 1;
            }
            else if (tot >memoryLocation)
            {
                Console.WriteLine(tot);
            }
            return tot;
        }

    }
}
