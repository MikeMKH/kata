using System;
using System.Threading;
using System.Threading.Tasks;
using LaYumba.Functional;
using static LaYumba.Functional.F;
using Xunit;

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
    }
}
