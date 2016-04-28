module Emblems where

import Control.Monad (when)
import Data.List
import Data.Maybe
import Data.ByteString.UTF8 as UTF8 (fromString)
import System.GIO.File.File
import System.GIO.File.FileInfo
import Graphics.UI.Gtk (initGUI, iconThemeGetDefault, iconThemeListIcons)

emblemsInit :: IO [String]
emblemsInit = initGUI -- returns the unused cmdline args

adjustEmblems :: ([String] -> [String]) -> FilePath -> IO ()
adjustEmblems adjust filename = do
    es <- getEmblems filename
    let es' = adjust es
    when (es' /= es) $
        setEmblems filename es'

getEmblems :: FilePath -> IO [String]
getEmblems filename = do
    let f = fileFromCommandlineArg $ fromString filename
    i <- fileQueryInfo f "metadata::emblems" [] Nothing
    fileInfoGetAttributeStringList i "metadata::emblems"

setEmblems :: FilePath -> [String] -> IO ()
setEmblems filename es = do
    let f = fileFromCommandlineArg $ fromString filename
    i <- fileQueryInfo f "metadata::emblems" [] Nothing
    fileInfoSetAttributeStringList i "metadata::emblems" es
    fileSetAttributesFromInfo f i [] Nothing

allEmblems :: IO [String]
allEmblems = do
    iconThemeGetDefault
        >>= flip iconThemeListIcons (Just "Emblems")
        >>= return . map stripEmblem
  where
    stripEmblem n = fromMaybe n . stripPrefix "emblem-" $ n
