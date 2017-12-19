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
                  
repl' : (String -> String) -> IO ()
repl' fn = do putStr "λ "
              e <- getLine
              let out = fn e
              putStrLn out
              repl' fn

guess : (target : Nat) -> (count : Nat) -> IO ()
guess target count = do putStr $ "Guess a number (count=" ++ show count ++ "): "
                        Just g <- readNumber | Nothing => do putStrLn "Numbers only"
                                                             guess target $ S count
                        case compare g target of
                          LT => do putStrLn "Too low"
                                   guess target $ S count
                          EQ => putStrLn "Correct"
                          GT => do putStrLn "Too high"
                                   guess target $ S count

main : IO ()
main = do
  n <- time
  guess (cast (mod n 100)) Z
