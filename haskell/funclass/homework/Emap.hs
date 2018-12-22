module Emap where

emap :: (a -> c) -> (b -> d) -> Either a b -> Either c d
emap f g (Left x) = Left (f x)
emap f g (Right x) = Right (g x)
