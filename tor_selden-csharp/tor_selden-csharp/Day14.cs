using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day14
    {
        static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input14.txt"));

        internal static void A()
        {
            ParseInput();


        }

            private static void ParseInput()
            {
                foreach (var row in input)
                {
                    var temp = row.Split(new[] { ": " }, StringSplitOptions.RemoveEmptyEntries);
                    
                }
            }
    }
}
