using System;
using Xunit;

// dotnet watch test
namespace ch5
{
    public class UnitTest1
    {
        [Fact]
        public void Ex3()
        {
            Func<bool, int> toInt = b => b ? 1 : 0;
            Func<int, string> toStr = i => i.ToString();
            
            var foo = toInt.Compose(toStr);
            Assert.Equal("1", foo(true));
            Assert.Equal("0", foo(false));
            
            Assert.Equal(
                "85",
                ((Func<int, int>)(x => x + 42)).Compose(x => x.ToString())(43));
        }
    }
    
    public static class FuncExt
    {
        public static Func<T, V> Compose<T, U, V>(this Func<T, U> f, Func<U, V> g)
          => t => g(f(t));
    }
}
