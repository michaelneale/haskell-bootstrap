{-# LANGUAGE TemplateHaskell, QuasiQuotes,
             TypeFamilies, EmptyDataDecls,
             FlexibleContexts, FlexibleInstances, GADTs,
             OverloadedStrings, DeriveGeneric #-}

module Models where




import GHC.Generics
import Data.Aeson

data Point = Point { _x :: Double, _y :: Double }
   deriving (Show, Generic)

instance FromJSON Point
instance ToJSON Point


someJson = "{\"x\":3.0,\"y\":-1.0}"

example1 :: Maybe Point
example1 = decode someJson

