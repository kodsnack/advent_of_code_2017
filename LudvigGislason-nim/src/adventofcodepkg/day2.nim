import strutils
import options
from utils import getInputForProblem
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

template `distance`(x: MinMax): int =
  x.max - x.min

template `modMaxByMin`[T](a: T, b: T): T =
  if a > b:
    a mod b
  else:
    b mod a

template `divideMaxByMin`(a: int, b: int): int =
  if a > b:
    int(a / b)
  else:
    int(b / a)

proc findFirstEvenDivisiblePair[T](xs: seq[T]): Option[tuple[a: T, b: T]] =
  for i in 0..len(xs)-1:
    for j in i+1..len(xs)-1:
      if modMaxByMin(xs[i], xs[j]) == 0:
        return some((xs[i], xs[j]))

proc problem3*: int =
  let inputRows = getInputForProblem(2)
  var sum = 0
  for row in inputRows:
    let xs = mapIt(row.split(), parseInt(it))
    if (len(xs) > 0):
      let res = foldl(xs[1 .. len(xs)-1], updateMinMax(a, b), (min: xs[0], max: xs[0]))
      sum += distance(res)
  sum

proc problem4*: int =
  let inputRows = getInputForProblem(2)
  var sum = 0
  for row in inputRows:
    let xs = mapIt(row.split(), parseInt(it))
    if (len(xs) > 0):
      let res = findFirstEvenDivisiblePair(xs)
      if res.isSome():
        let (a, b) = res.get()
        sum += divideMaxByMin(a, b)
  sum
