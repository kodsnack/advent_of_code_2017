module Three
  ( solve
  ) where

shellOffset = shellOffset' 0
  where shellOffset' s offset
          | offset < shellSize = (s, offset)
          | otherwise = shellOffset' (s+1) (offset - shellSize)
          where shellSize = max (s*8) 1

shellStartPos s = ((-s)+1, s)

moveInShell s offset =
  let (endpos, 0) = foldl move (shellStartPos s, offset) dirs
  in endpos
  where dirs = [((1, 0), shellSide-1), ((0, -1), shellSide), ((-1, 0), shellSide), ((0, 1), shellSide+1)]
        shellSide = s*2
        move ((y,x), offset) ((dy, dx), l)
          | offset < l = ((y+dy*offset, x+dx*offset), 0)
          | otherwise = ((y+dy*l, x+dx*l), offset - l)

pos n =
  let (shell, offset) = shellOffset n
  in moveInShell shell offset

solve1 [s] =
  let (x,y) = pos i
  in abs x + abs y
  where i = read s - 1

solve2 s = solve1 s

solve s = (show $ solve1 s, show $ solve2 s)
