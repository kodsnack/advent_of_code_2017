using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace tor_selden_csharp
{
    class Day15
    {
        public static int modulo = 2147483647;
        static int x = 0;

        internal static void A()
        {
            var genA = new Generator { Factor = 16807, Value = 634 };
            var genB = new Generator { Factor = 48271, Value = 301 };

            int score = 0;
            for (int i = 0; i < 40000000; i++)
            {
                var tempA = ((uint)genA.Value * genA.Factor) % modulo;
                var tempB = ((uint)genB.Value * genB.Factor) % modulo;
                genA.Value = (int)tempA;
                genB.Value = (int)tempB;

                score += CompareGenerators(genA.Value, genB.Value);
            }
            Console.WriteLine(score);
        }

        internal static void B()
        {
            var genA = new Generator { Factor = 16807, Value = 634 };
            var genB = new Generator { Factor = 48271, Value = 301 };

            int score = 0;
            bool validA = false;
            bool validB = false;
            var qA = new Queue<int>();
            var qB = new Queue<int>();

            while (x<5000000)
            {
                var tempA = ((uint)genA.Value * genA.Factor) % modulo;
                var tempB = ((uint)genB.Value * genB.Factor) % modulo;

                validA = tempA % 4 == 0;
                validB = tempB % 8 == 0;

                if (validA)
                    qA.Enqueue((int)tempA);

                if (validB)
                    qB.Enqueue((int)tempB);

                genA.Value = (int)tempA;
                genB.Value = (int)tempB;

                if (qA.Count > 0 && qB.Count > 0)
                {
                    x++;
                    var a = qA.Dequeue();
                    var b = qB.Dequeue();
                    score += CompareGenerators(a, b);
                }
            }
            Console.WriteLine(score);
        }

        private static int CompareGenerators(int genA, int genB)
        {            
            BitArray a = new BitArray(new int[] { genA });
            BitArray b = new BitArray(new int[] { genB });

            for (int i = 0; i < 16; i++)
            {
                if (a[i] != b[i])
                    return 0;
            }
            return 1;
        }
    }

    class Generator
    {
        public int Factor { get; set; }
        public int Value { get; set; }
    }
}
