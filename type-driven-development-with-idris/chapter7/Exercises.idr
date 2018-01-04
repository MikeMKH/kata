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