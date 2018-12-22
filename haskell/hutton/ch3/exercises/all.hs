{-
 - 1
 - -}
['a','b','c'] :: [Char]
('a','b','c') :: (Char, Char, Char)
[(False,'0'),(True, '1')]::[(Bool, Char)]
([False,True],['0', '1'])::([Bool],[Char])
[tail, init, reverse]::[[a]->[a]]

{-
 - 2
 -}
second :: [a] -> a
second xs = head(tail xs)

swap :: (a,b) -> (b,a)
swap(x,y) = (y,x)

pair :: a -> b -> (a, b)
pair x y = (x,y)

double :: Num a => a -> a
double x = x * 2

palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs

twice :: (a -> a) -> a -> a
twice f x = f(f x)
