data FizzBuzzerNat : Nat -> Type where
  FizzBuzz : {n : Nat} -> FizzBuzzerNat _
  Fizz     : {n : Nat} -> FizzBuzzerNat _
  Buzz     : {n : Nat} -> FizzBuzzerNat _
  Number   : {n : Nat} -> FizzBuzzerNat _
  
fizzbuzzerNat : (n : Nat) -> FizzBuzzerNat n
fizzbuzzerNat n = case (modNat n 3 == 0, modNat n 5 == 0) of
                       (True, True)   => FizzBuzz {n = (divNat n 15)}
                       (True, False)  => Fizz {n = (divNat n 3)}
                       (False, True)  => Buzz {n = (divNat n 5)}
                       (False, False) => Number {n = n}
  
fizzbuzz : Nat -> String
fizzbuzz k with (fizzbuzzerNat k)
  fizzbuzz k | FizzBuzz = "FizzBuzz"
  fizzbuzz k | Fizz = "Fizz"
  fizzbuzz k | Buzz = "Buzz"
  fizzbuzz k | Number = show k
