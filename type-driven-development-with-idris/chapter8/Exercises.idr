import Data.Vect

--------------------------------------------------------------------------------
-- Exercises 8.1
--------------------------------------------------------------------------------

same_cons : {xs : List a} -> {ys : List a} -> xs = ys -> x :: xs = x :: ys
same_cons prf = cong prf

same_lists : {xs : List a} -> {ys : List a} -> x = y -> xs = ys -> x :: xs = y :: ys
same_lists Refl prf = cong prf

data ThreeEq : a -> b -> c -> Type where
  AllSame : ThreeEq x x x

allSameS : (x, y, z : Nat) -> ThreeEq x y z -> ThreeEq (S x) (S y) (S z)
allSameS z z z AllSame = AllSame

--------------------------------------------------------------------------------
-- Exercises 8.2
--------------------------------------------------------------------------------

myPlusCommutes : (n : Nat) -> (m : Nat) -> n + m = m + n
myPlusCommutes Z m = rewrite plusZeroRightNeutral m in Refl
myPlusCommutes (S k) m = rewrite myPlusCommutes k m in 
                         rewrite plusSuccRightSucc m k in Refl

reverseProof_nil : (acc : Vect n a) -> Vect (plus n 0) a
reverseProof_nil {n} acc = rewrite plusZeroRightNeutral n in acc

reverseProof_xs : Vect (S n + k) a -> Vect (plus n (S k)) a
reverseProof_xs {n} {k} xs = rewrite sym (plusSuccRightSucc n k) in xs

myReverse : Vect n a -> Vect n a
myReverse xs = reverse' [] xs
  where reverse' : Vect n a -> Vect m a -> Vect (n+m) a
        reverse' acc [] = reverseProof_nil acc
        reverse' acc (x :: xs)
                        = reverseProof_xs (reverse' (x::acc) xs)