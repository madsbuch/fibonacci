{-# LANGUAGE GADTs
, EmptyDataDecls
, TypeFamilies
, TypeOperators
, DataKinds
, FlexibleInstances
, UndecidableInstances #-}

module FibType where

data Nat = Z | S Nat

data TNat (a :: Nat) where
    TZ   :: TNat Z
    TS   :: TNat n -> TNat (S n)
    TAdd :: TNat a -> TNat b -> TNat (Add a b)


type family Add (a :: Nat) (b :: Nat) :: Nat
type instance Add  Z    b = b
type instance Add (S a) b = S (Add a b)
--type instance Add (S a) b = Add a (S b) -- Not possible as rhs is not converging


type family Fibonacci (n :: Nat) :: Nat
type instance Fibonacci Z           = Z
type instance Fibonacci (S Z)       = (S Z)
type instance Fibonacci (S (S n))   = Add (Fibonacci n) (Fibonacci (S n))
