module ExMatrix2x2
    ( matrix
    , zero
    , identity
    , rows
    , cols
    , getElem
    , transpose
    , det
    , isDiagonal
    , isTriangular
    , isLowerTriangular
    , isUpperTriangular
    , singular
    , invertible
    , inverse
    ) where

type Number = Double
type Row = [Number]
type Col = [Number]

data Matrix2x2 = Matrix2x2 Number Number Number Number

instance Show Matrix2x2 where
    show (Matrix2x2 a b c d) = show a ++ " " ++ show c ++ "\n" ++ show b ++ " " ++ show d

instance Eq Matrix2x2 where
    (==) x y = rows x == rows y

instance Num Matrix2x2 where
    (+) (Matrix2x2 a1 b1 c1 d1) (Matrix2x2 a2 b2 c2 d2) = Matrix2x2 (a1+a2) (b1+b2) (c1+c2) (d1+d2)
    (*) (Matrix2x2 a1 b1 c1 d1) (Matrix2x2 a2 b2 c2 d2) = Matrix2x2 (a1*a2+c1*b2) (b1*a2+d1*b2) (a1*c2+c1*d2) (b1*c2+d1*d2)
    negate (Matrix2x2 a b c d) = Matrix2x2 (-a) (-b) (-c) (-d)
    abs (Matrix2x2 a b c d) = Matrix2x2 (abs a) (abs b) (abs c) (abs d)
    signum (Matrix2x2 a b c d) = Matrix2x2 (signum a) (signum b) (signum c) (signum d)
    fromInteger x = Matrix2x2 (fromInteger x) 0 0 (fromInteger x)

-- matrix a b c d should create the matrix
-- ( a c )
-- ( b d )
matrix :: Number -> Number -> Number -> Number -> Matrix2x2
matrix a b c d = Matrix2x2 a b c d

zero :: Matrix2x2
zero = Matrix2x2 0 0 0 0

identity :: Matrix2x2
identity = Matrix2x2 1 0 0 1

rows :: Matrix2x2 -> [Row]
rows (Matrix2x2 a b c d) = [[a, c],[b, d]]

cols :: Matrix2x2 -> [Col]
cols (Matrix2x2 a b c d) = [[a, b],[c, d]]

getElem :: (Int,Int) -> Matrix2x2 -> Number
getElem (x,y) m = ((rows m) !! x) !! y

transpose :: Matrix2x2 -> Matrix2x2
transpose (Matrix2x2 a b c d) = (Matrix2x2 a c b d)

det :: Matrix2x2 -> Number
det (Matrix2x2 a b c d) = a * d - c * b

isDiagonal :: Matrix2x2 -> Bool
isDiagonal (Matrix2x2 a b c d) = b == c && b == 0

isTriangular :: Matrix2x2 -> Bool
isTriangular = isDiagonal

isLowerTriangular :: Matrix2x2 -> Bool
isLowerTriangular (Matrix2x2 a b c d) = c == 0

isUpperTriangular :: Matrix2x2 -> Bool
isUpperTriangular (Matrix2x2 a b c d) = b == 0

singular :: Matrix2x2 -> Bool
singular m = det m == 0

invertible :: Matrix2x2 -> Bool
invertible = not . singular

inverse :: Matrix2x2 -> Matrix2x2
inverse (Matrix2x2 a b c d) = Matrix2x2 (k*d) (k*(-b)) (k*(-c)) (k*a)
                                where k = 1.0/(det (Matrix2x2 a b c d))

