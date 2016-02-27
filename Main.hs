{-# LANGUAGE DeriveDataTypeable #-}

module Main where

import Emblems

import Data.List
import Control.Monad
import Text.Printf
import System.Environment
import System.Console.CmdArgs.Implicit

data Options = Options
    { argFiles   :: [String]
    , optAdd     :: [String]
    , optDelete  :: [String]
    , optList    :: Bool
    , optVerbose :: Bool
    } deriving (Show, Data, Typeable)

options = Options
    { argFiles      =    [] &= args                       &= typ "FILE ..."
    , optAdd        =    [] &= name "add"     &= name "a" &= typ "EMBLEM,EMBLEM,.." &= explicit &= help "Emblems to add"
    , optDelete     =    [] &= name "delete"  &= name "d" &= typ "EMBLEM,EMBLEM,.." &= explicit &= help "Emblems to delete"
    , optList       = False &= name "list"    &= name "l"                           &= explicit &= help "List possible emblems"
    , optVerbose    = False &= name "verbose" &= name "v"                           &= explicit &= help "Verbose output"
    }   &= program "emblems"
        &= summary "Manipulate file emblems"
        &= versionArg [summary "emblems 1.0"]
        &= details
        [ "A typical emblem name is \"default\""
        , ""
        , "Examples:"
        , "    emblems FILE1 FILE2"
        , "    emblems -a default FILE1"
        , "    emblems -d default FILE1 FILE2" ]

main = do
    args <- cmdArgs options
    let adds    = concatMap (split ',') (optAdd args)
        dels    = concatMap (split ',') (optDelete args)
        verbose = optVerbose args || null adds && null dels
        adjust = (`union` adds) . (\\ dels) . nub
    files <- withArgs (argFiles args) emblemsInit -- Allow GTK options to be given (after --)
    when (optList args) $
        mapM_ putStrLn  . sort =<< allEmblems
    forM_ files $ \fn -> do
        adjustEmblems adjust fn
        when verbose $
            putStrLn . printf "%s: %s" fn . intercalate "," =<< getEmblems fn

split :: Eq a => a -> [a] -> [[a]]
split _ [] = []
split c s  = h : split c (drop 1 t)
  where (h, t) = break (== c) s
