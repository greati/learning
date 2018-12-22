module States where

import Control.Monad.State

igryph :: String -> State Integer Integer
igryph [] = do
                    i <- get
                    return i
igryph (x:xs) = do
                    i <- get
                    put (i+1)
                    igryph xs 

start = 0
