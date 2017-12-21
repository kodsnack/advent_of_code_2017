using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    public class Day14
    {
        private static List<string> grid = new List<string>();
        private static char[,] gridB = new char[128, 128];
        static int z = 0;

        public static void A()
        {
            string key = "hxtvlmkl";

            int occupied = 0;
            for (int i = 0; i < 128; i++)
            {
                string a = String.Join(String.Empty, key, "-", i);
                var knotHash = Day10.CalcKnotHash(a);
                string binarystring = String.Join(String.Empty, knotHash.Select(c => Convert.ToString(Convert.ToInt32(c.ToString(), 16), 2).PadLeft(4, '0')));
                occupied += binarystring.Where(b => b == '1').Sum(c => int.Parse(c.ToString()));
                grid.Add(binarystring);
            }

            Console.WriteLine($"A: {occupied}");
        }

        public static void B()
        {
            ParseGrid();

            int count = NumIslands(gridB);
            Console.WriteLine($"B: {count}");
        }

        private static void ParseGrid()
        {
            for (int i = 0; i < 128; i++)
            {
                for (int j = 0; j < 128; j++)
                {
                    gridB[i, j] = grid[i][j];
                }
            }
        }
        
        public static int NumIslands(char[,] grid)
        {
            var rows = grid.GetLength(0);
            var columns = grid.GetLength(1);

            var visited = new bool[rows, columns];
            var myqueue = new Queue<Tuple<int, int>>();
            var count = 0;

            for (int i = 0; i < rows; i++)
            {
                for (int j = 0; j < columns; j++)
                {
                    if (!visited[i, j] && grid[i, j] == '1')
                    {
                        count++;
                        myqueue.Enqueue(new Tuple<int, int>(i, j));

                        while (myqueue.Count > 0)
                        {
                            var top = myqueue.Dequeue();
                            visited[top.Item1, top.Item2] = true;

                            if (top.Item1 - 1 >= 0 && !visited[top.Item1 - 1, top.Item2] && grid[top.Item1 - 1, top.Item2] == '1' && !myqueue.Contains(new Tuple<int, int>(top.Item1 - 1, top.Item2)))
                            {
                                myqueue.Enqueue(new Tuple<int, int>(top.Item1 - 1, top.Item2));
                            }
                            if (top.Item2 - 1 >= 0 && !visited[top.Item1, top.Item2 - 1] && grid[top.Item1, top.Item2 - 1] == '1' && !myqueue.Contains(new Tuple<int, int>(top.Item1, top.Item2 - 1)))
                            {
                                myqueue.Enqueue(new Tuple<int, int>(top.Item1, top.Item2 - 1));
                            }
                            if (top.Item1 + 1 < rows && !visited[top.Item1 + 1, top.Item2] && grid[top.Item1 + 1, top.Item2] == '1' && !myqueue.Contains(new Tuple<int, int>(top.Item1 + 1, top.Item2)))
                            {
                                myqueue.Enqueue(new Tuple<int, int>(top.Item1 + 1, top.Item2));
                            }
                            if (top.Item2 + 1 < columns && !visited[top.Item1, top.Item2 + 1] && grid[top.Item1, top.Item2 + 1] == '1' && !myqueue.Contains(new Tuple<int, int>(top.Item1, top.Item2 + 1)))
                            {
                                myqueue.Enqueue(new Tuple<int, int>(top.Item1, top.Item2 + 1));
                            }
                        }

                    }
                }
            }
            return count;
        }
    }
}