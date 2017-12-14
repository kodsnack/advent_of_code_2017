#use "./lib.ml";;
(*
  \ n  /
nw +--+ ne
  / y  \
-+      +-
  \z  x/
sw +--+ se
  / s  \
*)

type coord = { x : int; y : int; z : int; };;
let origo = { x=0; y=0; z=0; };;
let distance a b =
  [a.x - b.x; a.y - b.y; a.z - b.z]
  |> List.map abs
  |> List.max
;;

let step {x;y;z} = function
  | "n" -> { x; y=y+1; z=z-1; }
  | "ne" -> { x=x+1; y; z=z-1; }
  | "se" -> { x=x+1; y=y-1; z; }
  | "s" -> { x; y=y-1; z=z+1; }
  | "sw" -> { x=x-1; y; z=z+1; }
  | "nw" -> { x=x-1; y=y+1; z; }
  | dir -> failwith ("invalid dir: " ^ dir)
;;

let part1 =
  let rec walk current = function
    | [] -> current
    | dir :: path -> path |> walk (step current dir)
  in walk origo >> distance origo
;;

assert (["ne";"ne";"ne"] |> part1 = 3);;
assert (["ne";"ne";"sw";"sw"] |> part1 = 0);;
assert (["ne";"ne";"s";"s"] |> part1 = 2);;
assert (["se";"sw";"se";"sw";"sw"] |> part1 = 3);;

let part2 =
  let distance_to_origo = distance origo in
  let rec walk furthest current = function
    | [] -> furthest
    | dir :: path ->
      let new_pos = step current dir in
      let furthest' =
        if distance_to_origo new_pos > distance_to_origo furthest
        then new_pos else furthest
      in path |> walk furthest' new_pos
  in walk origo origo >> distance_to_origo
;;

File.open_in "day11.input" (fun ch ->
  let path = Stream.of_lines ch |> Stream.to_list |> List.hd |> Str.split (Str.regexp ",") in
  path |> part1 |> Printf.printf "part1: %d\n%!";
  path |> part2 |> Printf.printf "part2: %d\n%!";
);;
