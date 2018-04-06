using System;
using Xunit;
using LaYumba.Functional;
using static LaYumba.Functional.F;

// dotnet watch test
namespace ch6
{
    public class Exercises
    {
        [Fact]
        public void Ex1()
        {
            // cannot infer the type when var is used
            Either<string, string> left = Left("left");
            Assert.Equal(None, left.ToOption());
            
            Either<string, string> right = Right("right");
            Assert.Equal(Some("right"), right.ToOption());
            
            Option<int> none = None;
            Assert.Equal(Left(42), none.ToEither(left: 42));
            Assert.Equal(Left(default(int)), none.ToEither());
            
            Option<string> some = Some("some");
            Assert.Equal(Right("some"), some.ToEither());
        }
    }
    
    public static class Ext
    {
        public static Option<R> ToOption<L, R>(this Either<L, R> either)
          => either.Match(
              _ => None,
              r => Some(r));
              
        public static Either<T, T> ToEither<T>(this Option<T> option, T left = default(T))
          => option.Match<Either<T, T>>(
              () => Left(left),
              x => Right(x));
    }
}
