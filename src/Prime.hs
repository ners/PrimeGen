module Prime ( genPrime ) where

import System.Random ( randomRIO )
import Math.NumberTheory.Primes.Testing ( isPrime )

untilJust :: Monad m => m (Maybe a) -> m a
untilJust m = go
    where go = m >>= maybe go return

genPrime :: Int -> IO Integer
genPrime bits = do
        untilJust $ do
            n <- randomRIO (min, max)
            return $ if isPrime n
               then Just n
               else Nothing
    where min = 2^bits + 1
          max = 2^(bits + 1) - 1
