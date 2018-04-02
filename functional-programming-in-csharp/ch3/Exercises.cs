using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using LaYumba.Functional;
using static LaYumba.Functional.F;
using Xunit;

namespace ch3
{
    public class Exercises
    {
        [Fact]
        public void Ex1()
        {
            // not really sure what they want
            Assert.Equal(
                DayOfWeek.Friday,
                System.Enum.Parse<DayOfWeek>("Friday"));
        }
        
        [Fact]
        public void Ex2()
        {
            bool isOdd(int i) => i % 2 == 1;
            
            Assert.Equal(
                None,
                new List<int>().Lookup(isOdd)
            );
            
            Assert.Equal(
                Some(1),
                new List<int> { 1 }.Lookup(isOdd)
            );
            
            Assert.Equal(
                Some(11),
                new List<int> { 2, 4, 6, 8, 10, 11, 12 }.Lookup(isOdd)
            );
            
            Assert.Equal(
                Some(1),
                new List<int> { 1, 3, 5, 7, 9, 11, 13 }.Lookup(isOdd)
            );
        }
        
        [Fact]
        public void Ex3()
        {
            Assert.Equal(
                "email@aol.com",
                Email.Create("email@aol.com")
                  .Match(
                      Some: e => e,
                      None: () => "nope")
            );
            
            Assert.Equal(
                "fail",
                Email.Create("failure")
                  .Match(
                      Some: e => e,
                      None: () => "fail")
            );
        }
    }

    public static class Ex2Ext
    {
        public static Func<T, bool> Negate<T>(this Func<T, bool> f)
          => p => !f(p);
          
        public static Option<T> Lookup<T>(this IEnumerable<T> source, Func<T, bool> predicate)
        {
            foreach(var item in source) if(predicate(item)) return Some(item);
            return None;
        }
    }
    
   public class Email
   {
       private Email(string value)
         => Value = value;
   
     public string Value { get; }
   
     public static Option<Email> Create(string s)
     {
         MailAddress email;
         try
         {    
             email = new MailAddress(s);
             return Some(new Email(s));
         }
         catch(FormatException)
         {
             return None;
         }
     }
     
     public static implicit operator string(Email e)
       => e.Value;
   }
}
