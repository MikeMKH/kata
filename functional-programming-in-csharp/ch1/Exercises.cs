using System;
using Xunit;

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
    }
    
    static public class Ex2Ext
    {
        static public Func<T, bool> Negate<T>(this Func<T, bool> predicate)
            => p => !predicate(p);
    }
}
