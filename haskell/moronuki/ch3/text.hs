{-
 - main: is the default action when you build an executable or
 - run it in a REPL.
 -
 - concat vs ++
 -
 -
 - common functions for manipulating lists in Prelude
 - are unsafe: they just throw exceptions for
 - border cases, like empty lists.
 -
 - -}
main :: IO ()
main = do 
	putStrLn "hello world!"
	putStrLn "hello world2!"
	putStrLn "hello world3!"

