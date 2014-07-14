import Paths_proverb (getDataFileName)
import System.Random (RandomGen, getStdGen, randomRs)
import Data.Maybe (fromJust)

main :: IO ()
main = do
	input <- getDataFileName "proverbs.txt" >>= readFile
	gen <- getStdGen
	putStrLn $ fromJust $ roulette (lines input) gen

roulette :: RandomGen g => [a] -> g -> Maybe a
roulette [] _ = Nothing
roulette (item:items) gen =
	Just $ roulette' 2 item (zip items (randomRs (0, 1) gen))

roulette' :: Int -> t -> [(t, Float)] -> t
roulette' _ chosen [] = chosen
roulette' depth chosen ((item, roll):rest) =
	let chosen' = if roll < 1 / (fromIntegral depth) then item else chosen in
	roulette' (depth + 1) chosen' rest
