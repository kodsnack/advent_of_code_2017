#use "./lib.ml";;

let example = [|
  "     |          ";
  "     |  +--+    ";
  "     A  |  C    ";
  " F---|----E|--+ ";
  "     |  |  |  D ";
  "     +B-+  +--+ ";
  "                ";
|];;

let find_start diagram = String.index diagram.(0) '|', 0;;

type direction = Up | Down | Left | Right;;
let move (x,y) = function
  | Up -> x, y - 1
  | Down -> x, y + 1
  | Left -> x - 1, y
  | Right -> x + 1, y
;;
let turn_left = function Up -> Left | Left -> Down | Down -> Right | Right -> Up;;
let turn_right = function Up -> Right | Right -> Down | Down -> Left | Left -> Up;;

let rec trace diagram steps letters d pos =
  let look (x,y) = diagram.(y).[x] in
  let trace' = trace diagram (steps + 1) in
  match look pos with
  | ' ' -> letters |> List.rev |> String.of_list, steps
  | '|' | '-' -> move pos d |> trace' letters d
  | '+' ->
    let right = turn_right d in
    let left = turn_left d in
    if move pos right |> look = ' '
    then move pos left |> trace' letters left
    else move pos right |> trace' letters right
  | l -> move pos d |> trace' (l :: letters) d
;;

let solve diagram = diagram |> find_start |> trace diagram 0 [] Down;;

let path,steps = solve example;;
assert (path = "ABCDEF");;
assert (steps = 38);;

File.open_in "day19.input" (fun ch ->
  let path,steps = Stream.of_lines ch |> Stream.to_array |> solve in
  Printf.printf "part1: %s\n" path;
  Printf.printf "part2: %d\n" steps;
);;
