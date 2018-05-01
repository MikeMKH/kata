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
        
        [Fact]
        public void TryIsLazy()
        {
            var spy = new List<string>();
            Assert.Empty(spy);
            
            Func<string> pass = () => { spy.Add("Success"); return "works"; };
            Func<string> fail = () => { spy.Add("Fail"); throw new ApplicationException("nooooooo!"); };
            
            Assert.Empty(spy);
            
            var p = Try(pass);
            var f = Try(fail);
            
            Assert.Empty(spy);
            
            string result;
            result = p.Run()
                      .Match(
                          e => e.Message,
                          s => s);
                          
            Assert.Equal(new List<string> { "Success" }, spy);
            Assert.Equal("works", result);
            
            spy.Clear();
            result = f.Run()
                      .Match(
                          e => e.Message,
                          s => s);
                          
            Assert.Equal("Fail", spy.Head());
            Assert.Equal("nooooooo!", result);
        }
    }
}
