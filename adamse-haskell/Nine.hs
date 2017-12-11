-- |
module Main where

-- megaparsec
import qualified Text.Megaparsec as P
import qualified Text.Megaparsec.Char as P

import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text

import Data.Void (Void)

data Syn
  = Group [Syn]
  | Garbage Text
  deriving (Show)

score :: Syn -> Int
score = go 1
  where
    go nest (Group subs) = nest + sum (map (go (succ nest)) subs)
    go _ _ = 0

countGarbage :: Syn -> Int
countGarbage = go
  where
    go (Group ns) = sum (map go ns)
    go (Garbage g) = Text.length g

main = do
  inp <- Text.readFile "input9.txt"
  case runParser synP inp of
    Left err -> putStrLn $ P.parseErrorPretty err
    Right syn -> do
      print ("p1", score syn)
      print ("p2", countGarbage syn)

type Parser = P.Parsec Void Text

testParse :: Parser a -> Text -> a
testParse p i = (\(Right x) -> x) (runParser p i)

runParser :: Parser a -> Text -> Either (P.ParseError Char Void) a
runParser p i = P.parse p "" i

synP :: Parser Syn
synP = Garbage <$> garbageP P.<|> Group <$> groupP synP

garbageP :: Parser Text
garbageP =
  openP *> (mconcat <$> P.many (ignoreP P.<|> otherP)) <* closeP
  where
    openP = Text.singleton <$> P.char '<'
    closeP = Text.singleton <$> P.char '>'
    ignoreP = P.char '!' *> P.anyChar *> pure Text.empty
    otherP = Text.singleton <$> P.notChar '>'

groupP :: Parser a -> Parser [a]
groupP ap =
  openP *> (ap `P.sepBy` commaP) <* closeP
  where
    openP = Text.singleton <$> P.char '{'
    closeP = Text.singleton <$> P.char '}'
    commaP = P.char ','
