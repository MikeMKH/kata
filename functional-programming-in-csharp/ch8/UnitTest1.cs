using System;
using FsCheck;
using FsCheck.Xunit;
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
            var either = Right(add)
              .Apply(3)
              .Apply(2);
              
            Assert.Equal(Right(5), either);
            */
        }
        
        [Property]
        public void ApplicativeLawHoldsForInt(int x, int y, Func<int, int, int> binary)
        {
            var lift = Some(binary)
              .Apply(Some(x))
              .Apply(Some(y));
              
            var map = Some(x)
              .Map(binary)
              .Apply(Some(y));
              
            Assert.Equal(lift, map);
        }
        
        [Property(Arbitrary = new [] { typeof(ArbitraryOption) })]
        public void ApplicativeLawHoldsForOptionInt(Option<int> x, Option<int> y, Func<int, int, int> binary)
        {
            var lift = Some(binary)
              .Apply(x)
              .Apply(y);
              
            var map = x
              .Map(binary)
              .Apply(y);
              
            Assert.Equal(lift, map);
        }
        
        [Property(Arbitrary = new [] { typeof(ArbitraryOption) })]
        public void RightIdentityHoldsForOptionInt(Option<int> m)
        // m == m.Bind(Return)
          => Assert.Equal(m
                         ,m.Bind(Some));
        
        [Property]
        public void LeftIdentityHoldsForOptionInt(int t)
        // Return(t).Bind(f) == f(t)
        {
            Func<int, Option<int>> f = x => Some(x);
            
            Assert.Equal(Some(t).Bind(f)
                        ,f(t));
        }        
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
    
    public static class Ext
    {
        public static Either<L, RR> Apply<L, R, RR>(
            this Either<L, Func<R, Either<L, RR>>> eitherF, Either<L, R> eitherT)
          => eitherT.Bind(t => eitherF.Bind(f => f(t)));
        
        /*
        // no idea
        public static Either<L, Func<T2, R>> Apply<L, T1, T2, R>(
            this Either<L, Func<T1, T2, R>> eitherF, Either<L, T1> eitherT)
          => Apply(eitherF.Map(F.Curry), eitherT);
        */
    }
}
