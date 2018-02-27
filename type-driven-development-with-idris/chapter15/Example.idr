import System.Concurrency.Channels

data Message = Add Nat Nat

adder : IO ()
adder = do Just sender <- listen 1
             | Nothing => adder
           Just msg <- unsafeRecv Message sender
             | Nothing => adder
           case msg of
            Add x y => do ok <- unsafeSend sender $ x + y
                          adder

main : IO ()
main = do Just pid <- spawn adder
            | Nothing => putStrLn "Spawn failed"
          Just add <- connect pid
            | Nothing => putStrLn "Connect failed"
          ok <- unsafeSend add $ Add 42 1
          Just res <- unsafeRecv Nat add
            | Nothing => putStrLn "Recv failed"
          printLn res
