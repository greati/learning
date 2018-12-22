{- Questao 01: 

Crie a função Haskell for_to :: Int -> Int -> (Int -> IO ()) -> IO () tal que
for_to a b f, onde a <= b, equivale à sequência de aplicações f a, f (a+1), ... 
f b. -}
   
--for_to :: Monad m => Int -> Int -> (Int -> m a) -> m a
for_to :: Int -> Int -> (Int -> IO ()) -> IO ()
for_to a b f = if a == b then f a
               else if a < b then 
                      do f a
                         for_to (a + 1) b f
                    else return ()
                    
{- Por exemplo,

Main> for_to 1 3 print
1
2
3

Main>  -}
                    
{- Questao 02:

Crie a função Haskell while :: Int -> (Int -> Bool) -> (Int -> IO ()) -> (Int -> Int) -> IO ()
tal que while i cond op update corresponde a executar a operação op k, enquanto
cond k for verdadeiro, para k = i, update i, update (update i), .... -}

while :: Int -> (Int -> Bool) -> (Int -> IO ()) -> (Int -> Int) -> IO ()
while k cond op update = 
    if cond k then  
       do op k
          while (update k) cond op update
    else return ()

{- Por exemplo,

Main> while 4 ((<=) 1) (print) (let f x = x - 1 in f)
4
3
2
1

Main>  -}

{- Questao 03: 

Sem utilizar a função pré-definida (!!), crie a função Haskell ListNth :: [a] -> 
Int -> a tal que ListNth l i retorna o i-ésimo elemento da lista l, considerando 
que os índices se iniciam em zero. -}

listNth :: [a] -> Int -> a
listNth [] _ = error "Index out of bounds"
listNth (a:x) 0 = a
listNth (a:x) n = listNth x (n-1)

{- Por exemplo,

listNth [1,2,3,4,5] 3

produz o valor 4. -}

{- Questao 04:
Crie a função Haskell listUpdate :: [a] -> Int -> a -> [a] tal que, listUpdate l i v 
retorna uma nova lista l' correspondente à atualização da i-ésima posição de l com
o valor v, considerando que os índices se iniciam em zero. -}

listUpdate :: [a] -> Int -> a -> [a]
listUpdate [] _ _ = error "Index out of bounds"
listUpdate (a:x) 0 v = v : x
listUpdate (a:x) n v = a : listUpdate x (n - 1) v

{- Por exemplo, 

listUpdate [1,2,3,4,5] 2 99

produz a lista [1,2,99,4,5] -}

{- Questao 05:

O seguinte tipo pode ser utilizado para representar funções de uma variável sobre
os números reais: -}

data Real_Exp = Var String | Cons Float |
                Sub (Real_Exp, Real_Exp) |
                Som (Real_Exp, Real_Exp) |
                Mul (Real_Exp, Real_Exp) |
                Div (Real_Exp, Real_Exp)
                       
{- Por exemplo, o valor Som(Var, Cons 2.0) corresponde à expressão x+2, onde x 
corresponde a uma variável. 

Defina a função avalie :: Real_Exp -> [(String, Float)] -> Float que, para um valor 
Real_Exp, representando uma expressão real, uma lista l de pares (id, valor) 
representando identificadores de variáveis e seus valores correspondentes, retorna 
o valor real representado pela expressão dado o contexto l. -}

avalie :: Real_Exp -> [(String, Float)] -> Float
avalie (Var s) l = buscar s l
avalie (Cons v) _ = v
avalie (Sub (e1,e2)) l = avalie e1 l - avalie e2 l
avalie (Som (e1,e2)) l = avalie e1 l + avalie e2 l
avalie (Mul (e1,e2)) l = avalie e1 l * avalie e2 l
avalie (Div (e1,e2)) l = avalie e1 l / avalie e2 l

buscar :: String -> [(String, Float)] -> Float
buscar _ [] = error "Variavel nao definida"
buscar s ((i,v):x) = if s == i then v
                     else buscar s x
                     
{- Por exemplo, a expressão 

avalie (Mul(Var "y", Som (Cons 2.5, Var "x"))) [("x", 0.5), ("y", 2.0)]

produz valor 6.0. -}