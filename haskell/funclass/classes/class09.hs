{-# LANGUAGE PostfixOperators #-}
{- Extensões da linguagem ^
 -
 - Uso de sinônimos de tipo
 -
 - :k <Some type>
 -
 - data ... = ...
 - sempre o rhs está esperando construtores, mesmo que de aridade zero, que chamamos de valor
 -
 - Pair é um type constructor (mora nos tipos)
 - MkPair é um value constructor
 - Como moram em mundos distintos, podemos chamar MkPair de Pair
 -  * não é qualquer tipo, é um tipo, digamos, Type
 - -}

module Class09 where

type MyString = [Char]

data PairIntBool = MkPairIntBool Integer Bool deriving (Show, Eq)
data PairIntInt = MkPairIntInt Integer Integer deriving (Show, Eq)

data Pair a b = Pair a b deriving (Show, Eq)

type Point2D = Pair Int Int

fact :: Integer -> Integer
fact n = product [1..n]
(!) :: Integer -> Integer
(!) = fact
