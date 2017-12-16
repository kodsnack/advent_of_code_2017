using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day4
    {
        static string[] input = File.ReadAllLines(Path.Combine(Program.BasePath, "input4.txt"));

        internal static void A()
        {
            var valid = input.Where(p => p.Split(new[] { ' ' }).Distinct().Count() == p.Split(new[] { ' ' }).Count()).Select(p => p).Count();
            Console.WriteLine(valid);
        }

        internal static void B()
        {            
            var valid = input.Where(p => p.Split(new[] { ' ' }).Checksum().Distinct().Count() == p.Split(new[] { ' ' }).Checksum().Count()).Select(p => p).Count();
            Console.WriteLine(valid);
        }
    }
}



