using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AdventOfCode17
{
    class Day2 : AdventSetup
    {

        public override string Part1()
        {
            return (
                        from line in Input select line.Split("\t") into numbers
                        let max = numbers.Max(n => int.Parse(n))
                        let min = numbers.Min(n => int.Parse(n))
                        select max - min
                    )
                    .Sum()
                    .ToString();
        }


        public override string Part2()
        {
            var numlist = new List<int>();
            foreach (var line in Input)
            {
                numlist.Add(GetNext(line));
            }
            return numlist.Sum().ToString();
        }

        private int GetNext(string line)
        {
            var numbers = line.Split("\t");
            foreach (var n in numbers)
            {
                foreach (var y in numbers)
                {
                    var dn = double.Parse(n);
                    var dy = double.Parse(y);
                    if (dn != dy && IsGoodDivision(dn, dy, out double best))
                    {

                        return Convert.ToInt32(best);
                    }
                }
            }
            return 0;
        }

        public bool IsGoodDivision(double a, double b, out double best)
        {
            var ans1 = a / b;
            var ans2 = b / a;
            best = ans1 > ans2 ? ans1 : ans2;
            return (ans1 % 1) == 0 || (ans2 % 1) == 0;
        }
    }
}
