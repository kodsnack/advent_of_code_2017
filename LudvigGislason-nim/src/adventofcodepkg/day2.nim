import strutils
from os import getAppDir
from utils import getInputForProblem, charToInt, addMod
from sequtils import foldl, mapIt

type
  MinMax[T] = tuple
    min: T
    max: T

proc updateMinMax[T](a: MinMax, b: T): MinMax =
  if b < a.min:
    (min: b, max: a.max)
  elif b > a.max:
    (min: a.min, max: b)
  else:
    a


proc distance(x: MinMax): int =
  x.max - x.min


proc problem3*: int =
  let inputRows = getInputForProblem(2)
  var sum = 0
  for row in inputRows:
    let xs = mapIt(row.split(), parseInt(it))
    if len(xs) == 0:
      continue
    let init = (min: xs[0], max: xs[0])
    let rest = xs[1 .. len(xs)-1]
    let res = foldl(rest, updateMinMax(a, b), init)
    sum += distance(res)
  sum

proc problem4*: int =
  let inputRows = getInputForProblem(2)
  var sum = 0
  for row in inputRows:
    let xs = mapIt(row.split(), parseInt(it))
    if len(xs) == 0:
      continue
    var
      i = 0
      found = false
    while (not found and i < len(xs)):
      var j = i + 1
      while (j < len(xs)):
        let a = xs[i]
        let b = xs[j]
        let minMax = if a < b: (min: a, max: b) else: (min: b, max: a)
        let modRes = minMax.max mod minMax.min
        if modRes == 0:
          sum += int(minMax.max / minMax.min)
          found = true
          break
        inc j
      inc i
  sum