module Main where

import System.Environment

-- Standard recursive implementation, very slow
fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

-- Using an accumulator, tail recursion
fibAcc :: Integer -> Integer
fibAcc n = doFib n (0,1)
    where
        doFib :: Integer -> (Integer, Integer) -> Integer
        doFib 0 (a, b) = a
        doFib n (a, b) = doFib (n-1) (a+b, a)

fibCps :: Integer -> Integer
fibCps n = fibCpsDo n (\x->x)
    where
        fibCpsDo :: Integer -> (Integer -> Integer) -> Integer
        fibCpsDo 0 k = k 0
        fibCpsDo 1 k = k 1
        fibCpsDo n k = fibCpsDo (n-1) (\a 
            -> fibCpsDo (n-2) (\b 
                -> k (a+b)))

-- First argument is read and parsed as Integer
main = do
    a <- getArgs
    putStrLn $ show (fibAcc $ read (a !! 0) )

{-
 Fibonacci on structures. More precisely, Peano arithmetic implemented using ADTs
-}

data Nat = Z | S Nat deriving Show

s10 = (S (S (S (S (S (S (S (S (S (S Z))))))))))

showNat :: Nat -> Integer
showNat Z     = 0
showNat (S n) = (showNat n) + 1

-- Value level addition
add :: Nat -> Nat -> Nat
add Z b      = b
add (S a) b  = add a (S b)

-- Fibonacci
adtFib :: Nat -> Nat
adtFib Z         = Z
adtFib (S Z)     = (S Z)
adtFib (S (S n)) = (adtFib (S n)) `add` (adtFib n)

{-
 Fibonacci through map-reduce
-}

--mapFoldFib