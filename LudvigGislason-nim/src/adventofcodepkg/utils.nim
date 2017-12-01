from os import getAppDir
from strutils import `%`, intToStr

template `charToInt`*(c: char): int =
    int(c) - int('0')

template `addMod`*(x, toAdd, cap: int): int =
    (x + toAdd) mod cap

proc getInputForProblem*(number: int): string =
    let filePath = "$1/../input/$2.in" % [os.getAppDir(), intToStr(number)]
    var
        f: File
        inputString = ""
    if not open(f, filePath):
        raise newException(IOError, "Failed to open input file at " & filePath)
    discard readLine(f, inputString)
    inputString