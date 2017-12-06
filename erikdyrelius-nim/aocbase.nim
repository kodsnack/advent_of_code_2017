import os
import strutils

proc getInpData*(): string =
    var
        filename = getAppFilename()
    if filename.toLowerAscii.endswith(".exe"):
        filename = filename.substr(0, filename.len-4) & "txt"
    try:
        result = open(filename).readAll()
    except:
        result = ""

    