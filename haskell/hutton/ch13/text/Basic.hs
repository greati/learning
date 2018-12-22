module Basic where

import Control.Applicative
import Data.Char

newtype Parser a = P (String -> [(a, String)])

parse :: Parser a -> String -> [(a, String)]
parse (P p) inp = p inp

item :: Parser Char
item = P (\inp -> case inp of 
            [] -> []
            (x:xs) -> [(x, xs)])

-- Make the parser into a functor, such that fmap applies a function
-- to the result value of a parser if the parser succeeds
-- and propagates the failure otherwise.

instance Functor Parser where
    fmap g p = P (\inp -> case parse p inp of
                    [] -> []
                    [(v,out)] -> [(g v, out)])

-- Making the Parser type into an applicative functor
instance Applicative Parser where
    pure v = P (\inp -> [(v, inp)])
    pg <*> px = P (\inp -> case parse pg inp of
                    [] -> []
                    [(g,out)] -> parse (fmap g px) out)

-- Making the Parser a monad
instance Monad Parser where
    p >>= f = P (\inp -> case parse p inp of
                    [] -> []
                    [(v,out)] -> parse (f v) out)

-- The parser three, an example
three :: Parser (Char, Char)
three = 
    do  x <- item
        item
        z <- item
        return (x,z)
