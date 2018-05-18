using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace PrimeFactors
{
    public class PrimeFactorsTests
    {
        [Theory]
        [InlineData(2, new [] {2})]
        [InlineData(3, new [] {3})]
        [InlineData(5, new [] {5})]
        [InlineData(7, new [] {7})]
        [InlineData(11, new [] {11})]
        [InlineData(13, new [] {13})]
        public void GivenPrimeNumberItMustReturnSelf(int prime, int[] expected)
          => Assert.Equal(expected, prime.PrimeFactors());
        
        [Theory]
        [InlineData(new [] { 2, 3 })]
        [InlineData(new [] { 2, 5 })]
        [InlineData(new [] { 2, 7, 11, 17, 23 })]
        public void GivenNumberWhichIsFactorOfDifferentPrimesItMustReturnThem(int [] factors)
          => Assert.Equal(factors, factors.Product().PrimeFactors());
        
        [Theory]
        [InlineData(new [] { 2, 2 })]
        [InlineData(new [] { 3, 3 })]
        [InlineData(new [] { 2, 2, 3, 3, 5, 5, 7, 7, 11, 11 })]
        public void GivenNumberWhichHasRepeatedPrimesItMustReturnThem(int [] factors)
          => Assert.Equal(factors, factors.Product().PrimeFactors());
    }
    
    public static class PrimeFactorsExt
    {
        private static readonly IEnumerable<int> Primes = 
          new[] { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97 };
        public static IEnumerable<int> PrimeFactors(this int source)
          => Primes.Aggregate(
              (source, new List<int>()),
              ((int n, List<int> factors) m, int p) =>
              {
                while (m.n % p == 0)
                {
                  m.factors.Add(p);
                  m.n /= p;
                }
                
                return (m.n, m.factors);
              }).Item2;
        
        public static int Product(this IEnumerable<int> source)
          => source.Aggregate(1, (m, x) => m * x);
    }
}
