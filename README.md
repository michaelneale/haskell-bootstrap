# My ditherings in haskell

[![Git](https://app.soluble.cloud/api/v1/public/badges/e71147d1-f872-4e33-94c2-196ddd6bc8b6.svg?orgId=451115019187)](https://app.soluble.cloud/repos/details/github.com/michaelneale/haskell-bootstrap?orgId=451115019187)  

A web app. This is helping me learn scotty and types, IO monad, json/aeson and more in haskell. 
My aim is to make this my bootstrap for web app microservices. 

First class JSON, and built in healthchecks are the first aims. 


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


