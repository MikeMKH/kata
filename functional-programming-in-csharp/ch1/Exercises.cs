using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

// dotnet watch test
namespace ch1
{
    public class Exercises
    {
        [Fact]
        public void Ex2()
        {
            Func<bool, bool> truth = x => true;
            Func<bool, bool> falsehood = x => false;
            
            Assert.True(falsehood.Negate()(true));
            Assert.False(truth.Negate()(true));
            Assert.True(falsehood.Negate()(false));
            Assert.False(truth.Negate()(false));
        }
        
        [Fact]
        public void Ex3()
        {
            Assert.Equal(new int[]{}, (new int[]{}).QuickSort());
            
            var one = new [] {1};
            Assert.Equal(one.OrderBy(x => x), one.QuickSort());
            
            var twoOrdered = new [] {1, 2};
            Assert.Equal(twoOrdered.OrderBy(x => x), twoOrdered.QuickSort());
            
            var twoUnordered = new [] {2, 1};
            Assert.Equal(twoUnordered.OrderBy(x => x), twoUnordered.QuickSort());
            
            var lots = new [] {2, 1, -1, 2, 3, 4, 12, -9, 0, 6, 42};
            Assert.Equal(lots.OrderBy(x => x), lots.QuickSort());
        }
        
        [Fact]
        public void Ex4()
        {
            Assert.Equal(new string[]{}, (new string[]{}).QuickSort(StringComparer.Ordinal));
            
            var one = new [] {"1"};
            Assert.Equal(one.OrderBy(x => x), one.QuickSort());
            
            var twoSame = new [] {"one", "One"};
            Assert.Equal(
                twoSame.OrderBy(x => x, StringComparer.OrdinalIgnoreCase),
                twoSame.QuickSort(StringComparer.OrdinalIgnoreCase));
            
            var twoUnordered = new [] {false, true};
            Assert.Equal(twoUnordered.OrderBy(x => x), twoUnordered.QuickSort());
        }
    }
    
    static public class Ex2Ext
    {
        static public Func<T, bool> Negate<T>(this Func<T, bool> predicate)
            => p => !predicate(p);
    }
    
    static public class QuickSortExt
    {
        static public IList<T> QuickSort<T>(this IList<T> list, IComparer<T> comparer = null)
        {
            if (comparer == null)
              comparer = Comparer<T>.Default;
              
            if (list.Count() < 1)
              return list;
              
            var pivot = list[0];
            var rest = list.Skip(1);
            
            var left = rest.Where(x => comparer.Compare(x, pivot) < 0);
            var right = rest.Where(x => comparer.Compare(x, pivot) >= 0);
            
            return left.ToList().QuickSort(comparer)
              .Append(pivot)
              .Concat(right.ToList().QuickSort(comparer))
              .ToList();
        }
    }
    
}
