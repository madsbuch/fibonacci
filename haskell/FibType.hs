{-# LANGUAGE GADTs
, TypeFamilies
, DataKinds
, UndecidableInstances #-}

module FibType where

data Nat = Z | S Nat

type family Add (a :: Nat) (b :: Nat) :: Nat
type instance Add  Z    b = b
type instance Add (S a) b = S (Add a b)
--type instance Add (S a) b = Add a (S b) -- Not possible as rhs is not converging


type family Fibonacci (n :: Nat) :: Nat
type instance Fibonacci Z           = Z
type instance Fibonacci (S Z)       = (S Z)
type instance Fibonacci (S (S n))   = Add (Fibonacci n) (Fibonacci (S n))


{- For what can it be used? let's make some value level programming which makes
    the type depend on the values! -}

-- Value level Naturals
data SNat (a :: Nat) where
    SZ   :: SNat Z
    SS   :: SNat n -> SNat (S n)

-- Value level add, should it be type class?
add :: SNat m -> SNat n -> SNat (Add m n)
add SZ      b = b
add (SS a)  b = SS (add a b) 

-- value level Fibonacci
fibonacci :: SNat n -> SNat (Fibonacci n)
fibonacci SZ            = SZ
fibonacci (SS SZ)       = (SS SZ)
fibonacci (SS (SS n))   = add (fibonacci n) (fibonacci (SS n))

{- Following is a show instance to make it easier to read numbers -}
instance Show (SNat a) where
    show n = show $ doShow n
      where
        doShow :: SNat a -> Int
        doShow  SZ      = 0
        doShow (SS n)   = 1 + (doShow n)