module Lib where

import System.Random ( getStdGen, randomRs )
import Math.NumberTheory.Primes.Testing (isPrime)

genPrime :: Int -> IO Integer
genPrime bits = do
        g <- getStdGen
        let nums = randomRs (min, max) g
        return $ head $ filter isPrime nums
    where min = 2^bits + 1
          max = 2^(bits + 1) - 1
