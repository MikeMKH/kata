using System;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;
using LaYumba.Functional;
using static LaYumba.Functional.F;
using Int = LaYumba.Functional.Int;
using String = LaYumba.Functional.String;
using Xunit;
using FsCheck.Xunit;
using FsCheck;

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
       
       [Fact]
       public void ApplicativeTraversalIsAbleToHandleExceptions()
       {
           var errors = "error 1,2,error 3"
                          .Split(',')
                          .Map(String.Trim)
                          .TraverseA(Int.Parse)
                          .Map(Enumerable.Sum)
                          .Match(
                              () => "string contains non-int values",
                              sum => $"sum is {sum}"
                          );
                              
            Assert.NotEqual("sum is 6", errors);
            Assert.Equal("string contains non-int values", errors);
       }
       
       [Fact]
       public void ValidationApplicativeTraversalIsAbleToGetAllExceptions()
       {
           Func<string, Validation<int>> isInt =
             s => Int.Parse(s)
                     .Match(
                         () => Error($"invalid number {s}"),
                         x => Valid(x)
                     );
                     
            Assert.Equal(Error("invalid number error"), isInt("error"));
            Assert.Equal(Valid(7), isInt("7"));
           
           var errors = "error 1,2,error 3"
                          .Split(',')
                          .Map(String.Trim)
                          .TraverseA(isInt)
                          .Map(Enumerable.Sum)
                          .Match(
                              errs => string.Join(", ", errs),
                              sum => $"sum is {sum}"
                          );
                              
            Assert.NotEqual("sum is 6", errors);
            Assert.Equal("invalid number error 1, invalid number error 3", errors);
       }
       
       [Property(Arbitrary = new [] { typeof(ArbitraryOption) })]
       public void TraverseSwitchesMonadicStacking(Option<int>[] stack)
       { 
           // not sure how to get FsCheck to give me an IEnumerable
           Assert.IsType(typeof(Option<int>[]), stack);
           Assert.IsType(typeof(Option<IEnumerable<int>>), stack.Traverse(x => x));
       }
       
       public static class ArbitraryOption
       {
           public static Arbitrary<Option<T>> Option<T>()
             => (from isSome in Arb.Generate<bool>()
                 from value in Arb.Generate<T>()
                 select isSome && value != null
                        ? Some(value)
                        : None
               ).ToArbitrary();
       }
    }
}
