import Data.Vect

--------------------------------------------------------------------------------
-- Exercises 6.2
--------------------------------------------------------------------------------

total MatrixType : Type -> (n : Nat) -> (m : Nat) -> Type
MatrixType a n m = Vect n (Vect m a)

total Matrix : (n : Nat) -> (m : Nat) -> Type
Matrix = MatrixType Double

testMatrix : Matrix 2 3
testMatrix = [[0, 0, 0], [0, 0, 0]]

data Format = Num Format
            | Dbl Format
            | Str Format
            | Chr Format
            | Lit String Format
            | End

total PrintfType : Format -> Type
PrintfType (Num fmt) = Int -> PrintfType fmt
PrintfType (Dbl fmt) = Double -> PrintfType fmt
PrintfType (Str fmt) = String -> PrintfType fmt
PrintfType (Chr fmt) = Char -> PrintfType fmt
PrintfType (Lit str fmt) = PrintfType fmt
PrintfType End = String

total printfFormat : (fmt : Format) -> (acc : String) -> PrintfType fmt
printfFormat (Num fmt) acc = \i => printfFormat fmt (acc ++ show i)
printfFormat (Dbl fmt) acc = \d => printfFormat fmt (acc ++ show d)
printfFormat (Str fmt) acc = \s => printfFormat fmt (acc ++ s)
printfFormat (Chr fmt) acc = \c => printfFormat fmt (acc ++ singleton c)
printfFormat (Lit str fmt) acc = printfFormat fmt (acc ++ str)
printfFormat End acc = acc

total toFormat : (xs : List Char) -> Format
toFormat []                 = End
toFormat ('%' :: 'd' :: xs) = Num (toFormat xs)
toFormat ('%' :: 'f' :: xs) = Dbl (toFormat xs)
toFormat ('%' :: 's' :: xs) = Str (toFormat xs)
toFormat ('%' :: 'c' :: xs) = Chr (toFormat xs)
toFormat ('%' :: xs)        = Lit "%" (toFormat xs)
toFormat (x :: xs)          = case toFormat xs of
                                Lit str xs' => Lit (strCons x str) xs'
                                fmt => Lit (strCons x "") fmt

total printf : (fmt : String) -> PrintfType (toFormat (unpack fmt))
printf fmt = printfFormat _ ""

testPrintf : Char -> Double -> String
testPrintf = printf "%c %f"

-- 3
-- test : TupleVect 4 Nat
-- test = (1,2,3,4,())