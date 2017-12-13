using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    public static class Extentions
    {
        public static bool HasDuplicates<T>(this IEnumerable<T> list)
        {
            var hashset = new HashSet<T>();
            return list.Any(e => !hashset.Add(e));
        }

        public static int Weight(this string program)
        {
            int weight = int.Parse(program.Split(new[] { '(', ')' }).First());
            return weight;
        }

        public static List<long> Checksum(this string[] line)
        {
            List<long> valid = new List<long>();

            foreach (string word in line)
            {
                long chk = 1;
                foreach (char letter in word)
                {
                    chk *= letter;
                }
                valid.Add(chk);
            }
            return valid;
        }
    }
}