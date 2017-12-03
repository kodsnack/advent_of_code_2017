import tables
import options
from sequtils import foldl

type Point =
  tuple[x: int, y: int]

type Grid =
  Table[Point, int]

type MoveInstruction =
  proc (position: Point): Point

proc move(position: Point, movement: Point): Point =
  (x: position.x + movement.x, y: position.y + movement.y)
proc moveEast(position: Point): Point =
  move(position, (x: 1, y: 0))
proc moveWest(position: Point): Point =
  move(position, (x: -1, y: 0))
proc moveNorth(position: Point): Point =
  move(position, (x: 0, y: -1))
proc moveSouth(position: Point): Point =
  move(position, (x: 0, y: 1))

proc findNeighbours(grid: Grid, position: Point): seq[Point] =
  let north = moveNorth(position)
  let northWest = moveWest(north)
  let northEast = moveEast(north)
  let west = moveWest(position)
  let east = moveEast(position)
  let south = moveSouth(position)
  let southWest = moveWest(south)
  let southEast = moveEast(south)
  @[northWest, north, northEast, west, east, southWest, south, southEast]

proc sumNeighbours(grid: Grid, position: Point): int =
  foldl(findNeighbours(grid, position), a + getOrDefault(grid, b), 0)

proc findFirstNeighbourSumGreaterThan(treshold: int): Option[int] =
  var
    position = (0, 0)
    grid = initTable[Point, int]()
    i = 1
    sz = 1

  proc step(walk: MoveInstruction): bool =
    inc i
    position = walk(position)
    grid[position] = sumNeighbours(grid, position)
    grid[position] > treshold

  grid[position] = 1
  while i < treshold:
    if step(moveEast):
      return some(grid[position])
    for j in 1..sz:
      if step(moveNorth):
        return some(grid[position])
    for _ in 1..sz+1:
      if step(moveWest):
        return some(grid[position])
    for _ in 1..sz+1:
      if step(moveSouth):
        return some(grid[position])
    for _ in 1..sz+1:
      if step(moveEast):
        return some(grid[position])
    sz += 2

proc findPosition(needle: int): Option[Point] =
  var
    i = 1
    sz = 1
    position = (0, 0)

  proc step(walk: MoveInstruction): bool =
    inc i
    position = walk(position)
    i == needle

  while i < needle:
    if step(moveEast):
      return some(position)
    for j in 1..sz:
      if step(moveNorth):
        return some(position)
    for _ in 1..sz+1:
      if step(moveWest):
        return some(position)
    for _ in 1..sz+1:
      if step(moveSouth):
        return some(position)
    for _ in 1..sz+1:
      if step(moveEast):
        return some(position)
    sz += 2


proc problem5*(needle: int): int =
  let (x, y) = findPosition(needle).get()
  abs(x) + abs(y)

proc problem6*(treshold: int): int =
  findFirstNeighbourSumGreaterThan(treshold).get()
