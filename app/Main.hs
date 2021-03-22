{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib ( genPrime )

import Data.ByteString.Lazy.UTF8 ( fromString )
import Data.Text ( unpack )
import Network.HTTP.Types ( status200 )
import Network.HTTP.Types.Header ( hContentType )
import Network.Wai ( responseLBS, pathInfo, Application )
import Network.Wai.Handler.Warp ( run )

main :: IO ()
main = do
    let port = 3000
    putStrLn $ "Listening on port " ++ show port
    run port app

app :: Application
app req f = do
        primes <- mapM genPrime bits
        let body = fromString $ unlines $ show <$> primes
        f $ responseLBS status200 [(hContentType, "text/plain")] body
    where
        bits = read . unpack <$> pathInfo req
