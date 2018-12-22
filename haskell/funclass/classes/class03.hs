{-

sin é a função; sin(x) é o valor dela em x

f: R->R    x:R
--------------
f(x) : R

funções sem nome podem ser muito úteis

aquela funcao que recebendo uma entrada x, retorna x^2+1
---------------------------------------    -------
				\lambda x     .    x^2+1

função de order alta: recebe ou retorna uma função
permite aplicação parcial, que retorna algo útil (funções),
mesmo não recebendo todos os argumentos 

haskell encoraja o uso de funções de order alta por isso: currificação

-}

module Curry where

import Prelude hiding ( curry, uncurry )

pyth :: Double -> Double -> Double
pyth x y = sqrt (x ** 2 + y ** 2 )

f = pyth 1

pyth' :: (Double, Double) -> Double
pyth' (x, y) = sqrt (x ** 2 + y ** 2 )

curry :: ((Double, Double) -> Double) -> (Double -> Double -> Double)
curry f x y = f (x,y)

uncurry :: (Double -> Double -> Double) -> ((Double, Double) -> Double)
uncurry f (x,y) = f x y
