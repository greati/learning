{- 
 - Types and Values
 -
 - :k <some type>
 - :k <some typeclass>
 -
 - o Bool tem três valores: True, False e "Bottom", pois Bool não tem construtor de tipo
 - 
 - atLeastOne == bottom roda infinitamente
 - infinity é maior que cada um dos outros Zero, Succ Zero, Succ(Succ Zero), ...
 - 
 - bottom existe para qualquer tipo
 -
 - mostrar que dois valores são diferentes: encontrar uma propriedade
 -
 - -}
import ExNat

bottom :: Nat
bottom = bottom

atLeastOne :: Nat
atLeastOne = Succ bottom

atLeastTwo :: Nat
atLeastTwo = Succ (Succ bottom)

atLeast :: Integer -> Nat
atLeast 0 = bottom
atLeast n = Succ $ atLeast $ (n - 1)

infinity :: Nat
infinity = Succ infinity
