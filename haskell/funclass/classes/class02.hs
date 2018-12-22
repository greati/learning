module Example where

life :: Integer
life = 42

three :: Integer -> Integer
three x = 3

infinity :: Integer
infinity = infinity + 1

double :: Integer -> Integer
double 2 = 2
double x = x + x

multiply :: (Int, Int) -> Int
multiply (x,0) = 0 
multiply (0,y) = 0 
multiply (x,y) = x * y
