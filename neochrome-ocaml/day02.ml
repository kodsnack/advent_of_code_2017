#use "./lib.ml";;

let min_max nums =
  let hd = List.hd nums
  and tl = List.tl nums
  in
  List.fold_left (fun (lo,hi) num ->
    min num lo, max num hi
  ) (hd,hd) tl
;;
let diff (lo,hi) = abs (hi - lo);;
let sum = List.fold_left ( + ) 0;;

let part1 = List.map (min_max >> diff) >> sum;;

let example1 = [
  [5;1;9;5];
  [7;5;3];
  [2;4;6;8];
];;
assert (example1 |> part1 = 18);;

let even_div =
  let rec search_next a = function
    | [] -> None
    | b::_ when a mod b = 0 -> Some (a / b)
    | b::_ when b mod a = 0 -> Some (b / a)
    | _::nums -> search_next a nums
  and search = function
    | [] -> failwith "no suitable pairs found"
    | a::nums ->
      match search_next a nums with
      | None -> search nums
      | Some result -> result
  in search
;;

let example2 = [
  [5;9;2;8];
  [9;4;7;3];
  [3;8;6;5];
];;

let part2 = List.map even_div >> sum;;
assert (example2 |> part2 = 9);;

File.open_in "day02.input" (fun ch ->
  let parse =
    Str.split (Str.regexp "\t") >> List.map int_of_string
  in
  let input =
    Stream.of_lines ch
    |> Stream.map parse
    |> Stream.to_list
  in
  input |> part1 |> Printf.printf "part1: %d\n%!";
  input |> part2 |> Printf.printf "part2: %d\n%!";
);;
