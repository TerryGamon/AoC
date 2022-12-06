using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adventofcode.Tag._3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            
            var input = File.ReadAllText("../../input.txt").Split("\n".ToCharArray());
            var sum = 0;
            
            foreach (var line in input)
            {
                var left = line.Substring(0, line.Length / 2);
                var right = line.Substring(line.Length / 2, line.Length / 2);

                var query = (from ch in left where right.Contains(ch) select ch).Distinct();
                foreach (var c in query)
                    sum += char.IsLower(c) ? c - 96 : c - 38;
            }

            Console.WriteLine(sum); //7581

            var i = 0;
            sum = 0;
            while (true)
            {
                var left = input.Skip(i).Take(3).ToArray();
                if (left.Count() < 3)
                    break;

                var query = (from ch in left[0] where left[1].Contains(ch) && left[2].Contains(ch) select ch).Distinct();
                foreach (var c in query)
                    sum += char.IsLower(c) ? c - 96 : c - 38;

                var right = input.Skip(i+3).Take(3).ToArray();
                query = (from ch in right[0] where right[1].Contains(ch) && right[2].Contains(ch) select ch).Distinct();
                foreach (var c in query)
                    sum += char.IsLower(c) ? c - 96 : c - 38;

                i += 6;
            }

            Console.WriteLine(sum); //2525
        }
    }
}