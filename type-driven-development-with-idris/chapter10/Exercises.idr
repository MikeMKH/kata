data TakeN : List a -> Type where
  Fewer : TakeN xs
  Exact : (n_xs : List a) -> TakeN (n_xs ++ rest)
  
takeN : (n : Nat) -> (xs : List a) -> TakeN xs
takeN Z [] = Exact []
takeN (S k) [] = Fewer
takeN Z (x :: xs) = Exact []
takeN (S k) (x :: xs) with (takeN k xs)
  takeN (S k) (x :: xs) | Fewer = Fewer
  takeN (S k) (x :: (n_xs ++ rest)) | (Exact n_xs) = Exact (x :: n_xs)

groupByN : (n : Nat) -> (xs : List a) -> List (List a)
groupByN n xs with (takeN n xs)
  groupByN n xs | Fewer = [xs]
  groupByN n (n_xs ++ rest) | (Exact n_xs) = n_xs :: groupByN n rest
  
halves : List a -> (List a, List a)
halves xs with (takeN (length xs `div` 2) xs)
  halves xs | Fewer = (xs, [])
  halves (n_xs ++ rest) | (Exact n_xs) = (n_xs, rest)
