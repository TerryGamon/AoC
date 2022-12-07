using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace Adventofcode.Tag._7
{
    class Programm
    {
        static List<Dir> Dirs = new List<Dir>();

        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input.txt").Split('\n');
            Dir currDir = null;
            Dir fileDir = null;

            foreach(var line in input)
            {
                if(line.StartsWith("$ cd "))
                {
                    var name = line.Substring(5, line.Length - 5);
                    if(name == "..")
                    {
                        currDir = currDir.parrent;
                        continue;
                    }

                    var dir = new Dir(name, currDir);
                    Dirs.Add(dir);
                    currDir = dir;
                }
                else if (line.StartsWith("$ ls"))
                {
                    fileDir = currDir;
                }
                else if (!line.StartsWith("dir ") && !string.IsNullOrWhiteSpace(line))
                {
                    var f = line.Split(' ');
                    fileDir.Size += Convert.ToInt32(f[0]);
                }
            }

            Console.WriteLine(Dirs.Where(d => d.TotalSize <= 100000).Sum(d => d.TotalSize)); //1644735

            int neededSpace = 30000000 - (70000000 - Dirs.Where(d => d.name == "/").Single().TotalSize);
            Console.WriteLine(Dirs.Where(d => d.TotalSize >= neededSpace).OrderBy(d => d.TotalSize).First().TotalSize); //bcnvw 1300850
        }

        class Dir
        {
            public Dir(string name, Dir parrent)
            {
                this.name = name;
                this.parrent = parrent;
            }

            public readonly string name;
            public readonly Dir parrent;
            public int Size;

            public int TotalSize
            {
                get
                {
                    return Size + Dirs.Where(d => d.parrent == this).Sum(s => s.TotalSize);
                }
            }
        }
    }
}
