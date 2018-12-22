module Ex03 where

-- Exercise 1
ocorrencias :: Int -> [Int] -> Int
ocorrencias n [] = 0
ocorrencias n (x:xs)
    | x == n     = 1 + ocorrencias n xs
    | otherwise  = ocorrencias n xs  

ocorrencias' :: Int -> [Int] -> Int
ocorrencias' n xs = length (filter (\x -> n == x) xs)

-- Exercise 2
unicos :: [Int] -> [Int]
unicos xs = filter (\x -> ocorrencias x xs == 1) xs

unicos' :: [Int] -> [Int]
unicos' xs = [x | x <- xs, ocorrencias x xs == 1]

-- Exercise 3
desloque :: [Int] -> [Int]
desloque [] = []
desloque (x:xs) = xs ++ [x]

-- Exercise 4 (?)
pa :: [Int] -> [(Int, Int, Int)]
pa xs = [(x, y, y - x) | x <- xs, y <- xs]

-- Exercise 5
elimina :: [Int] -> Int -> [Int]
elimina xs n = [x | x <- xs, x /= n]

-- Exercise 6
isSublista :: [Int] -> [Int] -> Bool
isSublista (_:ts) [] = False 
isSublista [] xs = True
isSublista (t:ts) (x:xs) 
    | t == x = isSublista ts xs
    | otherwise = isSublista (t:ts) xs 

isSubsequence :: [Int] -> [Int] -> Bool
isSubsequence (_:ts) [] = False
isSubsequence [] xs = True
isSubsequence (t:ts) (x:xs) 
    | t == x    = take (length ts) xs == ts
    | otherwise = isSubsequence (t:ts) xs 

-- Exercise 7
pares :: Int -> [(Int,Int)]
pares n = [(x,n-x) | x <- [0..n]]

-- Exercise 8
type LAssoc a b = [(a, b)] 

alist_find :: Eq a => LAssoc a b -> a -> Bool
alist_find [] k = False
alist_find ((k',_):la) k
    | k == k'   = True
    | otherwise = alist_find la k   
    
alist_access :: Eq a => LAssoc a b -> a -> b
alist_access [] k = error "No entry found for the provided key."
alist_access ((k',x):ls) k 
    | k == k'   = x
    | otherwise = alist_access ls k

alist_remove :: Eq a => LAssoc a b -> a -> LAssoc a b
alist_remove [] k = error "No entry found for the provided key."
alist_remove (w:ls) k
    | fst w == k = ls
    | otherwise   = w : alist_remove ls k

alist_insert :: Eq a => LAssoc a b -> a -> b -> LAssoc a b
alist_insert [] x y = [(x,y)]
alist_insert (w:ls) x y 
    | x == fst w   = (x,y):ls
    | otherwise = w : alist_insert ls x y 

-- Exercise 9
data Int_Arvbin = Vazia | Vertice(Int_Arvbin, Int, Int_Arvbin) deriving (Show)
mytree = Vertice (Vertice(Vazia, 2, Vazia), 5, Vertice(Vazia, 10, Vazia)) :: Int_Arvbin

busca :: Int -> Int_Arvbin -> Bool
busca k Vazia = False
busca k (Vertice(l, k', r)) 
    | k == k'    = True
    | k < k'     = busca k l
    | k > k'     = busca k r

insercao :: Int -> Int_Arvbin -> Int_Arvbin
insercao k Vazia = Vertice(Vazia, k, Vazia)
insercao k (Vertice(l, k', r)) 
    | k == k' = Vertice(l, k', r)
    | k <  k' = Vertice(insercao k l, k', r)
    | k >  k' = Vertice(l, k', insercao k r)

altura :: Int_Arvbin -> Int
altura Vazia = 0
altura (Vertice(Vazia, k, Vazia)) = 0
altura (Vertice(l, k, r)) = 1 + max (altura l) (altura r)

naovazios :: Int_Arvbin -> Int
naovazios Vazia = 0
naovazios (Vertice(l, k, r)) = 1 + naovazios l + naovazios r
