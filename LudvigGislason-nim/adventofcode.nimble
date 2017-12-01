# Package

version       = "0.1"
author        = "Ludvig Gislason"
description   = "Advent of code solutions"
license       = "MIT"

srcDir        = "src"
bin           = @["adventofcode"]

# Dependencies

requires "nim >= 0.17.2"

task r, "Build and run project":
  exec "nim c -r --out:bin/adventofcode src/adventofcode"