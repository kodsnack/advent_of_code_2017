using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day12
    {
        static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input12.txt"));
        static Dictionary<int, List<int>> pipes = new Dictionary<int, List<int>>();
        static List<int> notInAnyGroupYet = new List<int>();
        static List<List<int>> groups = new List<List<int>>();

        internal static void A()
        {
            ParseCommands(pipes);

            for (int i = 0; i < 2000; i++)
            {
                notInAnyGroupYet.Add(i);
            }

            int seed = 0;
            List<int> plumbing = new List<int> { seed };
            Pipe(seed, pipes[seed], plumbing);
            Console.WriteLine($"A: {plumbing.Count}"); //A
            
            //B
            for (int i = 0; i < pipes.Keys.Count; i++)
            {
                if (!notInAnyGroupYet.Contains(i))
                    continue;

                plumbing = new List<int>() { i };
                Pipe(i, pipes[i], plumbing);                
                groups.Add(plumbing);
            }

            Console.WriteLine($"B: {groups.Count()}");
                        
        }

        private static void Pipe(int seed, List<int> list, List<int> plumbing)
        {
            if (new List<int> { seed } == pipes[seed])
                return;

            foreach (var pipe in pipes[seed])
            {
                if (!plumbing.Contains(pipe))
                {
                    plumbing.Add(seed);
                    notInAnyGroupYet.Remove(pipe);
                    Pipe(pipe, pipes[pipe], plumbing);
                }

            }
        }

        private static void ParseCommands(Dictionary<int, List<int>> ConnectedToZero)
        {
            foreach (var line in input)
            {
                var command = line.Split(new[] { " <-> ", ", " }, StringSplitOptions.RemoveEmptyEntries);
                ConnectedToZero.Add(int.Parse(command[0].Trim()), command.Skip(1).Select(s => int.Parse(s.Trim())).ToList());
            }
        }
    }
}
