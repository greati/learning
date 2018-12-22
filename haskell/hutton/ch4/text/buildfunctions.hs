{- Ways of building functions
 -
 - 1) from existing ones
 - 2) by conditional statements
 -	always have else!
 - 3) guarded equations
 -  logical expressions (guards) are used to choose between a sequence of results of the same type
 - 4) pattern matching
 -  uses a sequence of syntactic expressions called patterns
 -  wildcards: _, a, b...
 - 5) lambda expressions
 -  nameless functions
 - 6) sections
 -  operators enclosed in parentheses
 -
 -
 -}


abs :: Int -> Int
abs n = if n >= 0 then n else -n

signum :: Int -> Int
signum n = if n < 0 then -1 else
           if n == 0 then 0 else 1

signum2 :: Int -> Int
signum2 n | n < 0        = -1
          | n == 0       = 0
          | otheorwise    = 1

(^) :: Bool -> Bool -> Bool
True ^ b = b
False ^ _ = False
