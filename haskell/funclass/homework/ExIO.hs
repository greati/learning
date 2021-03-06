module ExIO where

import Prelude hiding
    ( putStr
    , putStrLn
    , getLine
    , interact
    , (>>)
    , (>>=)
    )

-- read through the whole module first, to get an idea
-- of what's required and to decide where to start

getLine :: IO String
getLine = do
            s <- getChar
            if s == '\n' then return [] else do l <- getLine
                                                return $ s : l

getLine' :: IO String
getLine' = getChar >>= (\s -> if s == '\n' then return [] else getLine >>= (\l -> return $ s : l))

getInt :: IO Int
getInt = do
            s <- getLine
            return $ read s

getSafeInt :: IO (Maybe Int)
getSafeInt = do
                s <- getLine
                let c = reads s :: [(Int, String)]
                case c of
                    [(n,"")] -> return $ Just n
                    _ -> return Nothing

-- sequencing: first do f ignoring its result, then do g and keep its result
infixl 1 >>

(>>) :: IO a -> IO b -> IO b
f >> g = do {f;g}

-- pauses till the user presses any normal key
pause :: IO ()
pause = getChar >> skip

skip :: IO ()
skip = return ()

newline :: IO ()
newline = putChar '\n'

-- define it as a foldr
putStr :: String -> IO ()
putStr = foldr (\x act -> putChar x >> act) skip

-- transform f into one "just like f" except that it prints a newline
-- after any side-effects f may had
lnize :: (a -> IO b) -> a -> IO b
lnize f = \x -> do 
                    a <- f x 
                    newline
                    return a

lnize' :: (a -> IO b) -> a -> IO b
lnize' f x = f x >>= (\a -> newline >> return a)

putStrLn :: String -> IO ()
putStrLn = lnize putStr

putCharLn :: Char -> IO ()
putCharLn = lnize putChar

-- reads the entire user input as a single string, transforms it, and prints it
interact :: (String -> String) -> IO ()
interact = \f -> do
                    s <- getLine
                    putStr $ f s 
                    skip

perlineize :: (String -> String) -> (String -> String)
perlineize f = unlines . map f . lines

interactPerLine :: (String -> String) -> IO ()
interactPerLine = interact . perlineize

when :: Bool -> IO () -> IO ()
when = \b f -> if b then f else skip

unless :: Bool -> IO () -> IO ()
unless = \b f -> if not b then f else skip

guard :: Bool -> IO ()
guard True  = skip
guard False = error "fail guard" -- TODO!

forever :: IO a -> IO b
forever = \f -> do {f; forever f}

-- transforms the action given to an equivalent one that has no result
void :: IO a -> IO ()
void f = f >> skip

-- Kleisli compositions
infixr 1 >=>, <=<

-- diagrammatic order
(>=>) :: (a -> IO b) -> (b -> IO c) -> (a -> IO c)
f >=> g = \x -> do {x' <- f x; g x'}

-- traditional order
-- comparison of types:
-- (.)   :: (b ->    c) -> (a ->    b) -> a ->    c
-- (<=<) :: (b -> IO c) -> (a -> IO b) -> a -> IO c
(<=<) :: (b -> IO c) -> (a -> IO b) -> (a -> IO c)
(<=<) = flip (>=>)

-- Bind
infixl 1 >>=

(>>=) :: IO a -> (a -> IO b) -> IO b
iox >>= f = do
                x <- iox
                f x

infixl 4 $>, <$

greet :: String -> IO()
greet x = getLine >>= (\x -> putStrLn x)


-- make an action that has the side effects of the action on the left
-- but with result the value on the right
($>) :: IO a -> b -> IO b
iox $> y = do {iox; return y}

-- vice-versa
(<$) :: a -> IO b -> IO a
x <$ ioy = do {ioy; return x}

ap :: IO (a -> b) -> IO a -> IO b
iof `ap` iox = do
                    f <- iof
                    x <- iox
                    return $ f x 

filterIO :: (a -> IO Bool) -> [a] -> IO [a]
filterIO p = foldr (\x xs -> do b <- p x
                                xs' <- xs
                                if b then
                                    return (x:xs')
                                else
                                    return xs') (return []) 

evenIO :: Integral a => a -> IO Bool
evenIO x = return $ even x

iomap :: (a -> b) -> IO a -> IO b
iomap f x = do 
                x' <- x 
                x $> f x'

iomap' :: (a -> b) -> IO a -> IO b
iomap' f x = x >>= (\x' -> x $> f x')

mapIO :: (a -> IO b) -> [a] -> IO [b]
mapIO f = foldr (\x xs -> do
                             y <- f x
                             xs' <- xs
                             return $ y : xs') (return [])

zipWithIO :: (a -> b -> IO c) -> [a] -> [b] -> IO [c]
zipWithIO f _ [] = return $ []
zipWithIO f [] _ = return $ []
zipWithIO f (x:xs) (y:ys) = do
                                r <- f x y
                                rs <- zipWithIO f xs ys
                                return $ r : rs

zipWithIO_ :: (a -> b -> IO c) -> [a] -> [b] -> IO ()
zipWithIO_ f xs ys = zipWithIO f xs ys >> skip
--zipWithIO_ f _ [] = skip
--zipWithIO_ f [] _ = skip
--zipWithIO_ f (x:xs) (y:ys) = f x y >> zipWithIO_ f xs ys

sequenceIO :: [IO a] -> IO [a]
sequenceIO [] = return []
sequenceIO (x:xs) = do
                        x' <- x
                        xs' <- sequenceIO xs
                        return $ (x':xs')

sequenceIO_ :: [IO a] -> IO ()
sequenceIO_ xs = sequenceIO xs >> skip
--sequenceIO_ [] = return ()
--sequenceIO_ (x:xs) = x >> sequenceIO_ xs

replicateIO :: Integral i => i -> IO a -> IO [a]
replicateIO 0 f = return $ []
replicateIO i f = do 
                    r <- f
                    rs <- replicateIO (i-1) f
                    return $ r : rs

replicateIO_ :: Integral i => i -> IO a -> IO ()
replicateIO_ i f = replicateIO i f >> skip
--replicateIO_ 0 f = skip
--replicateIO_ i f = f >> replicateIO_ (i-1) f

forIO :: [a] -> (a -> IO b) -> IO [b]
forIO [] f = return $ []
forIO (x:xs) f = do
                    r <- f x
                    rs <- forIO xs f
                    return $ r : rs

forIO_ :: [a] -> (a -> IO b) -> IO ()
forIO_ xs f = forIO xs f >> skip
--forIO_ [] f = skip
--forIO_ (x:xs) f = f x >> forIO_ xs f

joinIO :: IO (IO a) -> IO a
joinIO f = do
                r' <- f
                r'

foldlIO :: (b -> a -> IO b) -> b -> [a] -> IO b
foldlIO f k [] = return $ k
foldlIO f k (x:xs) = do
                        r <- f k x
                        foldlIO f r xs

foldlIO_ :: (b -> a -> IO b) -> b -> [a] -> IO ()
foldlIO_ f k xs = foldlIO f k xs >> skip
