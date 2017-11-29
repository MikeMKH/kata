allLengths : List String -> List Nat
allLengths [] = []
allLengths (word :: words) = length word :: allLengths words

xor : Bool -> Bool -> Bool
xor False y = y
xor True y = not y

mutual
  isEven : Nat -> Bool
  isEven Z = True
  isEven (S k) = not $ isEven k
  
  isOdd : Nat -> Bool
  isOdd Z = False
  isOdd (S k) = isEven k
