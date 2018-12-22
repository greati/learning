module UnzipCross where

import qualified Prelude as P

pair (f,g) x = (f x, g x)

unzip = pair (P.map P.fst, P.map P.snd)
cross (f,g) = pair (f P.. P.fst,g P.. P.snd)
