using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day10
    {
        static List<byte> suffix = new List<byte> { 17, 31, 73, 47, 23 };
        static List<int> list = new List<int>();

        public static void A()
        {
            int currentPos = 0;
            int skipSize = 0;
            int rounds = 1;
            List<int> list = new List<int>();
            var length_A = "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113".Split(new[] { ',' }).Select(i => int.Parse(i)).ToList();

            int size = 256;

            for (int i = 0; i < size; i++) { list.Add(i); }

            var hash = HashFunction(list, currentPos, skipSize, length_A, rounds);

            Console.WriteLine(list[0] * list[1]);
        }

        public static void B()
        {
            string A = "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113";
            int currentPos = 0;
            int skipSize = 0;
            int rounds = 64;
            var length_A = "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113".Split(new[] { ',' }).Select(i => int.Parse(i)).ToList();

            //B
            //List<byte> length_B = new List<byte> { 3, 4, 1, 5, 17, 31, 73, 47, 23 }; //DEBUG
            //List<byte> input = Encoding.ASCII.GetBytes("1,2,3").ToList(); //DEBUG

            List<byte> length_B = PrepareInput(A);



            List<int> sparseHash = HashFunctionB(list, currentPos, skipSize, length_B, rounds);
            List<int> denseHash = DenseHashFunction(sparseHash);
            string knotHash = KnotHash(denseHash);
            Console.WriteLine(knotHash);
        }

        public static List<byte> PrepareInput(string A)
        {
            for (int i = 0; i < 256; i++) { list.Add(i); }
            List<byte> input = Encoding.ASCII.GetBytes(A).ToList();
            var length_B = input.Concat(suffix).ToList();
            return length_B;
        }

        public static string KnotHash(List<int> denseHash)
        {
            StringBuilder knotHash = new StringBuilder();

            foreach (var index in denseHash)
            {
                string foo = Convert.ToByte(index).ToString("x2");
                knotHash.Append(foo);
            }
            return knotHash.ToString();
        }

        public static List<int> DenseHashFunction(List<int> sparseHash)
        {
            List<int> denseHash = new List<int>();
            for (int i = 0; i < 256; i += 16)
            {
                int xor = 0;
                for (int j = i; j < i + 16; j++)
                {
                    xor ^= sparseHash[j];
                }
                denseHash.Add(xor);
            }
            return denseHash;
        }

        public static List<int> HashFunctionB(List<int> list, int currentPos, int skipSize, List<byte> length_B, int rounds)
        {
            for (int round = 0; round < rounds; round++)
            {
                for (int l = 0; l < length_B.Count; l++)
                {
                    if (currentPos + length_B[l] > list.Count)
                    {
                        var foo = list.Skip(currentPos).ToList();
                        var bar = list.Take(currentPos + length_B[l] - list.Count).ToList();
                        var fizz = foo.Concat(bar).Reverse().ToList();

                        int pos = currentPos;

                        for (int j = 0; j < fizz.Count; j++)
                        {
                            list[pos++ % list.Count] = fizz[j];
                        }
                    }
                    else if (length_B[l] > 1)
                    {
                        var foo = list.Skip(currentPos).Take(length_B[l]).Reverse().ToList();

                        int pos = currentPos;

                        for (int j = 0; j < foo.Count; j++)
                        {
                            list[pos++] = foo[j];
                        }
                    }
                    currentPos = (currentPos + length_B[l] + skipSize) % list.Count;
                    skipSize++;
                }
            }
            return list;
        }

        public static List<int> HashFunction(List<int> list, int currentPos, int skipSize, List<int> length, int rounds)
        {

            for (int round = 0; round < rounds; round++)
            {
                for (int l = 0; l < length.Count; l++)
                {
                    if (currentPos + length[l] > list.Count)
                    {
                        var foo = list.Skip(currentPos).ToList();
                        var bar = list.Take(currentPos + length[l] - list.Count).ToList();
                        var fizz = foo.Concat(bar).Reverse().ToList();

                        int pos = currentPos;

                        for (int j = 0; j < fizz.Count; j++)
                        {
                            list[pos++ % list.Count] = fizz[j];
                        }
                    }
                    else if (length[l] > 1)
                    {
                        var foo = list.Skip(currentPos).Take(length[l]).Reverse().ToList();

                        int pos = currentPos;

                        for (int j = 0; j < foo.Count; j++)
                        {
                            list[pos++] = foo[j];
                        }
                    }
                    currentPos = (currentPos + length[l] + skipSize) % list.Count;
                    skipSize++;
                }
            }

            return list;
        }
    }
}
