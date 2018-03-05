import System.Concurrency.Channels
import ProcessLib

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
-- Examples 15.2.1-2
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
                        
procAdder : Process ()
procAdder = do Response (\msg => case msg of
                                 Add x y => Pure $ x + y)
               procAdder

-- :exec run $ procMain 42 3
procMain : Nat -> Nat -> Process ()
procMain x y = do Just add <- Spawn procAdder
                    | Nothing => Action (putStrLn "Spawn failed")
                  Just res <- Request add $ Add x y
                    | Nothing => Action (putStrLn "Request failed")
                  Action $ printLn res
                  
-- :exec run procMain'
procMain' : Process ()
procMain' = procMain 2 3

--------------------------------------------------------------------------------
-- Examples 15.2.6
--------------------------------------------------------------------------------

data ListAction : Type where
  Length : List elem -> ListAction
  Append : List elem -> List elem -> ListAction
  
ListType : ListAction -> Type
ListType (Length xs) = Nat
ListType (Append {elem} xs ys) = List elem

procList : Service ListType ()
procList = do Respond (\msg => (case msg of
                                     (Length xs) => Pure $ length xs
                                     (Append xs ys) => Pure $ xs ++ ys))
              Loop procList

-- :exec runProc procListMain
procListMain : Client ()
procListMain = do Just list <- Spawn procList
                    | Nothing => Action (putStrLn "Spawn failed")
                  len <- Request list $ Length [1, 2, 3]
                  Action $ printLn len
                  app <- Request list $ Append [1, 2, 3] [4, 5, 6]
                  Action $ printLn app

--------------------------------------------------------------------------------
-- Examples 15.2.7
--------------------------------------------------------------------------------

record WCData where
  constructor MkWCData
  wordCount : Nat
  lineCount : Nat
  
doCount : (content : String) -> WCData
doCount content = let lcount = length $ lines content
                      wcount = length $ words content in
                      MkWCData wcount lcount
                      
data WC = CountFile String
        | GetData String
        
WCType : WC -> Type
WCType (CountFile x) = ()
WCType (GetData x) = Maybe WCData

countFile : (files : List (String, WCData)) -> (fname : String) -> Process WCType (List (String, WCData)) Sent Sent
countFile files fname = do Right content <- Action $ readFile fname
                             | Left err => Pure files
                           let count = doCount content
                           Action $ putStrLn $ "Counting done for "++ show fname
                           Pure ((fname, doCount content) :: files)

wcService : (loaded : List (String, WCData)) -> Service WCType ()
wcService loaded = do msg <- Respond (\msg => case msg of
                                              CountFile fname => Pure ()
                                              GetData fname => Pure $ lookup fname loaded)
                      newLoaded <- case msg of
                                        Just (CountFile fname) => countFile loaded fname
                                        _ => Pure loaded
                      Loop $ wcService newLoaded

-- :exec runProc $ procWC "Example.idr"
procWC : String -> Client ()
procWC fname = do Just wc <- Spawn (wcService [])
                    | Nothing => Action (putStrLn "Spawn failed")
                  Action $ putStrLn "Counting file"
                  Request wc $ CountFile fname
                  Action $ putStrLn "Processing"
                  Just counts <- Request wc $ GetData fname
                    | Nothing => Action (putStrLn "Problem reading file")
                  Action $ putStrLn $ "words = " ++ show (wordCount counts)
                  Action $ putStrLn $ "lines = " ++ show (lineCount counts)