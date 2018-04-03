using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

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
    }
}
