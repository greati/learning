{- GADTs permite adicionar mais restrições às definições de tipos.
 -
 - -}

{-# LANGUAGE GADTs #-}

module Class13 where

data Nat where
    
    Zero :: Nat
    Succ :: Nat -> Nat

  deriving (Show, Eq)

