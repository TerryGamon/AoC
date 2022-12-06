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
        /*
            [V]     [B]                     [C]
            [C]     [N] [G]         [W]     [P]
            [W]     [C] [Q] [S]     [C]     [M]
            [L]     [W] [B] [Z]     [F] [S] [V]
            [R]     [G] [H] [F] [P] [V] [M] [T]
            [M] [L] [R] [D] [L] [N] [P] [D] [W]
            [F] [Q] [S] [C] [G] [G] [Z] [P] [N]
            [Q] [D] [P] [L] [V] [D] [D] [C] [Z]
             1   2   3   4   5   6   7   8   9 
        */

        static List<string> stacks = new List<string> {
                "QFMRLWCV",
                "DQL",
                "PSRGWCNB",
                "LCDHBQG",
                "VGLFZS",
                "DGNP",
                "DZPVFCW",
                "CPDMS",
                "ZNWTVMPC"
            };

        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input.txt").Split('\n');
            
            foreach(var line in input)
                Move(line, true);

            foreach (var stack in stacks)
                Console.Write(string.Join("", stack.Last())); //VWLCWGSDQ bzw. TCGLQSLPW
            Console.WriteLine();
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
