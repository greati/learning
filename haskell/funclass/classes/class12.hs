module Class12 where

-- a solução abaixo percorre a lista apenas uma vez
matheus :: Num a => [a] -> a
matheus (_:x:y:z:xs) = matheus (x:y:z:xs)
matheus xs = sum xs
