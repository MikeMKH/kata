import System.Concurrency.Channels

--------------------------------------------------------------------------------
-- Examples 15.1
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Examples 15.2.1
--------------------------------------------------------------------------------

data MessagePID = MkMessage PID

data Process : Type -> Type where
  Action : IO a -> Process a
  Pure : a -> Process a
  (>>=) : Process a -> (a -> Process b) -> Process b
  
  Spawn : Process () -> Process (Maybe MessagePID)
  Request : MessagePID -> Message -> Process (Maybe Nat)
  Response : ((msg : Message) -> Process Nat) -> Process (Maybe Message)
  
run : Process t -> IO t
run (Response calc) = do Just sender <- listen 1
                           | Nothing => pure Nothing
                         Just msg <- unsafeRecv Message sender
                           | Nothing => pure Nothing
                         res <- run $ calc msg
                         unsafeSend sender res
                         pure $ Just msg
run (Request (MkMessage proc) msg) = do Just chan <- connect proc
                                          | Nothing => pure Nothing
                                        ok <- unsafeSend chan msg
                                        if ok then do Just x <- unsafeRecv Nat chan
                                                        | Nothing => pure Nothing
                                                      pure (Just x)
                                              else pure Nothing
run (Spawn proc) = do Just pid <- spawn $ run proc
                        | Nothing => pure Nothing
                      pure $ Just (MkMessage pid)
run (Action act) = act
run (Pure val) = pure val
run (act >>= next) = do x <- run act
                        run $ next x
