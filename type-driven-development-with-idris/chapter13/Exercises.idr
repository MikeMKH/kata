import Data.Vect

--------------------------------------------------------------------------------
-- Exercises 13.1
--------------------------------------------------------------------------------

namespace Q1
  data DoorState = DoorOpen 
                 | DoorClosed
  
  data DoorCmd : Type -> DoorState -> DoorState -> Type where
    Pure : ty -> DoorCmd ty st st
    (>>=) : DoorCmd a st1 st2 -> (a -> DoorCmd b st2 st3) -> DoorCmd b st1 st3
    Open     : DoorCmd () DoorClosed DoorOpen
    Close    : DoorCmd () DoorOpen   DoorClosed
    RingBell : DoorCmd () st         st
  
  doorProg : DoorCmd () DoorClosed DoorClosed
  doorProg = do RingBell
                Open
                RingBell
                Close

namespace Q2
  data GuessCmd : Type -> Nat -> Nat -> Type where
    Try : Integer -> GuessCmd Ordering (S guesses) guesses
    Pure : ty -> GuessCmd ty st st
    (>>=) : GuessCmd a st1 st2 -> (a -> GuessCmd b st2 st3) -> GuessCmd b st1 st3
  
  threeGuesses : GuessCmd () 3 0
  threeGuesses = do Try 10
                    Try 20
                    Try 15
                    Pure ()
  
  -- must not type check
  -- noGuesses : GuessCmd () 0 0
  -- noGuesses = do Try 10; Pure ()

namespace Q3
  data Matter = Solid
              | Liquid
              | Gas
  
  data MatterCmd : Type -> Matter -> Matter -> Type where
    (>>=) : MatterCmd a st1 st2 -> (a -> MatterCmd b st2 st3) -> MatterCmd b st1 st3
    Melt     : MatterCmd () Solid Liquid
    Boil     : MatterCmd () Liquid Gas
    Condense : MatterCmd () Gas Liquid
    Freeze   : MatterCmd () Liquid Solid
  
  iceStream : MatterCmd () Solid Gas
  iceStream = do Melt
                 Boil
                 
  steamIce : MatterCmd () Gas Solid
  steamIce = do Condense
                Freeze

  -- must not type check
  -- overMelt : MatterCmd () Solid Gas
  -- overMelt = do Melt; Melt
  
--------------------------------------------------------------------------------
-- Exercises 13.2
--------------------------------------------------------------------------------

data StackCmd : Type -> Nat -> Nat -> Type where
  Push : Integer -> StackCmd () n (S n)
  Pop : StackCmd Integer (S n) n
  Top : StackCmd Integer (S n) (S n)
  
  GetStr : StackCmd String n n
  PutStr : String -> StackCmd () n n
  
  Pure : ty -> StackCmd ty n n
  (>>=) : StackCmd a n1 n2 -> (a -> StackCmd b n2 n3) -> StackCmd b n1 n3
  
runStack : (stk : Vect in_n Integer) -> StackCmd ty in_n out_n -> IO (ty, Vect out_n Integer)
runStack stk (Push x) = pure ((), x :: stk)
runStack (x :: xs) Pop = pure (x, xs)
runStack (x :: xs) Top = pure (x, x :: xs)
runStack stk GetStr = ?runStack_rhs_4
runStack stk (PutStr x) = ?runStack_rhs_5
runStack stk (Pure x) = ?runStack_rhs_6
runStack stk (x >>= f) = ?runStack_rhs_7

   