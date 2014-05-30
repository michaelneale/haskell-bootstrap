{-# LANGUAGE OverloadedStrings, ScopedTypeVariables, RecordWildCards,
             QuasiQuotes, TemplateHaskell #-}

module Main where

import Prelude hiding (product)

import Network.HTTP.Types
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import Web.Scotty
import Data.Aeson.Types           (ToJSON)
import Control.Applicative
import Control.Monad.IO.Class (liftIO)



import Models

main :: IO()
main = do
  
    scotty 3000 $ do
      middleware logStdoutDev
      middleware $ staticPolicy (noDots >-> addBase "public")
      get "/" $
        redirect "index.html"
      
      get "/text" $ 
        liftIO example1 >>= text


      get "/jenkins" $
        liftIO jenkins >>= text

      get "/jobs" $ 
        liftIO jenkinsJobAndBack >>= json

      notFound $ do
        status notFound404
        html $ "<h1>Not found :(</h1>"

