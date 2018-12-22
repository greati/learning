module Class24n where

data Nonempty a = a :| [a] deriving (Show, Eq)

head' :: Nonempty a -> a
head' (x :| xs) = x

tail' :: Nonempty a -> [a]
tail' (x :| xs) = xs

tail'' :: Nonempty a -> Nonempty a
tail'' (_ :| []) = error "Bad"
tail'' (_ :| (x:xs)) = x :| xs

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Show, Eq)
data Tree' a = Leaf' a | Node' (Tree' a) (Tree' a) deriving (Show, Eq)
data Tree'' a b = Leaf'' a | Node'' (Tree'' a b) b (Tree'' a b) deriving (Show, Eq)

sumTree :: (Num a) => Tree a -> a
sumTree (Leaf x) = x
sumTree (Node t1 x2 t2) = sumTree t1 + x2 + sumTree t2 
