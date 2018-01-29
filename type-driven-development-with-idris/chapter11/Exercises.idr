import Data.Vect
import Data.Primitives.Views

%default total

--------------------------------------------------------------------------------
-- Exercises 11.1
--------------------------------------------------------------------------------

every_other : Stream a -> Stream a
every_other (_ :: x :: xs) = x :: every_other xs

data InfList : Type -> Type where
  (::) : (value : elem) -> Inf (InfList elem) -> InfList elem
  
%name InfList xs, ys, zs

countFrom : Integer -> InfList Integer
countFrom x = x :: Delay (countFrom $ x + 1)

getPrefix : (n : Nat) -> InfList a -> Vect n a
getPrefix Z xs = []
getPrefix (S k) (value :: xs) = value :: getPrefix k xs

Functor InfList where
  map f (value :: xs) = f value :: Delay (map f xs)

randoms : Int -> Stream Int
randoms seed = let seed' = 1664525 * seed + 1013904223 in
                   (seed' `shiftR` 2) :: randoms seed'

data Face = Head | Tail

getFace : Int -> Face
getFace x with (divides x 2)
  getFace ((2 * div) + rem) | (DivBy prf) = 
    case rem of
      0 => Head
      _ => Tail

coinFlips : (count : Nat) -> Stream Int -> Vect count Face
coinFlips Z xs = []
coinFlips (S k) (value :: xs) = getFace value :: coinFlips k xs

square_root_approx : (number : Double) -> (approx : Double) -> Stream Double
square_root_approx number approx = approx :: Delay (square_root_approx number next)  where
  next = (approx + (number / approx)) / 2

square_root_bound : (max : Nat) -> (number : Double) -> (bound : Double) -> (approxs : Stream Double) -> Double
square_root_bound Z number bound (value :: xs) = value
square_root_bound (S k) number bound (x :: xs) =
  if (abs (x * x - number) < bound)
    then x
    else square_root_bound k number bound xs

square_root : (number : Double) -> Double
square_root number = square_root_bound 100 number 0.00000000001 $ square_root_approx number number

--------------------------------------------------------------------------------
-- Exercises 11.2
--------------------------------------------------------------------------------

data InfIO : Type where
  Do : IO a -> (a -> Inf InfIO) -> InfIO
  
(>>=) : IO a -> (a -> Inf InfIO) -> InfIO
(>>=) = Do

data Fuel = Dry | More (Lazy Fuel)

run : Fuel -> InfIO -> IO ()
run Dry _ = putStrLn "Done"
run (More x) (Do y f) = do res <- y
                           run x (f res)
                           
partial
forever : Fuel
forever = More forever

totalRepl : (prompt : String) -> (action: String -> String) -> InfIO
totalRepl prompt action =
  do putStr prompt
     s <- getLine
     putStrLn $ action s
     totalRepl prompt action
     
