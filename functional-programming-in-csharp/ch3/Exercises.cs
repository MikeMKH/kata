using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace ch3
{
    public class Exercises
    {
        [Fact]
        public void Ex1()
        {
            // not really sure what they want
            Assert.Equal(
                DayOfWeek.Friday,
                Enum.Parse<DayOfWeek>("Friday"));
        }
        
        [Fact]
        public void Ex2()
        {
            bool isOdd(int i) => i % 2 == 1;
            
            Assert.Equal(
                default(int),
                new List<int>().Lookup(isOdd)
            );
            
            Assert.Equal(
                1,
                new List<int> { 1 }.Lookup(isOdd)
            );
            
            Assert.Equal(
                11,
                new List<int> { 2, 4, 6, 8, 10, 11, 12 }.Lookup(isOdd)
            );
            
            Assert.Equal(
                1,
                new List<int> { 1, 3, 5, 7, 9, 11, 13 }.Lookup(isOdd)
            );
        }
    }
    
    public static class Ex2Ext
    {
        public static Func<T, bool> Negate<T>(this Func<T, bool> f)
          => p => !f(p);
          
        public static T Lookup<T>(this IEnumerable<T> col, Func<T, bool> predicate)
          => col
               .SkipWhile(predicate.Negate())
               .FirstOrDefault();
    }
}
