using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adventofcode.Tag._5
{
    class Program
    {
        static List<string> stacks;

        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input_org.txt").Split('\n');
            stacks = BuildStacks(input);

            foreach(var line in input.Where(l => l.Contains("move")))
                Move(line, false);

            foreach (var stack in stacks)
                Console.Write(string.Join("", stack.Last())); //VWLCWGSDQ bzw. TCGLQSLPW
            Console.WriteLine();
        }

        private static List<string> BuildStacks(string[] input)
        {
            var start = Array.FindIndex(input, line => line.StartsWith(" 1"));
            var nrOfStacks = Convert.ToInt32(input[start].Trim().Last().ToString());
            var stacks = input.Take(start).ToArray();
            var stackBuilder = new List<string>();

            for (int i = 0; i < nrOfStacks; i++)
                stackBuilder.Add(string.Empty);

            foreach (var line in stacks)
            {
                var count = 0;
                for (int i = 1; i <= line.Length; i += 4)
                {
                    var crate = line.ElementAt(i).ToString();
                    if (!string.IsNullOrWhiteSpace(crate))
                        stackBuilder[count]  = crate + stackBuilder[count];
                    count++;
                }
            }
            return stackBuilder;
        }

        private static void Move(string line, bool isMover9001)
        {
            var parts = line.Replace("move", "").Replace("from", "").Replace("to", "").Split(' ');
            var count = Convert.ToInt32(parts[1]);
            var from = Convert.ToInt32(parts[3]) - 1;
            var to = Convert.ToInt32(parts[5]) - 1;

            if (isMover9001)
            {
                var crates = stacks[from].Substring(stacks[from].Length - count, count);
                stacks[from] = stacks[from].Remove(stacks[from].Length - count, count);
                foreach (char crate in crates)
                    stacks[to] += crate;
            }
            else
                for (var i = count; i > 0; i--)
                {
                    var crate = stacks[from].Substring(stacks[from].Length - 1, 1);
                    stacks[from] = stacks[from].Remove(stacks[from].Length - 1, 1);
                    stacks[to] += crate;
                }
        }
    }
}
