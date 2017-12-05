import tables
import options
import algorithm
from sequtils import deduplicate, filter, map
from strutils import split
from utils import getInputForProblem

proc toString(str: seq[char]): string =
  result = newStringOfCap(len(str))
  for ch in str:
    add(result, ch)

proc sortString(str: string): string =
  toString(sorted(str, cmp))

proc isValid(passphrases: seq[string]): bool =
  passphrases.len() == deduplicate(passphrases).len()

proc problem7*(): int =
  let lines = getInputForProblem(4)
  let phrases = map(lines, proc (str: string): seq[string] = str.split())
  filter(phrases, isValid).len()

proc problem8*(): int =
  let lines = getInputForProblem(4)
  let phrases = map(lines, proc (str: string): seq[string] = map(str.split(), sortString))
  filter(phrases, isValid).len()
