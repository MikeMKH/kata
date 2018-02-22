--------------------------------------------------------------------------------
-- Exercises 14.2.1
--------------------------------------------------------------------------------

data Access = LoggedOut | LoggedIn
data PwdCheck = Correct | Incorrect

data ShellCmd : (ty : Type) -> Access -> (ty -> Access) -> Type where
  Password : String -> ShellCmd PwdCheck LoggedOut (\res => case res of
                                                              Correct => LoggedIn
                                                              Incorrect => LoggedOut)
  Logout : ShellCmd () LoggedIn (const LoggedOut)
  GetSecret : ShellCmd String LoggedIn (const LoggedIn)
  
  PutStr : String -> ShellCmd () state (const state)

  Pure : (res : ty) -> ShellCmd ty (state_fn res) state_fn
  (>>=) : ShellCmd a state1 state2_fn -> ((res : a) -> ShellCmd b (state2_fn res) state3_fn) -> ShellCmd b state1 state3_fn
  
session : ShellCmd () LoggedOut (const LoggedOut)
session = do Correct <- Password "wurzel"
               | Incorrect => PutStr "no such user or password"
             msg <- GetSecret
             PutStr ("Secret code: " ++ show msg ++ "\n")
             Logout 

{-
sessionBad : ShellCmd () LoggedOut (const LoggedOut)
sessionBad = do Password "wurzel"
                msg <- GetSecret
                PutStr ("p0wned secret code: " ++ show msg ++ "\n")
                Logout
-}

{-
noLogout : ShellCmd () LoggedOut (const LoggedOut)
noLogout = do Correct <- Password "wurzel"
                | Incorrect => PutStr "no such user or password"
              msg <- GetSecret
              PutStr ("Secret code: " ++ show msg ++ "\n")
-}

--------------------------------------------------------------------------------
-- Exercises 14.2.2
--------------------------------------------------------------------------------
namespace Vending
  VendState : Type
  VendState = (Nat, Nat)
  
  data Input = COIN 
             | VEND 
             | CHANGE 
             | REFILL Nat
  
  strToInput : String -> Maybe Input
  strToInput "insert" = Just COIN
  strToInput "vend" = Just VEND
  strToInput "change" = Just CHANGE
  strToInput x = if all isDigit (unpack x)
                    then Just (REFILL (cast x))
                    else Nothing
  
  data CoinResult = Accepted | Rejected
  
  data MachineCmd : (res : Type) -> VendState -> (res -> VendState) -> Type where
       InsertCoin : MachineCmd CoinResult (dollars, chocs)     
                                 (\res => case res of
                                               Accepted => (S dollars, chocs)
                                               Rejected => (dollars, chocs))
       Vend       : MachineCmd () (S dollars, S chocs) (const (dollars, chocs))
       GetCoins   : MachineCmd () (dollars, chocs)     (const (Z, chocs))
  
       Display : String ->      MachineCmd () state      (const state)
       Refill : (bars : Nat) -> MachineCmd () (Z, chocs) (const (Z, bars + chocs))
  
       GetInput : MachineCmd (Maybe Input) state (const state)
  
       Pure : (res : ty) -> MachineCmd ty (state_fn res) state_fn
       (>>=) : MachineCmd a state1 state2_fn -> 
                          ((x : a) -> MachineCmd b (state2_fn x) state3_fn) ->
                          MachineCmd b state1 state3_fn
  
  data MachineIO : VendState -> Type where
       Do : MachineCmd a state1 state2_fn ->
                      ((x : a) -> Inf (MachineIO (state2_fn x))) -> MachineIO state1
      
  namespace MachineDo
       (>>=) : MachineCmd a state1 state2_fn ->
                         ((x : a) -> Inf (MachineIO (state2_fn x))) -> MachineIO state1
       (>>=) = Do
  
  mutual
    vend : MachineIO (dollars, chocs)
    vend {dollars = S p} {chocs = S c} = do Vend
                                            Display "Enjoy!"
                                            machineLoop
    vend {dollars = Z} = do Display "Insert a coin"
                            machineLoop
    vend {chocs = Z} = do Display "Out of stock"
                          machineLoop
  
    refill : (num : Nat) -> MachineIO (dollars, chocs)
    refill {dollars = Z} num = do Refill num
                                  machineLoop
    refill _ = do Display "Can't refill: Coins in machine"
                  machineLoop
  
    machineLoop : MachineIO (pounds, chocs)
    machineLoop =
         do Just x <- GetInput | Nothig => do Display "Invalid input"
                                              machineLoop
            case x of
                COIN => do res <- InsertCoin
                           case res of
                                Accepted => do Display "Coin accepted, thank you"
                                               machineLoop
                                Rejected => do Display "Coin rejected"
                                               machineLoop
                VEND => vend
                CHANGE => do GetCoins
                             Display "Change returned"
                             machineLoop
                REFILL num => refill num
  