#use "./lib.ml";;

let example = [
  "0: 3";
  "1: 2";
  "4: 4";
  "6: 4";
];;

let parse line = Scanf.sscanf line "%d: %d" (fun depth range -> depth,range);;

let scan_pos range t = (* may be seen as triangle function *)
  let range = range - 1 in
  range - abs (t mod (range * 2) - range)
;;

let rec travel delay caught t = function
  | [] -> caught
  | (depth, range) as layer :: layers ->
    let caught' = if scan_pos range (delay + depth) = 0
      then (layer :: caught)
      else caught
    in travel delay caught' (max depth t) layers
;;

let part1 = List.(map parse >> travel 0 [] 0 >> map (fun (d,r) -> d * r) >> fold_left ( + ) 0);;

assert (example |> part1 = 24);;

let rec find_safe delay layers =
  if travel delay [] 0 layers = [] then delay
  else find_safe (delay + 1) layers
;;

let part2 = List.map parse >> find_safe 0;;

assert (example |> part2 = 10);;

File.open_in "day13.input" (fun ch ->
  let input = Stream.of_lines ch |> Stream.to_list in
  input |> part1 |> Printf.printf "part1: %d\n%!";
  input |> part2 |> Printf.printf "part2: %d\n%!";
);;
