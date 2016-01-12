module Emblems where

import Data.ByteString.Char8 (pack)
import Data.List
import Data.Maybe
import System.GIO.File.File
import System.GIO.File.FileInfo
import Graphics.UI.Gtk (initGUI, iconThemeGetDefault, iconThemeListIcons)

emblemsInit = initGUI

adjustEmblems adjust filename = do
    let f = fileFromCommandlineArg $ pack filename
    i <- fileQueryInfo f "metadata::emblems" [] Nothing
    es <- fileInfoGetAttributeStringList i "metadata::emblems"
    let es' = adjust es
    i' <- fileQueryInfo f "metadata::emblems" [] Nothing
    fileInfoSetAttributeStringList i' "metadata::emblems" es'
    fileSetAttributesFromInfo f i' [] Nothing

getEmblems filename = do
    let f = fileFromCommandlineArg $ pack filename
    i <- fileQueryInfo f "metadata::emblems" [] Nothing
    fileInfoGetAttributeStringList i "metadata::emblems"

allEmblems = do
    iconThemeGetDefault
        >>= flip iconThemeListIcons (Just "Emblems")
        >>= return . map stripEmblem
  where
    stripEmblem n = fromMaybe n . stripPrefix "emblem-" $ n
