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


data Jobs = 
	Jobs {
		jobs :: [Job]
	} deriving (Show, Generic)

data Job =
	Job {
		name :: !Text,
		url :: !Text
	} deriving (Show, Generic)


instance FromJSON Job
instance ToJSON Job

instance FromJSON Jobs
instance ToJSON Jobs
	

-- | Location of the local copy, in case you have it,
--   of the JSON file.
jsonFile :: FilePath
jsonFile = "pizza.json"

-- | URL that points to the remote JSON file, in case
--   you have it.
jsonURL :: String
jsonURL = "http://daniel-diaz.github.io/misc/pizza.json"

jenkinsApi :: String
jenkinsApi = "https://gist.githubusercontent.com/michaelneale/6c8f494100e37d33424d/raw/aa09039b180a704629d5c9c844d64c43b511bf06/gistfile1.json"

fetchJenkins :: IO B.ByteString
fetchJenkins = simpleHttp jenkinsApi
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

example2 :: IO (Maybe [Person])
example2 = decode <$> getJSON


example3 = encode <$> example2

jenkins = decodeUtf8 <$> fetchJenkins

jenkinsJob :: IO (Maybe Jobs)
jenkinsJob = decode <$> fetchJenkins

jenkinsJobAndBack = encode <$> jenkinsJob

