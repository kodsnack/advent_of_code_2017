#use "./lib.ml";;
type direction = Up | Left | Down | Right;;
type position = { x : int; y : int };;
type carrier = { position : position; direction : direction };;
let turn_right ({direction} as carrier) =
  match direction with
  | Up -> { carrier with direction = Right }
  | Right -> { carrier with direction = Down }
  | Down -> { carrier with direction = Left }
  | Left -> { carrier with direction = Up }
;;
let turn_left ({direction} as carrier) =
  match direction with
  | Up -> { carrier with direction = Left }
  | Left -> { carrier with direction = Down }
  | Down -> { carrier with direction = Right }
  | Right -> { carrier with direction = Up }
;;

let move ({position; direction;} as carrier) =
  let {x;y} = position in
  let position = match direction with
    | Up -> { x; y = y + 1 }
    | Right -> { x = x + 1; y }
    | Down -> { x; y = y - 1 }
    | Left -> { x = x - 1; y }
  in { carrier with position }
;;
let start = { position = { x = 0; y = 0 }; direction = Up };;

type status = Clean | Weakened | Infected | Flagged;;
let empty_map () = Hashtbl.create 1_000_000;;
let set_status (position : position) (status : status) map =
  begin match status with
  | Clean -> Hashtbl.remove map position
  | _ -> Hashtbl.replace map position status
  end; map
;;
let get_status (position : position) map =
  try Hashtbl.find map position
  with Not_found -> Clean
;;

let parse lines =
  let w = List.hd lines |> String.length in
  let hw = (w - 1) / 2 in
  let parse_cell x y ch map = if ch = '#' then map |> set_status {x;y} Infected else map in
  lines |> List.fold_left (fun (map,y) line ->
    line |> String.to_list |> List.fold_left (fun (map,x) ch ->
      parse_cell x y ch map, x + 1
    ) (map, -hw) |> fst, y - 1
  ) (empty_map (), hw) |> fst
;;

let example = [
  "..#";
  "#..";
  "...";
] |> parse;;

let input = [
  "#.#...###.#.##.#....##.##";
  "..####.#.######....#....#";
  "###..###.#.###.##.##..#.#";
  "...##.....##.###.##.###..";
  "....#...##.##..#....###..";
  "##.#..###.#.###......####";
  "#.#.###...###..#.#.#.#.#.";
  "###...##..##..#..##......";
  "##.#.####.#..###....#.###";
  ".....#..###....######..##";
  ".##.#.###....#..#####..#.";
  "########...##.##....##..#";
  ".#.###.##.#..#..#.#..##..";
  ".#.##.##....##....##.#.#.";
  "..#.#.##.#..##..##.#..#.#";
  ".####..#..#.###..#..#..#.";
  "#.#.##......##..#.....###";
  "...####...#.#.##.....####";
  "#..##..##..#.####.#.#..#.";
  "#...###.##..###..#..#....";
  "#..#....##.##.....###..##";
  "#..##...#...##...####..#.";
  "#.###..#.#####.#..#..###.";
  "###.#...#.##..#..#...##.#";
  ".#...#..#.#.#.##.####....";
] |> parse;;

let rec spread turn evolve map ({position} as carrier) infected times =
  if times = 0 then infected
  else
    let status = map |> get_status position in
    let carrier' = carrier |> turn status |> move in
    let status' = evolve status in
    let map' = map |> set_status position status' in
    let infected' = if status' = Infected then infected + 1 else infected in
    spread turn evolve map' carrier' infected' (times - 1)
;;

let turn_part1 status carrier =
  match status with
  | Infected -> carrier |> turn_right
  | _ -> carrier |> turn_left
;;

let evolve_part1 = function
  | Clean -> Infected
  | _ -> Clean
;;

let part1 map = spread turn_part1 evolve_part1 map start 0 10_000;;

let turn_part2 status carrier =
  match status with
  | Clean -> carrier |> turn_left
  | Weakened -> carrier
  | Infected -> carrier |> turn_right
  | Flagged -> carrier |> turn_right |> turn_right
;;

let evolve_part2 = function
  | Clean -> Weakened
  | Weakened -> Infected
  | Infected -> Flagged
  | Flagged -> Clean
;;

let part2 map = spread turn_part2 evolve_part2 map start 0 10_000_000;;

(* assert (example |> part1 = 5587);; *)
(* assert (example |> part2 = 2_511_944);; *)

input |> part1 |> Printf.printf "part1: %d\n%!";;
input |> part2 |> Printf.printf "part2: %d\n%!";;
