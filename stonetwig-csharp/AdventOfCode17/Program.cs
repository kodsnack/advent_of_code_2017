using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace AdventOfCode17
{
    class Program
    {
        static void Main(string[] args)
        {
            var dayToClass = new Dictionary<string, AdventSetup>();
            string s;
            var hello = File.ReadAllText(@"hello.txt", Encoding.UTF8);
            Console.WriteLine("Welcome to stonetwigs Advent of Code solutions for 2017!");
            Console.WriteLine("When you are done enjoying the image below, please follow the instructions...\n\n");
            Console.WriteLine(hello);

            dayToClass.Add("1", new Day1());
            dayToClass.Add("2", new Day2());

            do
            {
                Console.WriteLine($"Write a number from 1-{dayToClass.Count} for the day you want the solution for (or q for exit)!");
                s = Console.ReadLine();
                if (!dayToClass.ContainsKey(s)) continue;
                var chosenDay = dayToClass[s];
                chosenDay.Input = chosenDay.GetInput(s);
                Console.WriteLine($"Final code (day {s}, part 1): {chosenDay.Part1()}");
                Console.WriteLine($"Final code (day {s}, part 2): {chosenDay.Part2()}");
            } while (s.ToLower() != "q");
        }
    }
}
