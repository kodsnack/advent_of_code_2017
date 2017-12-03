import sys
import os


def readInput():
	thisFile = os.path.split(sys.argv[0])[1]
	thisFileBase = os.path.splitext(thisFile)[0]
	theTextFile = thisFileBase+'.txt'
	return open(theTextFile).read().strip()
