{-
 - 1.
 - Yes
 - No
 - Yes
 - No
 - No
 - Yes
 - No
 - Yes
 -
 - 2.
 - a d
 - b c
 - c e
 - d a
 - e b
 -
 - -}


{- 1.
 - a. "Curry is awesome" ++ "!"
 - b. "Curry is awesome!" !! 4
 - c. drop 9 "Curry is awesome!" 
 - -}

-- 2
myPlus :: [Char] -> [Char] -> [Char]
myPlus s1 s2 = s1 ++ s2

myInd :: [Char] -> Int -> Char
myInd s1 i = s1 !! i

myDrop :: Int -> [Char] -> [Char]
myDrop i s = drop i s

-- 3
thirdLetter :: [Char] -> Char
thidLetter s = s !! 2

-- 4
myLetter :: Int -> Char
myLetter i = "Curry is awesome!" !! i

-- 5: i refuse to...

-- 6: unnecessary...



