using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AdventOfCode17
{
    internal class AdventSetup
    {
        public List<string> Input { get; set; }

        public virtual string Part1()
        {
            return "Not yet implemented";
        }
        public virtual string Part2()
        {
            return "Not yet implemented!";
        }

        public virtual List<string> GetInput(string day)
        {
            return System.IO.File.ReadAllLines($@"inputs/day{day}.txt").ToList();
        }
    }
}
