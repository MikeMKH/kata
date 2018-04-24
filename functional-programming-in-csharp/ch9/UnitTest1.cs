using System;
using System.Linq;
using System.Collections.Generic;
using FsCheck.Xunit;
using Xunit;

namespace ch9
{
    public class UnitTest1
    {     
        [Theory]
        [InlineData(1)]
        [InlineData(0)]
        [InlineData(100)]
        [InlineData(42)]
        public void Ex1_InsertAt(int at)
          => Assert.Equal(
               "Z"
              ,Enumerable.Repeat("A", 100)
                 .InsertAt(at, "Z").ElementAt(at));
          
        [Theory]
        [InlineData(1)]
        [InlineData(0)]
        [InlineData(99)]
        [InlineData(42)]
        public void Ex1_RemoveAt(int at)
          => Assert.Equal(
               at + 1
              ,Enumerable.Range(0, 100 + 1)
                 .RemovalAt(at).ElementAt(at));
          
        [Theory]
        [InlineData(1)]
        [InlineData(0)]
        [InlineData(99)]
        [InlineData(42)]
        public void Ex1_TakeWhile(int value)
          => Assert.Equal(
               Enumerable.Range(0, 100)
                 .Where(x => x < value)
              ,Enumerable.Range(0, 100)
                 .TakeWhile(x => x < value));
          
        [Theory]
        [InlineData(1)]
        [InlineData(0)]
        [InlineData(99)]
        [InlineData(42)]
        public void Ex1_SkipWhile(int value)
          => Assert.Equal(
               Enumerable.Range(0, 100)
                 .Where(x => x < value)
              ,Enumerable.Range(0, 100)
                 .TakeWhile(x => x < value));
    }
    
    public static class Ext
    {
        public static IEnumerable<T> InsertAt<T>(this IEnumerable<T> source, int index, T elm)
          => source.Take(index)
              .Append(elm)
              .Concat(source.Skip(index));
              
        public static IEnumerable<T> RemovalAt<T>(this IEnumerable<T> source, int index)
          => source.Take(index)
               .Concat(source.Count() <= index
                       ? new List<T>()
                       : source.Skip(index + 1));
    }
}
