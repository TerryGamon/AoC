using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace Adventofcode.Tag._8
{
    static class Program
    {
        static int[][] forrest;

        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input.txt");
            var length = input.Split('\n').First().Length;  // Breite der Matrix: 100

            forrest = input
              .Where(l => !string.IsNullOrWhiteSpace(l.ToString()))
              .Select((s, i) => new { Tree = int.Parse(s.ToString()), Pos = i })
              .GroupBy(at => at.Pos / length, at => at.Tree, (x, y) => y.ToArray())
              .ToArray();

            Console.WriteLine(forrest.Select((row, x) => row.Select((_, y) => 
                IsVisible(forrest, x, y))).SelectMany(tree => tree).Count(tree => tree)); //   1845

            Console.WriteLine(forrest.Select((row, x) => row.Select((_, y) 
                    => Multiply(forrest, x, y))).SelectMany(tree => tree).Max(tree => tree)); // 230112
        }

        static bool IsVisible(this int[][] trees, int x, int y) =>
            Enumerable.Range(0, y).Select(i => trees[x][i]).All(t => t < trees[x][y]) || // Ost
            Enumerable.Range(0, x).Select(i => trees[i][y]).All(t => t < trees[x][y]) || // Süd
            Enumerable.Range(x, trees.Length - x).Select(i => trees[i][y]).Skip(1).All(t => t < trees[x][y]) || // West
            Enumerable.Range(y, trees[0].Length - y).Select(i => trees[x][i]).Skip(1).All(t => t < trees[x][y]); // Nord

        static int Multiply(int[][] trees, int x, int y) =>
            Enumerable.Range(0, y).Select(i => trees[x][i]).Reverse().TakeWhile(t => t >= trees[x][y]).Count() *
            Enumerable.Range(0, x).Select(i => trees[i][y]).Reverse().TakeWhile(t => t >= trees[x][y]).Count() *
            Enumerable.Range(x, trees.Length - x).Select(i => trees[i][y]).Skip(1).TakeWhile(t => t >= trees[x][y]).Count() *
            Enumerable.Range(y, trees[0].Length - y).Select(i => trees[x][i]).Skip(1).TakeWhile(t => t >= trees[x][y]).Count();
    }

    static class ExtensionMethod
    {
        public static IEnumerable<T> TakeWhile<T>(this IEnumerable<T> source, Func<T, bool> predicate)
        {
            foreach (T item in source)
            {
                if (!predicate(item))
                {
                    yield return item;
                }
                else
                {
                    yield return item;
                    yield break;
                }
            }
        }
    }
}
