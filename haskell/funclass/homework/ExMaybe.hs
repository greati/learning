module ExMaybe where

-- Do not alter this import!
import Prelude hiding ( maybe, Maybe(..) )
import qualified Data.Maybe as M

data Maybe a = Nothing | Just a
    deriving (Show, Eq, Ord)

catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (m:ms) = case m of
                        Nothing -> catMaybes ms
                        Just x -> x : catMaybes ms

fromJust :: Maybe a -> a
fromJust (Just x) = x
fromJust _ = error "Not a just value"

fromMaybe :: a -> Maybe a -> a
fromMaybe _ (Just x) = x
fromMaybe d _ = d

isJust :: Maybe a -> Bool
isJust (Just x) = True
isJust Nothing = False

isNothing :: Maybe a -> Bool
isNothing = not . isJust

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:_) = Just x

mapMaybe :: (a -> Maybe b) -> [a] -> [b]
mapMaybe f [] = []
mapMaybe f (x:xs) = case f x of
                        Nothing -> mapMaybe f xs
                        Just v -> v : mapMaybe f xs

maybe :: b -> (a -> b) -> Maybe a -> b
maybe _ f (Just v) = f v
maybe d _ _ = d

maybeToList :: Maybe a -> [a]
maybeToList (Just v) = [v]
maybeToList _ = []


