module Main
import Data.Vect

data DataStore : Type where
  MkData : (size : Nat) -> (items : Vect size String) -> DataStore
  
size : DataStore -> Nat
size (MkData size' _) = size'

items : (store : DataStore) -> Vect (size store) String
items (MkData size' items') = items'

addToStore : DataStore -> String -> DataStore
addToStore (MkData size store) newitem = MkData _ (addToData store) where
  addToData : Vect oldsize String -> Vect (S oldsize) String
  addToData [] = [newitem]
  addToData (x :: xs) = x :: addToData xs
  
data Command = Add String
             | Get Integer
             | Size
             | Search String
             | Quit
             
parseCommand : String -> String -> Maybe Command
parseCommand "add" s = Just (Add s)
parseCommand "get" s = case all isDigit (unpack s) of
                         False => Nothing
                         True => Just (Get (cast s))
parseCommand "quit" _ = Just Quit
parseCommand "size" _ = Just Size
parseCommand "search" s = Just (Search s)
parseCommand _ _ = Nothing

parse : (input : String) -> Maybe Command
parse input = case span (/= ' ') input of
                (command, args) => parseCommand command $ ltrim args

getEntry : (pos : Integer) -> (store : DataStore) -> Maybe (String, DataStore)
getEntry pos store =
  let store_items = items store in
    case integerToFin pos (size store) of
      Nothing => Just ("Out of range\n", store)
      Just id => Just (index id (items store) ++ "\n", store)
      
searchStoreString : Nat -> (txt : String) -> (items : Vect n String) -> String
searchStoreString _ txt [] = ""
searchStoreString k txt (x :: xs) = 
  let cont = searchStoreString (S k) txt xs in 
    if Strings.isInfixOf txt x 
      then show k ++ ": " ++ x ++ "\n" ++ cont
      else cont

processInput : DataStore -> String -> Maybe (String, DataStore)
processInput store input =
  case parse input of
    Nothing => Just ("Invalid command\n", store)
    Just (Add item) =>
      Just (
        "ID=" ++ show (size store) ++ "\n",
        addToStore store item)
    Just (Get pos) => getEntry pos store
    Just Size => Just (show (size store) ++ "\n", store)
    Just (Search txt) => Just (searchStoreString 0 txt (items store), store)
    Just Quit => Nothing
    
main : IO()
main = replWith (MkData _ []) "Command: " processInput