import Data.List.Views

import Data.Vect
import Data.Vect.Views

import Data.Nat.Views

--------------------------------------------------------------------------------
-- Exercises 10.1
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Exercises 10.2
--------------------------------------------------------------------------------

total
equalSuffix : Eq a => List a -> List a -> List a
equalSuffix xs ys with (snocList xs)
  equalSuffix [] ys | Empty = []
  equalSuffix (xs ++ [x]) ys | (Snoc xsrec) with (snocList ys)
    equalSuffix (xs ++ [x]) [] | (Snoc xsrec) | Empty = []
    equalSuffix (xs ++ [x]) (ys ++ [y]) | (Snoc xsrec) | (Snoc ysrec) = case x == y of
                                                                          True => (equalSuffix xs ys | xsrec | ysrec) ++ [x]
                                                                          False => []

total
mergeSort : Ord a => Vect n a -> Vect n a
mergeSort xs with (splitRec xs)
  mergeSort [] | SplitRecNil = []
  mergeSort [x] | SplitRecOne = [x]
  mergeSort (ys ++ zs) | (SplitRecPair lrec rrec) = merge (mergeSort ys | lrec) (mergeSort zs | rrec)

total
toBinary : Nat -> String
toBinary k with (halfRec k)
  toBinary Z | HalfRecZ = ""
  toBinary (n + n) | (HalfRecEven rec) = (toBinary n | rec) ++ "0"
  toBinary (S (n + n)) | (HalfRecOdd rec) = (toBinary n | rec) ++ "1"

total
palindrome : Eq a => List a -> Bool
palindrome xs with (vList xs)
  palindrome [] | VNil = True
  palindrome [x] | VOne = True
  palindrome (x :: (ys ++ [y])) | (VCons rec) = case x == y of
                                                  True => palindrome ys | rec
                                                  False => False
