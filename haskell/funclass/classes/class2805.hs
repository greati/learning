module Class25 where

data DbObject = DbString String | DbBool Bool | DbInt Int deriving (Show, Eq)

examples = [DbString "vitor", DbInt 29, DbString "   ola", DbBool True, DbInt 87]

counts :: [DbObject] -> (String, Int)
counts [] = ([],0)
counts (o:os) = case o of
                    DbString s -> (s ++ ss', vs')
                    DbInt i -> (ss', i + vs')
                    _ -> (ss',vs')
               where (ss',vs') = counts os

-- How to do it with folds?


--------------------------------------------

--data Person = Person String Int deriving (Show)

--age :: Person -> Int
--age (Person _ i) = i

--name :: Person -> String
--name (Person n _) = n

-- better records!

data Person = Person 
        {
            age :: Int
        ,   name :: String
        } deriving (Show)

type Age = Int
type Name = String

data PersonError = InvalidAge | InvalidName 

mkPerson :: Name -> Age -> Maybe Person
mkPerson x n 
    | x == "" || n < 0 = Nothing
    | otherwise = Just (Person n x)

mkPerson' :: Name -> Age -> Either String Person
mkPerson' x n 
    | x == "" = Left "Empty name not allowed."
    | n < 0 = Left "Negative age not allowed."
    | otherwise = Right (Person n x)

-- it doesnt make sense to encode errors as strings

-- how to accumulate errors?!
mkPerson'' :: Name -> Age -> Either [PersonError] Person
mkPerson'' x n 
    | x == "" = Left []
    | n < 0 = Left []
    | otherwise = Right (Person n x)

even' :: Maybe Int -> Maybe Bool
even' Nothing = Nothing
even' (Just i) = Just (even i)

thanos :: Person
thanos = Person {name = "Thanos", age = 20}

---------------------------------------------------------------


