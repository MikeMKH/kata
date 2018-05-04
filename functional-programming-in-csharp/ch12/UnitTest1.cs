using System;
using Xunit;
using LaYumba.Functional;
using static LaYumba.Functional.StatefulComputation;

namespace ch12
{
    public class UnitTest1
    {
        [Fact]
        public void CounterStartsAtZero()
        {
            var (count, state) = Counter()(0);
            Assert.Equal(0, count);
        }
            
        [Fact]
        public void CounterIncrementsBy1()
        {
            var (count, state) = Counter().Select(c => c + 1)(0);
            Assert.Equal(1, count);
        }
        
        public static StatefulComputation<int, int> Counter()
          => StatefulComputation<int>.Return(0);
    }
}
