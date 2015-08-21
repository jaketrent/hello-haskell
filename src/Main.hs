module Main where

import System.IO (readFile)
import Data.Time (getCurrentTime)

printTime :: IO ()
printTime = do
  time <- getCurrentTime
  putStrLn (show time)

printConfig :: IO ()
printConfig = do
  contents <- readFile "stack.yaml"
  putStrLn contents

printNumbers :: IO ()
printNumbers = do
  putStrLn (show (3 + 4))

greet :: String -> String
greet name = "Hello " ++ name ++ "!"

-- explicit return for primitive value
sayHello :: IO String
sayHello = do
  name <- getLine
  putStrLn ("Hello " ++ name)
  return name

-- will always return Nothing because this is Maybe monad behavior
beCareful :: Maybe Int
beCareful = do
  Just 6
  Nothing
  return 5

main :: IO () -- () = unit youtube algebraic data types
main = do
  putStrLn (greet "bobby")
  putStrLn (greet "World")
  printNumbers
  printConfig
  printTime

