using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Drawing;

namespace Adventofcode.Tag._9
{
    class Program
    {
        static Point head = new Point(0,0); // [X-Achse (L/R), Y-Achse (U/D)]
        static Point tail = new Point(0, 0);
        static List<Point> tails = new List<Point>();
        static List<Point> visited = new List<Point>();
        const int taillenght = 9;

        static void Main(string[] args)
        {
            var input = File.ReadAllText("../../input.txt").Split('\n').Where(s => s.Length > 0).ToList();

            // Teil 1
            foreach (var line in input)
                moveHead(line.Split(' ')[0], Convert.ToInt32(line.Split(' ')[1]), false);
            Console.WriteLine(visited.Count); // 5683

            // Teil 2
            visited = new List<Point>();
            for (int i = 0; i < taillenght; i++)
                tails.Add(new Point());
            foreach (var line in input)
                moveHead(line.Split(' ')[0], Convert.ToInt32(line.Split(' ')[1]), true);
            Console.WriteLine(visited.Count); // 2372
        }

        static void moveHead(string direction, int distance, bool longTail)
        {
            for (int i = 0; i < distance; i++)
            {
                switch (direction)
                {
                    case "U":
                        head.Y++;
                        break;
                    case "D":
                        head.Y--;
                        break;
                    case "R":
                        head.X++;
                        break;
                    case "L":
                        head.X--;
                        break;
                    default:
                        throw new NotImplementedException();
                }
                if (!longTail)
                    tail = moveTail(head, tail, true);
                else
                    tails = moveTails(tails);
            }
        }

        static Point moveTail(Point headPoint, Point tailPoint, bool isLastTail)
        {
            var offset = new Point(headPoint.X - tailPoint.X, headPoint.Y - tailPoint.Y);

            if ((Math.Abs(offset.Y) == 2 && Math.Abs(offset.X) >= 1) || (Math.Abs(offset.X) == 2 && Math.Abs(offset.Y) >= 1))
            {
                tailPoint.Y = offset.Y > 0 ? tailPoint.Y + 1 : tailPoint.Y - 1;
                tailPoint.X = offset.X > 0 ? tailPoint.X + 1 : tailPoint.X - 1;
            }
            else if (offset.X > 1 && offset.Y == 0)
                tailPoint.X++;
            else if (offset.X < -1 && offset.Y == 0)
                tailPoint.X--;
            else if (offset.Y > 1 && offset.X == 0)
                tailPoint.Y++;
            else if (offset.Y < -1 && offset.X == 0)
                tailPoint.Y--;

            if (isLastTail && !visited.Contains(tailPoint))
                visited.Add(tailPoint);

            return tailPoint;
        }

        private static List<Point> moveTails(List<Point> points)
        {
            for (int i = 0; i < taillenght; i++)
            {
                if (i == 0)
                    points[i] = moveTail(head, points[i], false);
                else
                    points[i] = moveTail(points[i - 1], points[i], i == taillenght - 1);
            }
            return points;  
        }
    }
}
