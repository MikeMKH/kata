import Data.Vect

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

data Expr = Val Int
          | Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr

total evaluate : Expr -> Int
evaluate (Val x) = x
evaluate (Add x y) = (evaluate x) + (evaluate y)
evaluate (Sub x y) = (evaluate x) - (evaluate y)
evaluate (Mul x y) = (evaluate x) * (evaluate y)

total maxMaybe : Ord a => Maybe a -> Maybe a -> Maybe a
maxMaybe x Nothing = x
maxMaybe Nothing (Just y) = Just y
maxMaybe (Just x) (Just y) = Just (max x y)

data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double
           
total shapeArea : Shape -> Double
shapeArea (Triangle base height) = 0.5 * base * height
shapeArea (Rectangle length width) = length * width
shapeArea (Circle radius) = pi * radius * radius

data Picture = Primitive Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Translate Double Double Picture
             
total pictureArea : Picture -> Double
pictureArea (Primitive shape) = shapeArea shape
pictureArea (Combine x y) = pictureArea x + pictureArea y
pictureArea (Rotate _ pic) = pictureArea pic
pictureArea (Translate _ _ pic) = pictureArea pic

total biggestTriangle : Picture -> Maybe Double
biggestTriangle (Primitive t@(Triangle _ _)) = Just (shapeArea t)
biggestTriangle (Primitive _) = Nothing
biggestTriangle (Combine x y) = maxMaybe (biggestTriangle x) (biggestTriangle y)
biggestTriangle (Rotate _ pic) = biggestTriangle pic
biggestTriangle (Translate _ _ pic) = biggestTriangle pic

--------------------------------------------------------------------------------
-- Exercises 4.2
--------------------------------------------------------------------------------

data PowerSource = Petrol
                 | Pedal
                 | Electric

data Vehicle : PowerSource -> Type where
  Bicycle : Vehicle Pedal
  Unicycle : Vehicle Pedal
  Car : (fuel : Nat) -> Vehicle Petrol
  Motorcycle : (fuel : Nat) -> Vehicle Petrol
  Bus : (fuel : Nat) -> Vehicle Petrol
  
total wheels : Vehicle power -> Nat
wheels Bicycle = 2
wheels Unicycle = 1
wheels (Car fuel) = 4
wheels (Motorcycle fuel) = 2
wheels (Bus fuel) = 4

total refuel : Vehicle Petrol -> Vehicle Petrol
refuel (Car fuel) = Car 100
refuel (Motorcycle fuel) = Motorcycle 50
refuel (Bus fuel) = Bus 200

total vectTake : (n : Nat) -> Vect (n + m) a -> Vect n a
vectTake Z xs = []
vectTake (S k) (x :: xs) = x :: vectTake k xs

total sumEntries : Num a => (pos: Nat) -> Vect n a -> Vect n a -> Maybe a
sumEntries _ [] _ = Nothing
sumEntries Z (x :: xs) (y :: ys) = Just (x + y)
sumEntries (S k) (x :: xs) (y :: ys) = sumEntries k xs ys