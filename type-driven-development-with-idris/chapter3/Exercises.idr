import Data.Vect

--------------------------------------------------------------------------------
-- Exercises 3.2
--------------------------------------------------------------------------------

total my_length : List a -> Nat
my_length [] = 0
my_length (x :: xs) = S (my_length xs)

total my_reverse : List a -> List a
my_reverse = reverse' []
  where
    reverse' : List a -> List a -> List a
    reverse' m [] = m
    reverse' m (x :: xs) = reverse' (x :: m) xs

total my_map : (a -> b) -> List a -> List b
my_map f [] = []
my_map f (x :: xs) = f x :: my_map f xs

total my_vect_map : (a -> b) -> Vect n a -> Vect n b
my_vect_map f [] = []
my_vect_map f (x :: xs) = f x :: my_vect_map f xs

--------------------------------------------------------------------------------
-- Exercises 3.3
--------------------------------------------------------------------------------

total transposeMatrix : Vect n (Vect m a) -> Vect m (Vect n a)
transposeMatrix [] = replicate _ []
transposeMatrix (x :: xs) = zipWith (::) x $ transposeMatrix xs

total addMatrix : Num a => Vect n (Vect m a) -> Vect n (Vect m a) -> Vect n (Vect m a)
addMatrix [] [] = []
addMatrix (x :: xs) (y :: ys) = zipWith (+) x y :: addMatrix xs ys


