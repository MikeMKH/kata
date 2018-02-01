-- http://docs.idris-lang.org/en/latest/tutorial/provisional.html

module Main

data Parity : Nat -> Type where
  Even : Parity (n + n)
  Odd  : Parity (S (n + n))
  
parity : (n : Nat) -> Parity n
parity Z = Even {n = Z}
parity (S Z) = Odd {n = Z}
parity (S (S k)) with (parity k)
  parity (S (S (n + n))) | Even ?= Even {n = S n}
  parity (S (S (S (n + n)))) | Odd ?= Odd {n = S n}

Main.parity_lemma_1 = proof {
  compute;
  intros;
  rewrite sym (plusSuccRightSucc n n);
  trivial;
}

Main.parity_lemma_2 = proof {
  intros;
  exact believe_me value; -- totally believe me
}

data Binary : Nat -> Type where
  BEnd : Binary Z
  B0   : Binary n -> Binary (n + n)
  B1   : Binary n -> Binary (S (n + n))
  
natToBin : (n : Nat) -> Binary n
natToBin Z = BEnd
natToBin (S k) with (parity k)
  natToBin (S (n + n)) | Even = B1 (natToBin n)
  natToBin (S (S (n + n))) | Odd ?= B0 (natToBin (S n))
  
Main.natToBin_lemma_1 = proof {
  intros;
  rewrite sym (plusSuccRightSucc n n);
  trivial;
}

Show (Binary n) where
  show BEnd = ""
  show (B0 x) = show x ++ "0"
  show (B1 x) = show x ++ "1"
  
main : IO ()
main = do putStr "\\10: "
          x <- getLine
          printLn $ natToBin $ fromInteger $ cast x

