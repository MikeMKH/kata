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
