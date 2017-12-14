#use "./lib.ml";;

let example = [
  "0 <-> 2";
  "1 <-> 1";
  "2 <-> 0, 3, 4";
  "3 <-> 2, 4";
  "4 <-> 2, 3, 6";
  "5 <-> 6";
  "6 <-> 4, 5";
];;

module IntType = struct
  type t = int
  let compare = Pervasives.compare
end

module IntMap = Map.Make(IntType);;
module IntSet = Set.Make(IntType);;

let parse =
  Str.split (Str.regexp "\\( <-> \\)\\|\\(, \\)")
  >> List.map int_of_string
  >> (fun cons -> List.hd cons, List.tl cons)
;;

let rec as_map map = function
  | [] -> map
  | (id, connections) :: tail ->
    tail |> as_map (IntMap.add id connections map)
;;

let group_with id map =
  let rec search ids id =
    if IntSet.mem id ids then ids
    else
      IntMap.find id map |> List.fold_left search (IntSet.add id ids)
  in search IntSet.empty id
;;

let part1 =
  List.map parse
  >> as_map IntMap.empty
  >> group_with 0
  >> IntSet.cardinal
;;

assert (example |> part1 = 6);;

let groups_of map =
  let rec search ids_checked groups = function
    | [] -> groups
    | (id,_) :: ids when IntSet.mem id ids_checked -> search ids_checked groups ids
    | (id,_) :: ids -> search (group_with id map |> IntSet.union ids_checked) (groups + 1) ids
  in search IntSet.empty 0 (IntMap.bindings map)
;;

let part2 =
  List.map parse
  >> as_map IntMap.empty
  >> groups_of
;;

assert (example |> part2 = 2);;

File.open_in "day12.input" (fun ch ->
  let input = Stream.of_lines ch |> Stream.to_list in
  input |> part1 |> Printf.printf "part1: %d\n%!";
  input |> part2 |> Printf.printf "part2: %d\n%!";
);;
