using System;
using Xunit;
using LaYumba.Functional;
using static LaYumba.Functional.F;
using System.Collections.Generic;
using Unit = System.ValueTuple;
using static ch11.MiddlewareExt;

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
        
        [Fact]
        public void MiddlewareIsExecuted()
        {
            List<string> spy = new List<string>();
            Middleware<string> spied = s => { spy.Add("called"); return s; };
            
            var result = (
                from t in spied
                select t
            )(s => s.ToUpper())("hi");
            
            Assert.Equal("HI", result);
            Assert.Equal("called", spy.Head());
        }
        
        [Fact]
        public void MiddlewareFormsPipeline()
        {
            List<string> store = new List<string>();
            
            Func<string, Middleware<string>> passed = s => cont => { store.Add(s); return cont("passed"); };
            
            var pipeline = 
                from t in passed("called")
                select t + "!";
                
            Assert.Equal("passed!", pipeline.Run());
            Assert.Equal(new List<string> {"called"}, store);
        }
        
        [Fact]
        public void MiddlewareAreAllExecuted()
        {
            List<string> store = new List<string>();
            
            Middleware<Unit> frame = cont =>
            {
                store.Add("enter");
                var result = cont(Unit());
                store.Add("exit");
                return result;
            };
            Func<string, Middleware<string>> passed = s => cont => { store.Add(s); return cont("passed"); };
            
            var pipeline = 
                from _ in frame
                from t in passed("called")
                select t + "!";
                
            Assert.Equal("passed!", pipeline.Run());
            Assert.Equal(
                new List<string>
                {
                    "enter",
                    "called",
                    "exit"
                },
                store);
        }
    }
    
    public static class MiddlewareExt
    {
        public delegate dynamic Middleware<T>(Func<T, dynamic> cont);
        public static Middleware<R> Bind<T, R>(this Middleware<T> middleware, Func<T, Middleware<R>> f)
          => cont => middleware(t => f(t)(cont));
        public static Middleware<R> SelectMany<T, R>(this Middleware<T> middleware, Func<T, Middleware<R>> f)
          => middleware.Bind(f);
        public static Middleware<RR> SelectMany<T, R, RR>(this Middleware<T> middleware, Func<T, Middleware<R>> f, Func<T, R, RR> project)
           => cont => middleware(t => f(t)(r => cont(project(t, r))));
        public static Middleware<R> Map<T, R>(this Middleware<T> middleware, Func<T, R> f)
          => cont => middleware(t => cont(f(t)));
        public static Middleware<R> Select<T, R>(this Middleware<T> middleware, Func<T, R> f)
          => middleware.Map(f);
        public static T Run<T>(this Middleware<T> middleware)
          => middleware(t => t);    
    }
}
