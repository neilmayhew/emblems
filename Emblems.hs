module Emblems where

import Data.List
import Data.Maybe
import Data.ByteString.UTF8 as UTF8 (fromString)
import System.GIO.File.File
import System.GIO.File.FileInfo
import Graphics.UI.Gtk (initGUI, iconThemeGetDefault, iconThemeListIcons)

emblemsInit = initGUI

adjustEmblems adjust filename = do
    let f = fileFromCommandlineArg $ fromString filename
    i <- fileQueryInfo f "metadata::emblems" [] Nothing
    es <- fileInfoGetAttributeStringList i "metadata::emblems"
    let es' = adjust es
    i' <- fileQueryInfo f "metadata::emblems" [] Nothing
    fileInfoSetAttributeStringList i' "metadata::emblems" es'
    fileSetAttributesFromInfo f i' [] Nothing

getEmblems filename = do
    let f = fileFromCommandlineArg $ fromString filename
    i <- fileQueryInfo f "metadata::emblems" [] Nothing
    fileInfoGetAttributeStringList i "metadata::emblems"

allEmblems = do
    iconThemeGetDefault
        >>= flip iconThemeListIcons (Just "Emblems")
        >>= return . map stripEmblem
  where
    stripEmblem n = fromMaybe n . stripPrefix "emblem-" $ n
