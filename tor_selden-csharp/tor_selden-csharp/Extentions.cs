using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    public static class Extentions
    {
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
