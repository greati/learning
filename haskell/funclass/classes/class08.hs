module Class08 (toUpper) where

import qualified Data.Char as C
import Data.List (sort)
import Test.QuickCheck

{-
 - Literate programming
 -
 - :browse  - ver assinaturas de funções em módulos
 - :info    - ver detalhes de uma classe
 -
 - :info (+)
 - infixl 6 + ~> a + b + c é entendida como (a + b) + c, infixo à esquerda, 6 se refere à precedência
 -
 - List comprehension
 -
 - zip
 - zipwith
 - repeat
 - any
 - all
 -
 - Testar max3, usando prop_max3
 -
 - Cuidado com testes envolvendo Double.
 -
 - Uso de let..in
 -
 - where não cria uma expressão, let sim.
 - -}

(+++) :: Integer -> Integer -> Integer
(+++) = (+)
infixl 9 +++
 --
 --Importação qualificada: obriga prefixação do módulo
 --Na definição do módulo, é possível informar as funções a serem exportadas

toUpper :: Integer
toUpper = 42

myZipwith ::  (a -> b -> c) -> [a] -> [b] -> [c]
myZipwith = undefined
