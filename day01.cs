using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;

namespace Adventofcode.Tag._1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input.txt").Split("\n".ToCharArray());
            var sum = 0;
            var sums = new List<int>();

            foreach (var line in input)
            {
                if (string.IsNullOrEmpty(line))
                {
                    sums.Add(sum);
                    sum = 0;
                    continue;
                }

                sum += Convert.ToInt32(line);
            }
            
            Console.WriteLine(sums.Max()); // --> 70296
            Console.WriteLine(sums.OrderByDescending(i => (int)i).Take(3).Sum()); // --> 205381
        }
    }
}
