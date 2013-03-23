module Main where

import Data.List
import Data.Maybe
import Graphics.UI.Gtk

main = do
    initGUI
    iconThemeGetDefault
        >>= flip iconThemeListIcons (Just "Emblems")
        >>= mapM_ putStrLn . sort . map stripEmblem

stripEmblem n = fromMaybe n . stripPrefix "emblem-" $ n
