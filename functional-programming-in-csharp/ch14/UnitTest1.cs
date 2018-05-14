using System;
using System.Reactive.Linq;
using System.Reactive.Subjects;
using Xunit;

namespace ch14
{
    public class UnitTest1
    {   
        [Fact]
        public void CanSpyOnObserable()
        {
            var inputs = new Subject<int>();
            
            var error = false;
            var done = false;
            Assert.False(error);
            Assert.False(done);
            
            using(inputs.Spy(
                next: t => Assert.Equal(5, t),
                error: e => error = true,
                done: () => done = true))
            {
                inputs.OnNext(5);
                inputs.OnNext(5);
                inputs.OnCompleted();
            }
            
            Assert.False(error);
            Assert.True(done);
        }
    }
    
    public static class ReactiveExt
    {   
        public static IDisposable Spy<T>(
            this IObservable<T> source, Action<T> next, Action<Exception> error, Action done)
          => source.Subscribe(
              onNext: t => next(t),
              onError: e => error(e),
              onCompleted: () => done()
          );
    }
}
