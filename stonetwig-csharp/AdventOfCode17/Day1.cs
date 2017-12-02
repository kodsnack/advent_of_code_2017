using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AdventOfCode17
{
    class Day1 : AdventSetup
    {

        public override string Part1()
        {
            var input = Input.First().ToCharArray().ToList();
            input.Add(input.First());
            var valuesToSum = new List<char>();

            for (var i = 0; i < input.Count; i++)
            {
                if ((i + 1) < input.Count && input[i] == input[i + 1])
                {
                    valuesToSum.Add(input[i]);
                }
            }
            return valuesToSum.Sum(v => int.Parse(v.ToString())).ToString();
        }

        public override string Part2()
        {
            var input = Input.First().ToCharArray().ToList();
            var max = input.Count;
            var n = input.Count / 2;
            var valuesToSum = new List<char>();

            for (var i = 0; i < max; i++)
            {
                if (i + n >= max)
                {
                    if (input[(i + n) - max] == input[i])
                    {
                        valuesToSum.Add(input[(i + n) - max]);
                    }
                }
                else
                {
                    if (input[i + n] == input[i])
                    {
                        valuesToSum.Add(input[i + n]);
                    }
                }
            }

            return valuesToSum.Sum(v => int.Parse(v.ToString())).ToString();
        }
    }
}
