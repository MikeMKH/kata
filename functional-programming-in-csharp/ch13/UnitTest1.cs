using System;
using System.Threading;
using System.Threading.Tasks;
using LaYumba.Functional;
using static LaYumba.Functional.F;
using Int = LaYumba.Functional.Int;
using String = LaYumba.Functional.String;
using Xunit;
using System.Collections.Generic;
using System.Linq;

namespace ch13
{
    public class UnitTest1
    {
        [Fact]
        public void AsyncCanBeUsedApplicatively()
        {
            Task<double> lowest  = Task.Factory.StartNew(() => 207.11);
            Task<double> highest = Task.Factory.StartNew(() => 505.68);
            
            var cheapest =
              Async(PickLowest)
                .Apply(lowest)
                .Apply(highest);
              
            Assert.Equal(207.11, cheapest.Result);
        }
        
        [Fact]
        public void AsyncCanBeUsedWithBinds()
        {
            Task<double> lowest  = Task.Factory.StartNew(() => 207.11);
            Task<double> highest = Task.Factory.StartNew(() => 505.68);
            
            var cheapest =
              from x in lowest
              from y in highest
              select PickLowest(x, y);
              
            Assert.Equal(207.11, cheapest.Result);
        }
        
        static Func<double, double, double> PickLowest
          = (x, y) => x < y ? x : y;
          
       [Theory]
       [InlineData("1,2,3", new int[] {1, 2, 3})]
       [InlineData("1, 2, 3", new int[] {1, 2, 3})]
       [InlineData("one,2,three", new int[] {})]
       [InlineData(",,", new int[] {})]
       public void GivenStringMustParseToExpectedArray(string given, int[] expected)
       {
           Func<string, IEnumerable<int>> parse =
             s => s
                    .Split(',')
                    .Map(String.Trim)
                    .Traverse(Int.Parse)
                    .GetOrElse(new int[] {});
                    
            Assert.Equal(expected, parse(given));
       }
          
       [Theory]
       [InlineData("1,2,3")]
       [InlineData("1, 2, 3")]
       [InlineData("one,2,three")]
       [InlineData(",,")]
       public void GivenStringMustParseToSameValueIfMonadicOrApplicativeTraversalIsUsed(string given)
       {
           Func<string, IEnumerable<int>> applicative =
             s => s
                    .Split(',')
                    .Map(String.Trim)
                    .TraverseA(Int.Parse)
                    .GetOrElse(new int[] {});
                    
            Func<string, IEnumerable<int>> monadic =
              s => s
                     .Split(',')
                     .Map(String.Trim)
                     .TraverseM(Int.Parse)
                     .GetOrElse(new int[] {});
                    
            Assert.Equal(applicative(given), monadic(given));
       }
       
    //    [Fact]
    //    public void ApplicativeTraversalIsAbleToGiveEachException()
    //    {
    //        var errors = "error 1,2,error 3"
    //                       .Split(',')
    //                       .Map(String.Trim)
    //                       .TraverseA(Int.Parse)
    //                       .Map(Enumerable.Sum)
    //                       .Match(
    //                           errs => string.Join(",", errs),
    //                           sum => $"the sum is {sum}"
    //                       );
                              
    //         Assert.Equal("error 1,error 3", errors);
    //    }
    }
}
