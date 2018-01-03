module Main
import Data.Vect

infixr 5 .+.

data Schema = SString
            | SInt
            | (.+.) Schema Schema

SchemaType : Schema -> Type
SchemaType SString = String
SchemaType SInt = Int
SchemaType (l .+. r) = (SchemaType l, SchemaType r)

record DataStore where
       constructor MkData
       schema : Schema
       size : Nat
       items : Vect size (SchemaType schema)

addToStore : (store : DataStore) -> SchemaType (schema store) -> DataStore
addToStore (MkData schema size store) newitem = MkData schema _ (addToData store) where
  addToData : Vect oldsize (SchemaType schema) -> Vect (S oldsize) (SchemaType schema)
  addToData [] = [newitem]
  addToData (x :: xs) = x :: addToData xs
  
data Command : Schema -> Type where
     Add : SchemaType schema -> Command schema
     Get : Integer -> Command schema
     Size : Command schema
     Search : String -> Command schema
     Quit : Command schema
             
parseCommand : (schema : Schema) -> String -> String -> Maybe (Command schema)
parseCommand schema "add" s = Just (Add (?parse s))
parseCommand schema "get" s = case all isDigit (unpack s) of
                         False => Nothing
                         True => Just (Get (cast s))
parseCommand schema "quit" _ = Just Quit
parseCommand schema "size" _ = Just Size
parseCommand schema "search" s = Just (Search s)
parseCommand _ _ _ = Nothing
{-
parse : (input : String) -> Maybe Command
parse input = case span (/= ' ') input of
                (command, args) => parseCommand command $ ltrim args

getEntry : (pos : Integer) -> (store : DataStore) -> Maybe (SchemaType (schema store)), DataStore)
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
  -}