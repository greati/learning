module Class14 where

{- until
 -
 - collatz
 -
 - QuickCheck simples com sorted em um predicado baseado
 - numa implicação não diz muito, pois as entradas
 - podem não ter satisfeito os antecedentes.
 - É possível usar o operator ==>
 - É possível também dizer que ele crie só listas ordenadas: Ordered list
 -
 - -}

until' :: (a -> Bool) -> (a -> a) -> a -> a
until' p f v 
    | p v       = v
    | otherwise = until' p f (f v)

iterate' :: (a -> a) -> a -> [a]
iterate' f v = (f v) : iterate' f (f v)

sorted :: Ord a => [a] -> Bool
sorted []       = True
sorted [x]      = True
sorted (x:xs'@(y:_)) = (x <= y) && sorted xs'


