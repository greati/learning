module Time where

import Date.Time.Clock

getCurSeconds :: IO Integer
getCurSeconds = do
                    t <- getCurrentTime
                    i <- return $ utctDayTime t
                    return $ diffTimeToPicoseconds i
