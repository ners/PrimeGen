module Prime ( genPrime ) where

import System.Random ( randomRIO )
import Math.NumberTheory.Primes.Testing ( isPrime )

untilJust :: Monad m => m (Maybe a) -> m a
untilJust m = go
    where go = m >>= maybe go return

maybePrime :: Integer -> Maybe Integer
maybePrime n | isPrime n = Just n
             | otherwise = Nothing

genPrime :: Int -> IO Integer
genPrime bits = untilJust $ maybePrime <$> randomRIO (min, max)
    where min = 2^bits + 1
          max = 2^(bits + 1) - 1
