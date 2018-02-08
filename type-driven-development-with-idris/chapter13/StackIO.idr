import Data.Vect

--------------------------------------------------------------------------------
-- Exercises 13.2
-------------------------------------------------------------------------------- 

data StackCmd : Type -> Nat -> Nat -> Type where
     Push : Integer -> StackCmd () height (S height)
     Pop : StackCmd Integer (S height) height
     Top : StackCmd Integer (S height) (S height)

     GetStr : StackCmd String height height
     PutStr : String -> StackCmd () height height

     Pure : ty -> StackCmd ty height height
     (>>=) : StackCmd a height1 height2 ->
             (a -> StackCmd b height2 height3) ->
             StackCmd b height1 height3

runStack : (stk : Vect inHeight Integer) ->
           StackCmd ty inHeight outHeight -> IO (ty, Vect outHeight Integer)
runStack stk (Push val) = pure ((), val :: stk)
runStack (val :: stk) Pop = pure (val, stk)
runStack (val :: stk) Top = pure (val, val :: stk)
runStack stk GetStr = do x <- getLine
                         pure (x, stk)
runStack stk (PutStr x) = do putStr x
                             pure ((), stk)
runStack stk (Pure x) = pure (x, stk)
runStack stk (x >>= f) = do (x', newStk) <- runStack stk x
                            runStack newStk (f x')

testAdd : StackCmd () 0 0
testAdd = do Push 10
             x <- GetStr
             Push (cast x)
             val1 <- Pop
             val2 <- Pop
             PutStr (show (val1 + val2) ++ "\n")

data StackIO : Nat -> Type where
     Do : StackCmd a height1 height2 -> 
          (a -> Inf (StackIO height2)) -> StackIO height1

namespace StackDo
     (>>=) : StackCmd a height1 height2 -> 
             (a -> Inf (StackIO height2)) -> StackIO height1
     (>>=) = Do

data Fuel = Dry | More (Lazy Fuel)

partial
forever : Fuel
forever = More forever

run : Fuel -> Vect height Integer -> StackIO height -> IO ()
run (More fuel) stk (Do c f) 
     = do (res, newStk) <- runStack stk c
          run fuel newStk (f res)
run Dry stk p = pure ()

doBin : (f : Integer -> Integer -> Integer) -> StackCmd () (S (S height)) (S height)
doBin f = do val1 <- Pop
             val2 <- Pop
             Push (f val1 val2)

mutual
  tryBin : (f : Integer -> Integer -> Integer) -> StackIO height
  tryBin f {height = (S (S h))} = do doBin f
                                     result <- Top
                                     PutStr (show result ++ "\n")
                                     stackCalc
  tryBin f = do PutStr "Fewer than two items on the stack\n"
                stackCalc
                
  tryNeg : StackIO height
  tryNeg {height = (S h)} = do x <- Pop
                               Push (-x)
                               result <- Top
                               PutStr (show result ++ "\n")
                               stackCalc
  tryNeg = do PutStr "Fewer than one items on the stack\n"
              stackCalc
                
  tryDiscard : StackIO height
  tryDiscard {height = (S h)} = do x <- Pop
                                   PutStr ("Discarded " ++ show x ++ "\n")
                                   stackCalc
  tryDiscard = do PutStr "Fewer than one items on the stack\n"
                  stackCalc
  
  tryDup : StackIO height
  tryDup {height = (S h)} = do x <- Top
                               Push (x)
                               PutStr ("Duplicated " ++ show x ++ "\n")
                               stackCalc
  tryDup = do PutStr "Fewer than one items on the stack\n"
              stackCalc
              
  data StkInput = Number Integer
                | Add
                | Sub
                | Mul
                | Neg
                | Discard
                | Dup

  strToInput : String -> Maybe StkInput
  strToInput "" = Nothing 
  strToInput "add" = Just Add
  strToInput "subtract" = Just Sub
  strToInput "multiply" = Just Mul
  strToInput "negate" = Just Neg
  strToInput "discard" = Just Discard
  strToInput "duplicate" = Just Dup
  strToInput x = if all isDigit (unpack x) 
                    then Just (Number (cast x))
                    else Nothing

  stackCalc : StackIO height
  stackCalc = do PutStr "> "
                 input <- GetStr
                 case strToInput input of
                      Nothing => do PutStr "Invalid input\n"
                                    stackCalc
                      Just (Number x) => do Push x
                                            stackCalc
                      Just Add => tryBin (+)
                      Just Sub => tryBin (-)
                      Just Mul => tryBin (*)
                      Just Neg => tryNeg
                      Just Discard => tryDiscard
                      Just Dup => tryDup

main : IO ()
main = run forever [] stackCalc
