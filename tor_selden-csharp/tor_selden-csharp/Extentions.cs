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

        //public static bool IsBalanced(this string program)
        //{
        //    if (!String.IsNullOrEmpty(program))
        //    {

        //    }
        //    return true;
        //}
    }
}
