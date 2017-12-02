from os import getAppDir
from strutils import `%`, intToStr, splitLines, strip

template `charToInt`*(c: char): int =
  int(c) - int('0')

template `addMod`*(x, toAdd, cap: int): int =
  (x + toAdd) mod cap

proc getInputForProblem*(number: int): seq[string] =
  let filePath = "$1/../input/$2.in" % [os.getAppDir(), intToStr(number)]
  let fileContents = readFile(filePath)
  splitLines(fileContents)

