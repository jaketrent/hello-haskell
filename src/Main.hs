{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Data.Aeson (FromJSON, ToJSON)
import Data.Monoid ((<>))
import GHC.Generics
import Web.Scotty

data User = User { userId :: Int, userName :: String } deriving (Show, Generic)

instance ToJSON User
instance FromJSON User

bob :: User
bob = User { userId = 1, userName = "bob" }

jenny :: User
jenny = User { userId = 2, userName = "jenny" }

allUsers :: [User]
allUsers = [bob, jenny]

matchesId :: Int -> User -> Bool
matchesId id user = userId user == id -- userId is a magical generated function from User def

routes :: ScottyM ()
routes = do
  get "/hello" hello
  get "/hello/:name" helloName
  get "/users" users
  get "/users/:id" usersId

helloName :: ActionM ()
helloName = do
  name <- param "name"
  text ("hello " <> name <> "!")

hello :: ActionM ()
hello = do
  text "Hello, everyone"

users :: ActionM ()
users = do
  json allUsers

usersId :: ActionM ()
usersId = do
  id <- param "id"
  json (filter (matchesId id) allUsers)

main :: IO ()
main = do
  putStrLn "Starting server..."
  scotty 3000 routes
