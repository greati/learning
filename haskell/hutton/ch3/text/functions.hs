add :: (Int, Int) -> Int
add(x,y) = x + y

addb x y = x + y

{- A polymorphic type contains one or more type variables, 
 - which must begin with a lower case letter. 
 - 
 - Type variables indicate any type.
 -}

head :: [a] -> a

{- A type that contains one or more class constraints is called
 - overloaded.
 - Function above indicates that for any type a which is an instance of
 - class Num, (+) has type a -> a -> a.
 -}
(+) :: Num a => a -> a -> a


{- A type is a collection of related values.
 -
 - Classes are collections os types that support certain overloaded operations
 - called methods.
 -
 - Basic classes: Eq, Ord, Show, Read, Num, Integral, Fractional
 -
 -
 -}
