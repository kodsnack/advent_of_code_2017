#use "./lib.ml";;

let example = [
  "0: 3";
  "1: 2";
  "4: 4";
  "6: 4";
];;

let parse line = Scanf.sscanf line "%d: %d" (fun depth range -> depth,range);;

(* may be seen as a triangle function *)
let scanner_at_top range t =
  let range = range - 1 in range - abs (t mod (range * 2) - range) = 0
;;

let rec severity sum t = function
  | [] -> sum
  | (depth, range) :: layers ->
    if scanner_at_top range depth
    then severity (sum + range * depth) depth layers
    else severity sum depth layers
;;

let part1 = List.map parse >> severity 0 0;;

assert (example |> part1 = 24);;

let rec find_safe delay layers =
  if layers |> List.exists (fun (depth, range) -> scanner_at_top range (delay + depth))
  then find_safe (delay + 1) layers
  else delay
;;

let part2 = List.map parse >> find_safe 0;;

assert (example |> part2 = 10);;

File.open_in "day13.input" (fun ch ->
  let input = Stream.of_lines ch |> Stream.to_list in
  input |> part1 |> Printf.printf "part1: %d\n%!";
  input |> part2 |> Printf.printf "part2: %d\n%!";
);;
