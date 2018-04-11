using System;
using Xunit;

// dotnet watch test
namespace ch7
{
    public class UnitTest1
    {
        [Fact]
        public void Ex1()
        {
            Func<int, int, int> remainder = (dividend, divisor) =>
            {
                while(dividend >= divisor) dividend -= divisor;
                return dividend;
            };
            
            Assert.Equal(2, remainder(42, 5));
            
            Func<int, int> remainderBy5 = remainder.ApplyR(5);
            
            Assert.Equal(2, remainderBy5(42));
        }
    }
    
    public static class BinFuncExt
    {
        public static Func<T1, U> ApplyR<T1, T2, U>(this Func<T1, T2, U> func, T2 arg2)
          => arg1 => func(arg1, arg2);
          
        public static Func<T1, T2, U> ApplyR<T1, T2, T3, U>(this Func<T1, T2, T3, U> func, T3 arg3)
          => (arg1, arg2) => func(arg1, arg2, arg3);
    }
}
