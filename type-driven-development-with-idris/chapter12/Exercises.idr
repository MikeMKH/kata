import Control.Monad.State

update : (stateType -> stateType) -> State stateType ()
update f = do st <- get
              put $ f st

increase : Nat -> State Nat ()
increase k = update (+k)

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            
testTree : Tree String
testTree = Node (Node (Node Empty "Jim" Empty)
                      "Fred"
                      (Node Empty "Sheila" Empty))
                "Alice"
                (Node Empty
                      "Bob"
                      (Node Empty "Eve" Empty))

countEmpty : Tree a -> State Nat ()
countEmpty Empty = update (+1)
countEmpty (Node left _ right) = do countEmpty left
                                    countEmpty right
                                        
countEmptyNode : Tree a -> State (Nat, Nat) ()
countEmptyNode Empty = do (empty, node) <- get
                          put (empty + 1, node)
countEmptyNode (Node left _ right) = do countEmptyNode left
                                        (empty, node) <- get
                                        put (empty, node + 1)
                                        countEmptyNode right
