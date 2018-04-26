using System;
using System.Linq;
using LaYumba.Functional;
using static LaYumba.Functional.F;
using FsCheck.Xunit;
using Xunit;
using static ch10.FizzBuzzer;

namespace ch10
{
    public class UnitTest1
    {
        static void AssertOr(FizzBuzzerType statement, params FizzBuzzerType[] tests)
          => Assert.True(tests.Any(test => statement == test));
        
        [Property]
        public void ValueDivisibleBy3MustFizzOrFizzBuzz(int value)
          => AssertOr(
              FizzBuzzer.Create(value * 3).Type,
              FizzBuzzerType.Fizz, FizzBuzzerType.FizzBuzz);
              
        [Property]
        public void ValueDivisibleBy5MustBuzzOrFizzBuzz(int value)
          => AssertOr(
              FizzBuzzer.Create(value * 5).Type,
              FizzBuzzerType.Buzz, FizzBuzzerType.FizzBuzz);
              
        [Property]
        public void ValueDivisibleBy3And5MustFizzBuzz(int value)
          => Assert.Equal(
              FizzBuzzer.Create(value * 3 * 5).Type,
              FizzBuzzerType.FizzBuzz);
              
        [Theory]
        [InlineData(2)]
        [InlineData(4)]
        [InlineData(11)]
        public void ValueNotDivisibleBy3Nor5MustBeOther(int value)
          => Assert.Equal(
              FizzBuzzer.Create(value).Type,
              FizzBuzzerType.Other);
        
        [Property]      
        public void CreateMustAlwaysPassValueBack(int value)
          => Assert.Equal(FizzBuzzer.Create(value).Value, value);
    }
    
    public static class FizzBuzzer
    {
        public enum FizzBuzzerType { Fizz, Buzz, FizzBuzz, Other }
        
        public static (FizzBuzzerType Type, int Value) Create(int value)
        {
            var (isFizz, isBuzz) = (value % 3 == 0, value % 5 == 0);
            
            if ( isFizz &&  isBuzz) return (FizzBuzzerType.FizzBuzz, value);
            if (!isFizz &&  isBuzz) return (FizzBuzzerType.Buzz, value);
            if ( isFizz && !isBuzz) return (FizzBuzzerType.Fizz, value);
            if (!isFizz && !isBuzz) return (FizzBuzzerType.Other, value);
            
            return (FizzBuzzerType.Other, value);  // make the compiler happy
        }
    }
}
