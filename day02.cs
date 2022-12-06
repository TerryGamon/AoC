using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace Adventofcode.Tag._2
{
    internal class Program
    {
        enum ABC
        {
            A = 1, // Rock 
            B = 2, // Paper
            C = 3, // Scissors
        }

        enum XYZ
        {
            X = 1, // Rock 
            Y = 2, // Paper
            Z = 3  // Scissors
        }

        static void Main(string[] args)
        {
            var games = File.ReadAllLines("..\\..\\input.txt");
            Console.WriteLine(games.Sum(game => GetPoints(game.Split(" ".ToCharArray())))); // 12535
            Console.WriteLine(games.Sum(game => DecideAnGetPoints(game.Split(" ".ToCharArray())))); // 15457
        }

        private static int GetPoints(string[] values)
        {
            var points = new PointDouble(values);
            var left = points.Left;
            var right = points.Right;

            if ((int)left == (int)right) //Draw
            {
                return (int)right + 3;
            }

            if (left == ABC.A && right == XYZ.Z || left == ABC.B && right == XYZ.X || left == ABC.C && right == XYZ.Y) //Loss
                return (int)right;
            
            return (int)right + 6; // Won
        }

        private static int DecideAnGetPoints(string[] values)
        {
            var points = new PointDouble(values);
            var left = points.Left;
            var right = points.Right;

            if(right == XYZ.Y) //Draw
                return GetPoints(new []{points.Left.ToString(), ConvertEnum(points.Left).ToString()});

            if (right == XYZ.X) //Lose
            {
                if(left == ABC.A)
                    return GetPoints(new []{points.Left.ToString(), XYZ.Z.ToString()});
                if(left == ABC.B)
                    return GetPoints(new []{points.Left.ToString(), XYZ.X.ToString()});
                return GetPoints(new []{points.Left.ToString(), XYZ.Y.ToString()});
            }
            
            //Win
            if(left == ABC.A)
                return GetPoints(new []{points.Left.ToString(), XYZ.Y.ToString()});
            if(left == ABC.B)
                return GetPoints(new []{points.Left.ToString(), XYZ.Z.ToString()});
            return GetPoints(new []{points.Left.ToString(), XYZ.X.ToString()});
    }

        private class PointDouble
        {
            public PointDouble(string[] values)
            {
                Left = ParseEnum<ABC>(values[0]);
                Right = ParseEnum<XYZ>(values[1]);
            }

            public ABC Left { get; }

            public XYZ Right { get; }
        }

        private static XYZ ConvertEnum(ABC input)
        {
            if (input == ABC.A)
                return XYZ.X;
            if (input == ABC.B)
                return XYZ.Y;
            return XYZ.Z;
        }

        private static T ParseEnum<T>(string value)
        {
            return (T) Enum.Parse(typeof(T), value, true);
        }
    }
}
