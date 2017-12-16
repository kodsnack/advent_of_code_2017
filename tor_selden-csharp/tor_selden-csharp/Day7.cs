using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{

    public class Day7
    {
        public static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input7.txt"));
        public static Dictionary<string, (int, string[])> programs = input
            .Select(l => l.Split(new[] { ' ', '(', ')', ',' }, StringSplitOptions.RemoveEmptyEntries))
            .Select(i => new { Key = i[0], Value = int.Parse(i[1]), Subs = i.Length > 3 ? i.Skip(3).ToArray() : new string[0] })
            .ToDictionary(k => k.Key, v => (v.Value, v.Subs));

        public static Dictionary<string, int> totalWeights = new Dictionary<string, int>();

        public static void B()
        {
            string seed = "mkxke";

            foreach (var program in programs)
            {

                var w = TotalWeight(program.Key, program.Value.Item2);
                string res = $"{program.Key},{w}" + Environment.NewLine;
                totalWeights.Add(program.Key, w);
            }

            foreach (var program in programs.Keys)
            {
                if (!IsBalanced(program))
                {
                    foreach (var subProgram in programs[program].Item2)
                    {
                        if (IsBalanced(subProgram))
                        {
                            var x = 1;
                        }
                    }
                }
            }

            foreach (var program in programs.Keys)
            {
                if (totalWeights.Where(b => b.Key == program && programs[program].Item2.Length > 0).Select(w => totalWeights[w.Key]).Distinct().Count() > 1)
                {
                    var foo = 1;
                }
            }
        }

        private static bool IsBalanced(string program)
        {
            return programs[program].Item2.Select(w => totalWeights[w]).Distinct().Count() == 1;
        }

        public static int TotalWeight(string program, string[] subPrograms)
        {
            if (subPrograms.Length > 0)
                return programs[program].Item1 + subPrograms.Sum(w => TotalWeight(w, programs[w].Item2));

            return programs[program].Item1;
        }
    }
}
