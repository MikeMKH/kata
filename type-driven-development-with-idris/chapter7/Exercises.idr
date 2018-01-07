--------------------------------------------------------------------------------
-- Exercises 7.1
--------------------------------------------------------------------------------

data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double
           
total shapeArea : Shape -> Double
shapeArea (Triangle base height) = 0.5 * base * height
shapeArea (Rectangle length width) = length * width
shapeArea (Circle radius) = pi * radius * radius

Eq Shape  where
  (==) (Triangle a b) (Triangle a' b') = a == a' && b == b' 
  (==) (Rectangle a b) (Rectangle a' b') = a == a' && b == b'
  (==) (Circle x) (Circle x') = x == x'
  (==) _ _ = False

Ord Shape where
  compare x y = compare (shapeArea x) (shapeArea y)

testShapes : List Shape
testShapes = [Circle 3, Triangle 3 9, Rectangle 2 6, Circle 4, Rectangle 2 7]

--------------------------------------------------------------------------------
-- Exercises 7.2
--------------------------------------------------------------------------------

data Expr num = Val num
              | Add (Expr num) (Expr num)
              | Sub (Expr num) (Expr num)
              | Mul (Expr num) (Expr num)
              | Div (Expr num) (Expr num)
              | Abs (Expr num)
          
total eval : (Neg num, Integral num) => Expr num -> num
eval (Val x)   = x
eval (Add x y) = eval x + eval y
eval (Sub x y) = eval x - eval y
eval (Mul x y) = eval x * eval y
eval (Div x y) = eval x `div` eval y
eval (Abs x)   = abs (eval x)

Num ty => Num (Expr ty) where
  (+) = Add
  (*) = Mul
  fromInteger = Val . fromInteger
  
Neg ty => Neg (Expr ty) where
  negate x = 0 - x
  (-) = Sub
  abs = Abs
  
total showExprFormat : (symbol : String ) -> (x : String) -> (y : String) -> String  
showExprFormat symbol x y = "(" ++ x ++ " " ++ symbol ++ " " ++ y ++ ")"

Show ty => Show (Expr ty) where
  show (Val x) = show x
  show (Add x y) = showExprFormat "+" (show x) (show y)
  show (Sub x y) = showExprFormat "-" (show x) (show y)
  show (Mul x y) = showExprFormat "*" (show x) (show y)
  show (Div x y) = showExprFormat "/" (show x) (show y)
  show (Abs x) = "(abs(" ++ show x ++ "))"

(Eq ty, Neg ty, Integral ty) => Eq (Expr ty) where
  (==) x y = eval x == eval y
  
(Neg num, Integral num) => Cast (Expr num) num where
  cast = eval