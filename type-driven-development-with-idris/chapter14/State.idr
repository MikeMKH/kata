-- idris -p contrib State.idr
import Control.ST

-- http://docs.idris-lang.org/en/latest/st/state.html

increment : (x : Var) -> STrans m () [x ::: State Integer] (const [x ::: State Integer])
increment x = do num <- read x
                 write x (num + 1)
                 
makeAndIncrement : Integer -> STrans m Integer [] (const [])
makeAndIncrement init = do var <- new init
                           increment var
                           x <- read var
                           delete var
                           pure x
                           
ioMakeAndIncrement : STrans IO () [] (const [])
ioMakeAndIncrement =
  do lift $ putStr "Enter a number: "
     init <- lift $ getLine
     var <- new $ cast init
     lift $ putStr $ "var = " ++ show !(read var) ++ "\n"
     increment var
     lift $ putStr $ "var = " ++ show !(read var) ++ "\n"
     delete var