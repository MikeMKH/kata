using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;
using LaYumba.Functional;
using static LaYumba.Functional.F;

// dotnet watch test
namespace ch4
{
    public class UnitTest1
    {
        [Fact]
        public void Ex1()
        {
            var set = new HashSet<int>(){1, 2, 3};
            Assert.Equal(set, set.Map(x => x)); 
            
            Assert.Equal(set.Select(x => x + 1), set.Map(x => x + 1)); 
            
            var dict = new Dictionary<int, string>(){{1, "one"}, {2, "two"}};
            Assert.Equal(dict, dict.Map(x => x));
            
            Assert.Equal(
                dict.Select(p => new KeyValuePair<int, string>(p.Key, p.Value + "!")),
                dict.Map(x => x + "!"));
        }
        
        [Fact]
        public void Ex2()
        {
            var opt = Some(42);
            Assert.Equal(
                opt.Map(x => x + 43),
                opt.MyMap(x => x + 43));
                
            var col = new List<int>(){1, 2, 3, 4}.AsEnumerable();
            Assert.Equal(
                col.Map(x => x + 42),
                col.MyMap(x => x + 42)
            );
        }
        
        [Fact]
        public void Ex3()
        {
            var employees = new Dictionary<string, Employee>()
            {
                {"None", new Employee(){Id = "1", WorkPermit = None}},
                {"Expiried", new Employee(){Id = "2", WorkPermit = Some(new WorkPermit(){Number = "1", Expiry = DateTime.Now.AddDays(-1)})}},
                {"Some", new Employee(){Id = "3", WorkPermit = Some(new WorkPermit(){Number = "2", Expiry = DateTime.Now.AddDays(100)})}},
            };
            
            Assert.True(
                GetWorkPermit(employees, "Expiried")
                  .Match(Some: _ => false, None: () => true));
            Assert.Equal("2", GetWorkPermit(employees, "Some").Bind(x => x.Number));
            Assert.True(
                GetWorkPermit(employees, "None")
                  .Match(Some: _ => false, None: () => true));
        }
        
        static Option<WorkPermit> GetWorkPermit(Dictionary<string, Employee> employees, string employeeId)
          =>  employees.Lookup(employeeId)
                .Bind(x => x.WorkPermit)
                .Where(HasExpiried.Negate());
                
        static Func<WorkPermit, bool> HasExpiried = permit => permit.Expiry < DateTime.Now; 
    }
    
    static public class MapExt
    {
        static public ISet<U> Map<T, U>(this ISet<T> source, Func<T, U> f)
            => source.Select(f).ToHashSet();
            
        static public IDictionary<K, U> Map<K, T, U>(this IDictionary<K, T> source, Func<T, U> f)
        {
            var r = new Dictionary<K, U>();
            foreach(var p in source)
              r[p.Key] = f(p.Value);
            return r;
        }
        
        static public Option<U> MyMap<T, U>(this Option<T> source, Func<T, U> f)
          => source.Bind(x => Some(f(x)));
          
        static public IEnumerable<U> MyMap<T, U>(this IEnumerable<T> source, Func<T, U> f)
          => source.Bind(x => new List<U>{f(x)});
    }
    
    public class Employee
    {
       public string Id { get; set; }
       public Option<WorkPermit> WorkPermit { get; set; }
    
       public DateTime JoinedOn { get; }
       public Option<DateTime> LeftOn { get; }
    }
    
    public struct WorkPermit
    {
      public string Number { get; set; }
      public DateTime Expiry { get; set; }
    }
}
