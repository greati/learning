module Mood where

data Mood = Blah | Woot deriving Show

{- 1. Mood
 - 2. Blah and Woot
 - 3. It is taking the data constructor, not type constructor
 - 4. 
 - -}

changeMood :: Mood -> Mood
changeMood Blah = Woot
changeMood _ = Blah
