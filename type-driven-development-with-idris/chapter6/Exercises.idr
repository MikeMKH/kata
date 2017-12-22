import Data.Vect

--------------------------------------------------------------------------------
-- Exercises 6.2
--------------------------------------------------------------------------------

MatrixType : Type -> (n : Nat) -> (m : Nat) -> Type
MatrixType a n m = Vect n (Vect m a)

Matrix : (n : Nat) -> (m : Nat) -> Type
Matrix = MatrixType Double

testMatrix : Matrix 2 3
testMatrix = [[0, 0, 0], [0, 0, 0]]

