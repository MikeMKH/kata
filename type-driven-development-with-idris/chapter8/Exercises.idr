data Vect : Nat -> Type -> Type where
  Nil  : Vect Z a
  (::) : a -> Vect k a -> Vect (S k) a

%name Vect xs, ys, zs

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

--------------------------------------------------------------------------------
-- Exercises 8.3
--------------------------------------------------------------------------------

headUnequal : DecEq a => {xs : Vect n a} -> {ys : Vect n a} ->
  (contra : (x = y) -> Void) -> ((x :: xs) = (y :: ys)) -> Void
headUnequal contra Refl = contra Refl

tailUnequal : DecEq a => {xs : Vect n a} -> {ys : Vect n a} ->
  (contra : (xs = ys) -> Void) -> ((x :: xs) = (y :: ys)) -> Void
tailUnequal contra Refl = contra Refl

DecEq a => DecEq (Vect n a) where
  decEq [] [] = Yes Refl
  decEq (x :: xs) (y :: ys) = case decEq x y of
                                No contra => No $ headUnequal contra
                                Yes Refl => case decEq xs ys of
                                  Yes Refl => Yes Refl
                                  No contra => No $ tailUnequal contra
