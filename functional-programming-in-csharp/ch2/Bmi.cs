using System;
using Xunit;
using static System.Console;

// dotnet build; dotnet run ch2.dll
// dotnet watch test
namespace ch2
{
    public class BmiTests
    {
        [Theory]
        [InlineData(1, 1, 1)]
        [InlineData(1.60, 77, 30.078)]
        public void GivenHeightWeightItMustCalculateExpectedBmi(double height, double weight, double bmi)
        {
            var actual = Bmi.Calculate(height: height, weight: weight);
            Assert.Equal(bmi, actual, 2);
        }
        
        [Theory]
        [InlineData(17, Bmi.Range.Underweight)]
        [InlineData(18.49, Bmi.Range.Underweight)]
        [InlineData(18.5, Bmi.Range.Normal)]
        [InlineData(24.99, Bmi.Range.Normal)]
        [InlineData(25, Bmi.Range.Overweight)]
        public void GivenBmiItMustReturnExpectedRangeValue(double bmi, Bmi.Range range)
        {
            var actual = Bmi.Results(bmi: bmi);
            Assert.Equal(range, actual);
        }
        
        [Theory]
        [InlineData(1.80, 77, Bmi.Range.Normal)]
        [InlineData(1.60, 77, Bmi.Range.Overweight)]
        public void GivenHeightWeightItMustWriteRangeValue(double height, double weight, Bmi.Range expected)
        {
            var actual = default(Bmi.Range);
            
            Func<string, double> read = s => s == "height" ? height : weight;
            Action<Bmi.Range> write = r => actual = r;
            
            Bmi.Run(reader: read, writter: write);
            
            Assert.Equal(expected, actual);
        }
    }

  public class Bmi
  {
    public enum Range { Underweight, Normal, Overweight }
    
    public static double Calculate(double height, double weight)
      => weight / (Math.Pow(height, 2));

    public static Range Results(double bmi)
      => bmi < 18.5 ? Range.Underweight
       : bmi >= 25 ? Range.Overweight
       : Range.Normal;

    internal static void Run(Func<string, double> reader, Action<Range> writter)
    {
      double weight = reader("weight"),
             height = reader("height");
             
      var range = Results(Calculate(height, weight));
      
      writter(range);
    }
    
    public static void Main(string[] args)
    {
      Func<string, double> reader = s =>
      {
        Write($"{s}=");
        return double.Parse(ReadLine());  
      };
      
      Action<Range> writter = r => WriteLine($"You are {r}");
      
      Run(reader, writter);
    }
  }
}
