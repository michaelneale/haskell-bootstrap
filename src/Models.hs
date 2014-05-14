{-# LANGUAGE TemplateHaskell, QuasiQuotes,
             TypeFamilies, EmptyDataDecls,
             FlexibleContexts, FlexibleInstances, GADTs,
             OverloadedStrings, DeriveGeneric #-}

module Models where




import GHC.Generics
import Data.Aeson
import Data.Text

import Control.Applicative
--import Control.Monad
--import Control.Monad.IO.Class (liftIO)


import qualified Data.ByteString.Lazy as B


import Data.Text.Lazy.Encoding

import Network.HTTP.Conduit (simpleHttp)
import GHC.Generics


-- | Type of each JSON entry in record syntax.
data Person =
  Person { firstName  :: !Text
         , lastName   :: !Text
         , age        :: Int
         , likesPizza :: Bool
           } deriving (Show,Generic)

-- Instances to convert our type to/from JSON.

instance FromJSON Person
instance ToJSON Person

-- | Location of the local copy, in case you have it,
--   of the JSON file.
jsonFile :: FilePath
jsonFile = "pizza.json"

-- | URL that points to the remote JSON file, in case
--   you have it.
jsonURL :: String
jsonURL = "http://daniel-diaz.github.io/misc/pizza.json"

-- Move the right brace (}) from one comment to another
-- to switch from local to remote.

{--
-- Read the local copy of the JSON file.
getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile
--}

{--}
-- Read the remote copy of the JSON file.
getJSON :: IO B.ByteString
getJSON = simpleHttp jsonURL
--}

-- damn it need to convert vetween the bytstring types here (not sure if using applicative on RHS or on result)
example1 = decodeUtf8 <$> getJSON