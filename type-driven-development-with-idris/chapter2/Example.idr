module Example

{-
2) Write a palindrome function, of type String -> Bool, that returns whether the input reads the same backwards as forwards.
Hint: You may find the function reverse : String -> String useful.
You can test your answer at the REPL as follows:
*ex_2> palindrome "racecar"
True : Bool

*ex_2> palindrome "race car"
False : Bool”
-}
export
palindrome : String -> Bool
palindrome x = if reverse x == x then True else False

{-
3) Modify the palindrome function so that it’s not case sensitive.
Hint: You may find toLower : String -> String useful.
You can test your answer at the REPL as follows:
*ex_2> palindrome "Racecar"
True : Bool
-}
export
palindromeInsenitive : String -> Bool
palindromeInsenitive = palindrome . toLower
  
{-
4) Modify the palindrome function so that it only returns True for strings longer than 10 characters.
You can test your answer at the REPL as follows:
*ex_2> palindrome "racecar"
False : Bool

*ex_2> palindrome "able was i ere i saw elba"
True : Bool
-}
palindromeN : Nat -> String -> Bool
palindromeN n s = if length s > n then palindrome s else False

{-
5) Modify the palindrome function so that it only returns True for strings longer than some length given as an argument.
Hint: Your new function should have type Nat -> String -> Bool.
You can test your answer at the REPL as follows:
*ex_2> palindrome 10 "racecar"
False : Bool

*ex_2> palindrome 5 "racecar"
True : Bool
-}
palindromeGt10 : String -> Bool
palindromeGt10 = palindromeN 10

{-
6) Write a counts function of type String -> (Nat, Nat) that returns a pair of the number of words in the input and the number of characters in the input.
You can test your answer at the REPL as follows:
*ex_2> counts "Hello, Idris world!"
(3, 19) : (Nat, Nat)
-}
counts : String -> (Nat, Nat)
counts s =
  let numWords = length $ words s
      numChars = length s in
        (numWords, numChars)

{-
7) Write a top_ten function of type Ord a => List a -> List a that returns the ten largest values in a list.
You may find the following Prelude functions useful:
take : Nat -> List a -> List a
sort : Ord a => List a -> List a
Use :doc for further information about these functions if you need it. You can test your answer at the REPL as follows:
*ex_2> top_ten [1..100]
[100, 99, 98, 97, 96, 95, 94, 93, 92, 91] : List Integer
-}
top_ten : Ord a => List a -> List a
top_ten = (Prelude.List.take 10) . reverse . sort

{-
8) Write an over_length function of type Nat -> List String -> Nat that returns the number of strings in the list longer than the given number of characters.
You can test your answer at the REPL as follows:
*ex_2> over_length 3 ["One", "Two", "Three", "Four"]
2 : Nat 
-}
over_length : Nat -> List String -> Nat
over_length n = length . filter ((n <) . length)