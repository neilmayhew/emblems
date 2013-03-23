module Emblems where

import Data.ByteString.Char8 (pack)
import System.GIO.File.File
import System.GIO.File.FileInfo
import System.Glib.GType (glibTypeInit)

emblemsInit = glibTypeInit

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
