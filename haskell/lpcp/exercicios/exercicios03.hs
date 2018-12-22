-- Q1

ocorrencias :: Int -> [Int] -> Int
ocorrencias _ [] = 0
ocorrencias n (h:t) = 
    if n == h then 1 + ocorrencias n t
    else ocorrencias n t
    
-- Q2

unicos_aux :: [Int] -> [Int] -> [Int]
unicos_aux [] _ = []
unicos_aux (h:t) l = 
    if (ocorrencias h l) == 1 then h : unicos_aux t l 
    else unicos_aux t l
        
unicos :: [Int] -> [Int]
unicos l = unicos_aux l l

-- Q3

desloque :: [Int] -> [Int]
desloque [] = []
desloque (h:t) = t ++ [h]

-- Q4
pa :: [Int] -> [(Int,Int,Int)]
pa l = [(t1,t2,r) | t1 <- l, t2 <-  l, r <- l, t1 + r == t2]

-- Q5

elimina :: [Int] -> Int -> [Int]
elimina [] _ = []
elimina (h:t) n = 
    if h == n then elimina t n
    else h:elimina t n

-- Q6

sublista :: [Int] -> [Int] -> Bool
sublista [] _ = True
sublista _ [] = False
sublista (h:t) (a:x) = 
    if h == a then sublista t x
    else sublista (h:t) x
    
sequencia :: [Int] -> [Int] -> Bool
sequencia [] _ = True
sequencia _ [] = False
sequencia (h:t) (a:x) =
        if h == a then sequencia t x
        else False
        
subsequencia :: [Int] -> [Int] -> Bool
subsequencia [] _  = True
subsequencia _ [] = False
subsequencia (h:t) (a:x) =
    if h == a then 
        if sequencia t x then True
        else subsequencia (h:t) x 
    else subsequencia (h:t) x
    
-- Q7

pares :: Int -> [(Int,Int)]
pares n = [(a,b) | a <- [0..n], b <- [0..n], a + b == n]

-- Q8

--(a)

data Pair a b = Pair a b
data LAssoc a b = Nula | LAssoc (Pair a b, LAssoc a b)

--(b)

alist_find :: Eq a => LAssoc a b -> a -> Bool
alist_find Nula _ = False
alist_find (LAssoc (Pair x y, sl)) k = (x == k) || alist_find sl k

--(c)

alist_access :: Eq a => LAssoc a b -> a -> b
alist_access Nula _ = error "Elemento nao encontrado"
alist_access (LAssoc (Pair x y, sl)) k =
    if x == k then y
    else alist_access sl k
    
--(d)

alist_remove :: Eq a => LAssoc a b -> a -> LAssoc a b 
alist_remove Nula _ = Nula
alist_remove (LAssoc (Pair x y, sl)) k = 
        if x == k then sl
        else LAssoc (Pair x y, alist_remove sl k)
        
--(e)

alist_insert :: Eq a => LAssoc a b -> a -> b -> LAssoc a b
alist_insert Nula k r = LAssoc (Pair k r, Nula)
alist_insert (LAssoc (Pair x y, sl)) k r =
    if x == k then LAssoc (Pair k r, sl)
    else LAssoc(Pair x y, alist_insert sl k r)
    
-- Q9

data Int_Arvbin = Vazia | Vertice (Int_Arvbin, Int, Int_Arvbin)

busca :: Int -> Int_Arvbin -> Bool
busca _ Vazia = False
busca k (Vertice (ve, n, vd)) =
    if k == n then True
    else 
        if k < n then
            busca k ve
        else
            busca k vd

insercao :: Int -> Int_Arvbin -> Int_Arvbin         
insercao k Vazia = Vertice (Vazia, k, Vazia)
insercao k (Vertice (ve, n, vd)) =
    if k == n then Vertice (ve, n, vd)
    else
        if k < n then
            insercao k ve
        else
            insercao k vd

altura :: Int_Arvbin -> Int
altura Vazia = 0
altura (Vertice (Vazia, _, Vazia)) = 0
altura (Vertice (ve, _, vd)) = 1 + max (altura ve) (altura vd)

naovazios :: Int_Arvbin -> Int
naovazios Vazia = 0
naovazios (Vertice (ve, _, vd)) = 1 + naovazios ve + naovazios vd