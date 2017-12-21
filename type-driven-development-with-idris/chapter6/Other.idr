data FizzBuzzer = FizzBuzz
                | Fizz
                | Buzz
                | Number Nat

mkFizzBuzzer : (value : Nat) -> FizzBuzzer
mkFizzBuzzer value = case (modNat value 3 == 0, modNat value 5 == 0) of
                      (True, True)   => FizzBuzz
                      (True, False)  => Fizz
                      (False, True)  => Buzz
                      (False, Fasle) => Number value
                      
fizzbuzz : FizzBuzzer -> String
fizzbuzz FizzBuzz = "FizzBuzz"
fizzbuzz Fizz = "Fizz"
fizzbuzz Buzz = "Buzz"
fizzbuzz (Number k) = show k
