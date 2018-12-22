{-
 - Encountered errors:
 - * n instead of N in the function name
 - * it used `` div, instead of single quotes (but that is not wrong in ghc)
 - * ns instead of xs (but I think that a convention error is not a 
 - syntactic error...)
 -}

n = a `div` length ns
    where
        a = 10
        ns = [1,2,3,4,5]
