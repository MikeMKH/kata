module Main

import Example

{-
9) For each of palindrome and counts, write a complete program that prompts for an input, calls the function, and prints its output.
You can test your answer using :exec at the REPL:

*ex_2_palindrome> :exec
Enter a string: Able was I ere I saw Elba
True
Enter a string: Madam, I'm Adam
False
Enter a string: 
-}
main : IO ()
main = repl "\nEnter a string: " (show . palindromeInsenitive)
