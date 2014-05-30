# My ditherings in haskell

A web app. 


To run:

Make sure you have an up to date version of cabal.

You will also need to have a MongoDB instance running in localhost. (Feel free to implement this as config)
```
cabal sandbox init
cabal install
cabal run Main
```


cabal install --only-dependencies - you may also need from time to time.

Main - shows a few ways to use scotty: returning text, returning json. The expected return type causes haskel to infer how to lift it from the IO monad
into the scotty ActionM. 
In some cases it is test, in others, it is the result of an external web service call - which is parsing json into a data type.


