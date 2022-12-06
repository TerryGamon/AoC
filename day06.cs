using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adventofcode.Tag._6
{
    class Program
    {
        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input.txt");
            FindMarker(input);
            FindMarker(input, 14);
        }

        private static void FindMarker(string input, int minCount = 4)
        {
            for (int i = 0; i < input.Length; i++)
            {
                var part = input.Skip(i).Take(minCount);
                if (part.Distinct().Count() == minCount)
                {
                    Console.WriteLine(i + minCount); // 1080 bzw. 3645
                    break;
                }
            }
        }
    }
}
