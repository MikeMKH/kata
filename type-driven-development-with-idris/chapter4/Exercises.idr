data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)
               
%name Tree tree, tree1

total insert : Ord elem => Tree elem -> elem -> Tree elem
insert Empty x = Node Empty x Empty
insert orig@(Node left val right) x = case compare x val of
                                    LT => Node (insert left x) val right 
                                    EQ => orig
                                    GT => Node left val (insert right x)

--------------------------------------------------------------------------------
-- Exercises 4.1
--------------------------------------------------------------------------------

total listToTree : Ord a => List a -> Tree a
listToTree = foldl insert Empty 

total treeToList : Ord a => Tree a -> List a
treeToList Empty = []
treeToList (Node left val right) = (treeToList left) ++ val :: (treeToList right)

-- 3