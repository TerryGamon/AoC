using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading.Tasks;

namespace Adventofcode.Tag._4
{
    class Program
    {
        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input.txt").Split("\n".ToCharArray());
            var count1 = 0;
            var count2 = 0;
            foreach (var line in input)
            {
                if (string.IsNullOrEmpty(line))
                    break;
                var left = GetNumbers(line.Split(',')[0]);
                var right = GetNumbers(line.Split(',')[1]);

                if (left.Intersect(right).ToList().Count == right.Count || right.Intersect(left).ToList().Count == left.Count)
                    count1++;
                if (left.Intersect(right).ToList().Count > 0 || right.Intersect(left).ToList().Count > 0)
                    count2++;
            }

            Console.WriteLine(count1); //562
            Console.WriteLine(count2); //924
        }

        static List<int> GetNumbers(string s)
        {
            var list = new List<int>();
            var values = s.Split('-');
            for (var i = Convert.ToInt32(values[0]); i <= Convert.ToInt32(values[1]); i++)
                list.Add(i);
            return list;
        }
    }
}
