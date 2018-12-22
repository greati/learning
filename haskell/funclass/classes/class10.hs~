module Class10 where

data Shape = Circle Double | Rectangle Double Double deriving (Show, Eq)

{- case of... é uma expressão
 -
 - -}
area :: Shape -> Double
area s = case s of 
            Circle r -> pi*r**2
            Rectangle w h -> w*h
            
data Person = Amigo String | Colega String String deriving (Show, Eq)

father :: Person -> Person
father (Amigo "Thanos") = nikos

thanos = Amigo "Thanos"
nikos = Colega "Nikos" "Tsouanas"

{- case of... permite fazer pattern matching sobre "qualquer coisa",
 - não só sobre o argumento
 -
 - -}
friendWithDad :: Person -> Bool
friendWithDad p = case father p of
                    Amigo _ -> True
                    Colega _ _ -> False
                    
{- Definindo listas de qualquer tipo.
 -
 - -}
data List a = Empty | (:+) a (List a) deriving (Show, Eq)
infixr 5 :+

head' :: [a] -> a
head' [] = error "Empty list."
head' (x:_) = x

tail' :: [a] -> [a]
tail' [] = error "Empty list."
tail' (_:xs) = xs

null' :: [a] -> Bool
null' [] = True
null' _ = False

length' :: Integral b => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

sum' :: Num a => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

prod' :: Num a => [a] -> a
prod' [] = 1
prod' (x:xs) = x * prod' xs

reverse' :: [a] => [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]


