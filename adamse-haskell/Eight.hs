{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
-- |
module Main where

-- megaparsec
import qualified Text.Megaparsec as P
import qualified Text.Megaparsec.Char as P
import qualified Text.Megaparsec.Char.Lexer as L

import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text

import Data.Map (Map)
import qualified Data.Map as Map

import Data.Void (Void)
import Control.Applicative ((<|>), empty)

import Prelude hiding (lookup)

-- * Syntax

type Reg = Text

data Ins = Inc | Dec
  deriving (Show)

data Cond = Cond Reg (Int -> Bool)

instance Show Cond where
  show (Cond r _) = "Cond " ++ show r ++ " <op>"

-- * Execution

type RegMap = Map Reg Int
rm0 = Map.empty

lookup :: Reg -> RegMap -> Int
lookup r m = maybe 0 id $ Map.lookup r m

test :: Cond -> RegMap -> Bool
test (Cond reg op) = op . lookup reg

execute :: (Reg, Ins, Int, Cond) -> (Int, RegMap) -> (Int, RegMap)
execute (reg, ins, val, cond) (m, rm) =
  if test cond rm
  then (max m val1, Map.insert reg val1 rm)
  else (m, rm)
  where
    val1 = lookup reg rm +- val
    (+-) = case ins of
      Inc -> (+)
      Dec -> (-)

-- * Solutions

testExecute :: Text -> RegMap
testExecute = snd . flip execute (minBound, rm0) . (\(Right x) -> x) . runParser lineP

sol1 = maximum . snd . foldl (flip execute) (minBound, rm0)
sol2 = fst . foldl (flip execute) (minBound, rm0)

main = do
  inp <- Text.readFile "input8.txt"
  case runParser fileP inp of
    Left e -> putStrLn $ P.parseErrorPretty e
    Right inss -> do
      print ("p1", sol1 inss)
      print ("p1", sol2 inss)

-- * Parser

type Parser = P.Parsec Void Text

runParser :: Parser a -> Text -> Either (P.ParseError Char Void) a
runParser p i = P.parse p "" i

spaceP = L.space P.space1 empty empty
symP = L.symbol spaceP
lexP = L.lexeme spaceP

fileP = P.many lineP

lineP :: Parser (Reg, Ins, Int, Cond)
lineP = (,,,) <$> regP <*> insP <*> amountP <*> condP

regP :: Parser Reg
regP = lexP . P.try $ fmap Text.pack p
  where
    p :: Parser [Char]
    p = (:) <$> P.letterChar <*> P.many P.letterChar

insP =
  (symP "inc" *> pure Inc)
  <|>
  (symP "dec" *> pure Dec)

amountP = lexP $ L.signed spaceP L.decimal

condP = do
  symP "if"
  reg <- regP
  op <- opP
  i <- amountP
  pure (Cond reg (op i))

opP = P.choice . flip map opTable $ \(s, op) ->
  symP s *> pure (flip op)

opTable :: [(Text, Int -> Int -> Bool)]
opTable =
  [ (">=", (>=))
  , ("<=", (<=))
  , ("!=", (/=))
  , ("==", (==))
  , (">", (>))
  , ("<", (<))
  ]
