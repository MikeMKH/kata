total
elem' : Eq ty => (value : ty) -> (xs : List ty) -> Bool
elem' value [] = False
elem' value (x :: xs) = case value == x of
                         False => elem' value xs
                         True => True

data Last : List a -> a -> Type where
  LastOne  : Last [value] value
  LastCons : (prf : Last xs value) -> Last (x :: xs) value

last123 : Last [1, 2, 3] 3
last123 = LastCons (LastCons LastOne)

notLastNil : Last [] value -> Void
notLastNil LastOne impossible
notLastNil (LastCons _) impossible

notLastOne : (contra : (x = value) -> Void) -> Last [x] value -> Void
notLastOne contra LastOne = contra Refl
notLastOne _ (LastCons LastOne) impossible
notLastOne _ (LastCons (LastCons _)) impossible

notLastCons : (contra : Last (x :: xs) value -> Void) -> Last (y :: (x :: xs)) value -> Void
notLastCons contra (LastCons LastOne) = contra LastOne
notLastCons contra (LastCons (LastCons prf)) = contra (LastCons prf)

isLast : DecEq a => (xs : List a) -> (value : a) -> Dec (Last xs value)
isLast [] value = No notLastNil
isLast (x :: []) value = case decEq x value of
                           (Yes Refl)  => Yes LastOne
                           (No contra) => No (notLastOne contra)
isLast (y :: (x :: xs)) value = case isLast (x :: xs) value of
                                  (Yes prf)   => Yes (LastCons prf)
                                  (No contra) => No (notLastCons contra)
