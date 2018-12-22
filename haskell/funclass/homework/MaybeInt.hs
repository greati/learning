module MaybeInt where

addMaybeInt :: Maybe Int -> Maybe Int -> Maybe Int
addMaybeInt (Just i) (Just i') = Just (i + i')
addMaybeInt _ _ = Nothing

summation :: Num a => [Maybe a] -> Maybe a
summation [] = Just 0
summation (x:xs) = case x of
                    Nothing -> Nothing
                    Just x' -> case summation xs of
                                    Nothing -> Nothing
                                    Just s -> Just (x' + s)

