module Main

import System

--------------------------------------------------------------------------------
-- Exercises 5.1
--------------------------------------------------------------------------------

total printLonger : IO ()
printLonger = do putStrLn "Which is longer?"
                 putStr "1> "
                 str1 <- getLine
                 putStr "2> "
                 str2 <- getLine
                 putStrLn $ case compare (length str1) (length str2) of
                  LT => "2"
                  EQ => "same length"
                  GT => "1"
                  
total printLonger' : IO ()
printLonger' = putStrLn "Which is longer?" >>=
  \_ => putStr "1> " >>= \_ => getLine >>=
  \str1 => putStr "2> " >>= \_ => getLine >>=
  \str2 => putStrLn $ case compare (length str1) (length str2) of
    LT => "2"
    EQ => "same length"
    GT => "1"

--------------------------------------------------------------------------------
-- Exercises 5.2
--------------------------------------------------------------------------------

total readNumber : IO (Maybe Nat)
readNumber = do input <- getLine
                if all isDigit (unpack input)
                  then pure (Just (cast input))
                  else pure Nothing

guess : (target : Nat) -> IO ()
guess target = do putStr "Guess a number: "
                  Just g <- readNumber | Nothing => do putStrLn "Numbers only"
                                                       guess target
                  case compare g target of
                    LT => do putStrLn "Too low"
                             guess target
                    EQ => putStrLn "Correct"
                    GT => do putStrLn "Too high"
                             guess target

main : IO ()
main = do
  n <- time
  guess (cast (mod n 100))
