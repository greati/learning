module ExMatrix
where

type Row a = [a]
type Col a = [a]
newtype Matrix a = Matrix [Row a]

instance Show a => Show (Matrix a) where
    show (Matrix [])        = error "empty matrix"
    show (Matrix [[]])      = error "empty matrix"
    show (Matrix [xs])      = show xs 
    show (Matrix (xs:xss))  = show xs ++ "\n" ++ show (Matrix xss)

matrix :: (Show a, Eq a, Num a, Fractional a) => [Row a] -> Matrix a
matrix = Matrix . validate

validate :: [Row a] -> [Row a]
validate []     = error "empty matrix"
validate (x:xs) 
    | null x    = error "empty line"
    | otherwise = x : compatible x xs
        where
            compatible :: Row a -> [Row a] -> [Row a]
            compatible _ []                  = []
            compatible x (y:ys)
                | null y                = error "empty line"
                | length x /= length y  = error "incompatible row dimensions"
                | otherwise             = y : (compatible x ys)


dim :: Matrix a -> (Int, Int)
dim (Matrix [x])        = (1, length x)
dim (Matrix (x:xs))     = (1 + rows, cols)
    where (rows, cols)  = dim (Matrix xs)

elemAt :: Matrix a -> (Int, Int) -> a
elemAt (Matrix []) (i,j) = error "row index out of range"
elemAt (Matrix ([]:xss)) (i,j) = error "col index out of range"
elemAt (Matrix ((x:xs):xss)) (0,0)  = x
elemAt (Matrix ((x:xs):xss)) (0,j)  = elemAt (Matrix (xs:xss)) (0, j-1)
elemAt (Matrix (xs:xss)) (i, j)     = elemAt (Matrix xss) (i-1,j) 

(?) = elemAt

m = matrix [[1,2],[3,4]]
n = matrix [[2,3],[4,5]]

add :: (Num a, Show a, Eq a, Fractional a) => Matrix a -> Matrix a -> Matrix a
add (Matrix xss) (Matrix yss) = matrix (addRows xss yss)
    where
        addRows :: (Num a, Show a, Eq a, Fractional a) => [Row a] -> [Row a] -> [Row a]
        addRows [] [] = []
        addRows [] _ = error "incompatible row count"
        addRows _ [] = error "incompatible row count"
        addRows (xs:xss) (ys:yss) 
            | length xs == length ys    = (zipWith (+) xs ys) : (addRows xss yss)
            | otherwise                 = error "incompatible col count"

{-
add :: Num a => Matrix a -> Matrix a -> Matrix a
add Null Null = Null
add _ Null = error "incompatible rows quantity"
add Null _ = error "incompatible rows quantity"
add (Append x m) (Append y n) = Append (addrows x y) (add m n) 

addrows :: Num a => Row a -> Row a -> Row a
addrows [] []   = []
addrows [] _    = error "incompatible columns quantity"
addrows _  []   = error "incompatible columns quantity"
addrows (x:xs) (y:ys) = x + y : addrows xs ys

instance (Num a, Show a, Eq a, Fractional a) => Num (Matrix a) where
    (+) = add
    (*) = prod
    (-) = undefined
    fromInteger = undefined
    signum = undefined
    abs = undefined

rowAt :: Matrix a -> Int -> Row a
rowAt Null _            = error "row out of index"
rowAt (Append r m) 0    = r
rowAt (Append r m) i    = rowAt m (i-1)

colAt :: Matrix a -> Int -> Col a
colAt Null          _   = []        
colAt (Append r m)  i   = (r !! i) : colAt m i

cols :: Matrix a -> [Col a]
cols m = [colAt m i | i <- [0..snd (dim m)-1]]

innerProd :: Num a => Row a -> Col a -> a
innerProd [] []         = 0
innerProd _ []          = error "incompatible dimensions"
innerProd [] _          = error "incompatible dimensions"
innerProd (x:xs) (y:ys) = x * y + innerProd xs ys

prod :: Num a => Matrix a -> Matrix a -> Matrix a
prod Null n         = Null
prod (Append r m) n = Append (map (innerProd r) (cols n)) (prod m n)
-}
