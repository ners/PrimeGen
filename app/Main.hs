{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prime ( genPrime )
import Haiku ( getHaiku )

import Data.ByteString.Lazy.UTF8 ( fromString )
import Data.Maybe ( catMaybes )
import Data.Text ( unpack )
import Network.HTTP.Types ( status200, status404 )
import Network.HTTP.Types.Header ( hContentType )
import Network.Wai ( responseLBS, pathInfo, Application )
import Network.Wai.Handler.Warp ( run )
import Text.Read ( readMaybe )

main :: IO ()
main = do
    let port = 3000
    putStrLn $ "Listening on port " ++ show port
    run port app

app :: Application
app req f = if length bits /= length parts
           then getHaiku >>= answer status404
           else mapM genPrime bits >>= answer status200 . (show <$>)
    where
        parts = let pi = pathInfo req in if null pi then ["1000"] else pi
        bits = catMaybes $ readMaybe . unpack <$> parts
        headers = [(hContentType, "text/plain")]
        answer status lines =
            f $ responseLBS status headers $ fromString $ unlines lines
