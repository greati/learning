module Monads where

data Expr = Val Int | Div Expr Expr

eval :: Expr -> Int
eval (Val n) = n
eval (Div x y) = eval x `div` eval y

-- Problem: division by zero. We could use Maybe...
safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv n m = Just (n `div` m)

-- and modify the eval:

eval' :: Expr -> Maybe Int
eval' (Val n) = Just n
eval' (Div x y) = case eval x of
                    Nothing -> Nothing
                    Just n -> case eval y of
                        Nothing -> Nothing
                        Just m -> safediv n m
