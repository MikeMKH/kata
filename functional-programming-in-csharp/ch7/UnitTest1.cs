using System;
using LaYumba.Functional;
using Xunit;

// dotnet watch test
namespace ch7
{
    public class UnitTest1
    {
        [Fact]
        public void Ex1()
        {
            Func<int, int, int> remainder = (dividend, divisor) =>
            {
                while(dividend >= divisor) dividend -= divisor;
                return dividend;
            };
            
            Assert.Equal(2, remainder(42, 5));
            
            Func<int, int> remainderBy5 = remainder.ApplyR(5);
            
            Assert.Equal(2, remainderBy5(42));
        }
        
        [Fact]
        public void Ex2()
        {
            var cell = new PhoneNumber(PhoneType.Mobile, "us", "555-555-5555");
            
            Assert.Equal(PhoneType.Mobile, cell.PhoneType);
            Assert.Equal("us", cell.CountryCode);
            Assert.Equal("555-555-5555", cell.Number);
            
            Func<PhoneType, string, string, PhoneNumber> CreatePhoneNumber =
              (t, cc, n) => new PhoneNumber(t, cc, n);
              
            Assert.Equal("ir", CreatePhoneNumber(PhoneType.Work, "ir", "+11 something").CountryCode);
            
            Func<PhoneType, string, PhoneNumber> CreateUkPhoneNumber =
              (t, n) => CreatePhoneNumber(t, "uk", n);
            
            Assert.Equal("uk", CreateUkPhoneNumber(PhoneType.Home, "something").CountryCode);
            
            Func<string, PhoneNumber> CreateUkMobilePhoneNumber =
              CreateUkPhoneNumber.Apply(PhoneType.Mobile);
            
            Assert.Equal(PhoneType.Mobile, CreateUkMobilePhoneNumber("somthing").PhoneType);
            Assert.Equal("uk", CreateUkMobilePhoneNumber("somthing").CountryCode);
        }
        
        [Fact]
        public void Ex3()
        {
          string spy = "";
          Action<string> AssertLogContains = s => Assert.Contains(s, spy);
          
          var sut = Logger.Create(s => spy = s);
          
          sut.Info("hello");
          AssertLogContains("Info");
          AssertLogContains("hello");
          
          sut.Debug("hello");
          AssertLogContains("Debug");
          
          sut.Warn("hello");
          AssertLogContains("Warn");
          
          sut.Error("hello");
          AssertLogContains("Error");
        }
    }
    
    public static class BinFuncExt
    {
        public static Func<T1, U> ApplyR<T1, T2, U>(this Func<T1, T2, U> func, T2 arg2)
          => arg1 => func(arg1, arg2);
          
        public static Func<T1, T2, U> ApplyR<T1, T2, T3, U>(this Func<T1, T2, T3, U> func, T3 arg3)
          => (arg1, arg2) => func(arg1, arg2, arg3);
    }
    
    public enum PhoneType { Mobile, Home, Work };
    
    public class CountryCode
    {
        string Value { get; }
        public CountryCode(string value)
          => Value = value;
        public static implicit operator string(CountryCode cc)
          => cc.Value;
        public static implicit operator CountryCode(string s)
          => new CountryCode(s);
        public override string ToString()
          => Value;
    }
    
    public class PhoneNumber
    {
        public PhoneType PhoneType { get; }
        public CountryCode CountryCode { get; }
        public string Number { get; }
        
        public PhoneNumber(PhoneType phoneType, CountryCode countryCode, string number)
        {
            PhoneType = phoneType;
            CountryCode = countryCode;
            Number = number;
        }
    }
    
    public static class Logger
    {
      public enum Level { Info, Debug, Warn, Error };
           
      public static Action<Level, string> Create(Action<string> target)
        => (level, message) => target($"[{level}]: {message}");

      public static void Log(this Action<Level, string> log, Level level, string message)
        => log(level, message);
        
      public static void Info(this Action<Level, string> log, string message)
        => log(Level.Info, message);
        
      public static void Debug(this Action<Level, string> log, string message)
        => log(Level.Debug, message);
        
      public static void Warn(this Action<Level, string> log, string message)
        => log(Level.Warn, message);
        
      public static void Error(this Action<Level, string> log, string message)
        => log(Level.Error, message);
  }
}
