using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks.Dataflow;
using Xunit;

namespace ch15
{
    public class UnitTest1
    {
        [Fact]
        public void StatefulAgentMustProcessWhatItIsTold()
        {
            Func<List<int>, int, List<int>> spy =
              (state, message) =>
              {
                  state.Add(message);
                  return state;
              };
            
            var processed = new List<int>();
            var agent = new StatefulAgent<List<int>, int>(processed, spy);
            
            Assert.Empty(processed);
            
            agent.Tell(42);
            agent.Tell(8);
            agent.Tell(42);
            agent.Tell(43);
            
            Assert.Equal(new [] { 42, 8, 42, 43 }, processed);
        }
        
        [Fact]
        public void StatefulAgentCanBeUsedAsCounter()
        {   
            List<int> spy = new List<int>();
            var counter = new StatefulAgent<int, int>(
                0,
                (state, increment) => {
                    spy.Add(state + increment);
                    return state + increment;
                }
            );
            
            Assert.Empty(spy);
            var expected = Enumerable.Range(1, 100).ToList();
            
            expected
              .ForEach(_ => counter.Tell(1));
              
            Assert.Equal(expected, spy);
        }
    }
    
    public interface Agent<Msg>
    {
        void Tell(Msg message);
    }
    
    public class StatefulAgent<State, Msg> : Agent<Msg>
    {
        private State state;
        private readonly ActionBlock<Msg> action;
        
        public StatefulAgent(
            State initial, Func<State, Msg, State> process)
        {
            state = initial;
            
            action = new ActionBlock<Msg>(msg =>
            {
                var next = process(state, msg);
                state = next;
            });
        }
        
        public void Tell(Msg message)
          => action.Post(message);
    }
}
