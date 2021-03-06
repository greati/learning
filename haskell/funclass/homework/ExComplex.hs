module ExComplex
    ( complex
    , conjugate
    , toTrig
    , magnitude
    , arg
    ) where

{- Decisions:
 - * A complex number will always be represented by 
 - rectangular coordinates as a pair. Notice that
 - a complex number in polar form (ang, mag)
 - has rect form (mag*cos ang, mag*sen ang).
 - * The polar representation will be gathered
 - via a conversion function.
 - -}

type RePart    = Double
type ImPart    = Double
type Magnitude = Double
type Angle     = Double     -- in rads!

data Complex = Complex (RePart, ImPart)

instance Show Complex where
    show (Complex p) = show p

instance Eq Complex where
    (==) (Complex p1) (Complex p2) = p1 == p2

instance Num Complex where
    (+) (Complex (a1,b1)) (Complex (a2,b2)) = Complex (a1+a2, b1+b2)

    (*) (Complex (x1,y1)) (Complex (x2, y2)) = Complex ((x1 * x2 - y1 * y2), (x1 * y2 + x2 * y1))

    negate (Complex (a,b)) = Complex (-a, -b)
    abs (Complex (a,b)) = Complex (abs a, abs b)
    signum (Complex (a,b)) = Complex (signum a, 0)
    fromInteger x = Complex ((fromInteger x), 0)

complex :: RePart -> ImPart -> Complex
complex x y = Complex (x, y)

conjugate :: Complex -> Complex
conjugate (Complex (x, y)) = Complex (x, (-y))

fromTrig :: (Magnitude, Angle) -> Complex
fromTrig (m, a) = Complex (m*(cos a), m*(sin a))

toTrig :: Complex -> (Magnitude, Angle)
toTrig (Complex (x, y)) = (mag, ang)
                        where mag = sqrt(x**2 + y**2)
                              ang | x > 0 = atan (y/x)
                                  | x == 0 && y > 0 = pi/2
                                  | x < 0 = pi + atan (y/x)
                                  | x == 0 && y < 0 = -pi/2
                                  | otherwise = error "Undefined conversion."

magnitude :: Complex -> Magnitude
magnitude (Complex (x, y))     = sqrt (x**2 + y**2)

-- arg should be a number in (-pi, pi]
arg :: Complex -> Angle
arg r = fst (toTrig r)

-- real part
re :: Complex -> RePart
re (Complex (x, y)) = x

-- imaginary part
im :: Complex -> ImPart
im (Complex (x, y)) = y

