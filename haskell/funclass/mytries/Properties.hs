take n xs ++ drop n xs = xs
take m . drop n = drop n . take (m + n)
take m . take n = take (min (m, n))
drop m . drop n = drop (m + n)
map g . map f = map (g . f)

cross (f,g) . pair (h,k) = cross (f.h, g.k)
pair (f,g) . h = pair (f.h, g.h)
fst . cross (f,g) = f . fst
snd . cross (f,g) = g . fst
cross (f,g) . cross (h,k) = cross (f.h, g.k)

sum . map double =?= double . sum -- distrib
sum . map sum =?= sum . concat      -- assoc
sum . sort =?= sum      -- comm

map f . reverse =?= reverse . map f
concat . map concat =?= concat . concat
filter p . map f =?= map f . filter (p . f)
