{-
 - Declaring functions
 -}

-- Doubles a number
double x = x + x
-- Quadruplicates a number
quadruple x = double(double x)
-- Factorial
factorial n = product[1..n]
average ns = (sum ns) `div` (length ns)
