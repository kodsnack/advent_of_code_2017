#use "./lib.ml";;
module StringMap = Map.Make(String);;

let initial = [
  ".#.";
  "..#";
  "###";
] |> String.concat "";;

let size = float_of_int >> sqrt >> int_of_float;;
let size_of = String.length >> size;;

let split g =
  let s = size_of g in
  let d = if s mod 2 = 0 then 2 else 3 in
  let n = s / d in
  Array.init n (fun row ->
    Array.init n (fun col ->
      String.init (d * d) (fun i ->
        let x = i mod d in
        let y = i / d * s in
        let gx = col * d in
        let gy = row * s * d in
        g.[x + gx + y + gy]
      )
    )
  )
;;

let join (gs : string array array) =
  let d = size_of gs.(0).(0) in
  let n = Array.length gs in
  let s = n * d in
  String.init (s * s) (fun i ->
    let row = i / s / d in
    let col = (i / d) mod n in
    let x = i mod d in
    let y = i / s mod d * d in
    gs.(row).(col).[x + y]
  )
;;

assert ("0123" |> split |> join = "0123");;
assert ("012345678" |> split |> join = "012345678");;

let flip2 = [|
  2;3;
  0;1;
|];;
let rotate2 = [|
  2;0;
  3;1;
|];;
let flip3 = [|
  2;1;0;
  5;4;3;
  8;7;6;
|];;
let rotate3 = [|
  6;3;0;
  7;4;1;
  8;5;2;
|];;
let apply m grid = String.mapi (fun i _ -> grid.[m.(i)]) grid;;

assert ("0123" |> apply flip2 |> apply flip2 = "0123");;
assert ("0123" |> apply rotate2 |> apply rotate2 |> apply rotate2 |> apply rotate2 = "0123");;

let variations_of grid =
  let how = if (size_of grid) mod 2 = 0 then rotate2,flip2 else rotate3,flip3 in
  Array.init 4 (fun _ -> how)
  |> Array.fold_left (fun (acc, grid) (r,f) ->
    let grid' = apply r grid in
    apply f grid' :: grid :: acc, grid'
  ) ([], grid)
  |> fst
;;

let transform rules grid =
  variations_of grid
  |> List.find (fun g -> StringMap.mem g rules)
  |> (fun g -> StringMap.find g rules)
;;

let enhance transform times =
  let rec iter n grid =
    if n = 0 then grid
    else grid |> split |> Array.map (Array.map transform) |> join |> iter (n - 1)
  in iter times initial
;;

let parse lines =
  let split line =
    try Scanf.sscanf line "%[.#]/%[.#] => %[.#]/%[.#]/%[.#]" (fun s1 s2 t1 t2 t3 -> s1^s2,t1^t2^t3)
    with _ -> Scanf.sscanf line "%[.#]/%[.#]/%[.#] => %[.#]/%[.#]/%[.#]/%[.#]" (fun s1 s2 s3 t1 t2 t3 t4 -> s1^s2^s3,t1^t2^t3^t4)
  in
  lines
  |> List.map split
  |> List.fold_left (fun map (source,target) -> StringMap.add source target map) StringMap.empty
;;

let example_rules = [
  "../.# => ##./#../...";
  ".#./..#/### => #..#/..../..../#..#";
] |> parse;;

let example_result = [
  "##.##.";
  "#..#..";
  "......";
  "##.##.";
  "#..#..";
  "......";
] |> String.concat "";;

assert (enhance (transform example_rules) 2 = example_result);;

let count_on = String.fold (fun on ch -> if ch = '#' then on + 1 else on) 0;;

File.open_in "./day21.input" (fun ch ->
  let rules = Stream.of_lines ch |> Stream.to_list |> parse in
  enhance (transform rules) 5 |> count_on |> Printf.printf "part1: %d\n%!";
  enhance (transform rules) 18 |> count_on |> Printf.printf "part2: %d\n%!";
);;
