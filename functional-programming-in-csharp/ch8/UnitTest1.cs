using System;
using Xunit;
using LaYumba.Functional;
using static LaYumba.Functional.F;

namespace ch8
{
    public class UnitTest1
    {
        [Fact]
        public void Ex1()
        {
            Func<int, int, int> add = (x, y) => x + y;

            var option = Some(add)
              .Apply(3)
              .Apply(2);
              
            Assert.Equal(Some(5), option);
            
            /*
            var either = Left(add)
              .Apply(3)
              .Apply(2);
              
            Assert.Equal(Left(5), either);
            */
        }
    }
    
    public static class Ext
    {
        public static Either<L, RR> Apply<L, R, RR>(
            this Either<L, Func<R, Either<L, RR>>> eitherF, Either<L, R> eitherT)
          => eitherT.Bind(t => eitherF.Bind(f => f(t)));
        
        // no idea
        // public static Either<L, Func<T2, R>> Apply<L, T1, T2, R>(
        //     this Either<L, Func<T1, T2, R>> eitherF, Either<L, T1> eitherT)
        //   => Apply(eitherF.Map(F.Curry), eitherT);
    }
}
