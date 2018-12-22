{-
 - Using reverse.
 -}
my_init_reverse xs = reverse (drop 1 (reverse xs))

{-
 - Using take.
 -}
my_init_take xs = take (length xs - 1) xs
