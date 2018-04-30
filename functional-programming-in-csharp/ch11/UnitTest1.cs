using System;
using Xunit;
using LaYumba.Functional;
using static LaYumba.Functional.F;
using System.Collections.Generic;

namespace ch11
{
    public class UnitTest1
    {
        [Fact]
        public void MapIsLazy()
        {
            var spy = new List<string>();
            Assert.Empty(spy);
            
            Func<string> f = () => { spy.Add("f"); return "f()"; };
            Func<string, string> g = s => { spy.Add("g"); return $"g({s})"; };
            
            Assert.Empty(spy);
            
            Func<string> h = f.Map(g);
            
            Assert.Empty(spy);
            
            var result = h();
            Assert.Equal("g(f())", result);
            
            Assert.NotEmpty(spy);
            Assert.Equal(new List<string> { "f", "g" }, spy);
        }
        
        [Fact]
        public void BindIsLazy()
        {
            var spy = new List<string>();
            Assert.Empty(spy);
            
            Func<string> f = () => { spy.Add("f"); return "f()"; };
            Func<string, Func<string>> g = s => { spy.Add("g"); return () => $"g({s})"; };
            
            Assert.Empty(spy);
            
            Func<string> h = f.Bind(g);
            
            Assert.Empty(spy);
            
            var result = h();
            Assert.Equal("g(f())", result);
            
            Assert.NotEmpty(spy);
            Assert.Equal(new List<string> { "f", "g" }, spy);
        }
        
        [Fact]
        public void GetOrElseIsLazy()
        {
            var spy = new List<string>();
            Assert.Empty(spy);
            
            Func<string> fallback = () => { spy.Add("fallback"); return "fallback"; };
            
            Assert.Empty(spy);
            
            Some("thing important!").GetOrElse(fallback);
            Assert.Empty(spy);
            
            Option<string> none = None;
            none.GetOrElse(fallback);
            
            Assert.NotEmpty(spy);
            Assert.Equal(new List<string> { "fallback" }, spy);
        }
    }
}
