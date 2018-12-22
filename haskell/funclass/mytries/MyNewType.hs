module MyNewType where

newtype Row a = Row [a] deriving (Show)
newtype Matrix a = Matrix [[a]] deriving (Show)


--m = Matrix [[1,2],[2,3]] :: Matrix Int
