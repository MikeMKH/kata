--------------------------------------------------------------------------------
-- Examples http://docs.idris-lang.org/en/latest/tutorial/theorems.html
--------------------------------------------------------------------------------

fiveIsFive : 5 =5
fiveIsFive = Refl

twoPlusTwoIsFour : 2 + 2 = 4
twoPlusTwoIsFour = Refl

bottom : (n : Nat) -> Z = S n -> Void
bottom n prf = replace {P = disjointTy} prf () where
  disjointTy : Nat -> Type
  disjointTy Z = ()
  disjointTy (S k) = Void

z_plus_n_is_n : (n : Nat) -> plus Z n = n
z_plus_n_is_n n = Refl

n_plus_z_is_n : (n : Nat) -> plus n Z = n
n_plus_z_is_n Z = Refl
n_plus_z_is_n (S k) = cong $ n_plus_z_is_n k

plusReducesS : (n : Nat) -> (m : Nat) -> S(plus n m) = plus n (S m)
plusReducesS Z m = Refl
plusReducesS (S k) m = cong $ plusReducesS k m