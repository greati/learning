module Xlinha where

import Prelude hiding (putStr, putStrLn)

putCharLn :: Char -> IO()
putCharLn c = do putChar c
                 putChar '\n'

putStr :: String -> IO()
putStr [] = return ()
putStr (c:cs) = do 
                    putChar c
                    putStr cs
