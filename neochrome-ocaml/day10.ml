#use "./lib.ml";;

let example = "3,4,1,5";;
let input = "189,1,111,246,254,2,0,120,215,93,255,50,84,15,94,62";;

module Array = struct
  include Array
  let sub_circ start length arr =
    let wrap i = i mod (Array.length arr) in
    let rec collect sub i = function
      | 0 -> sub
      | n -> collect (arr.(wrap i) :: sub) (wrap (i + 1)) (n - 1)
    in collect [] start length
  ;;
end

let rec transform bytes (skip,start) = function
  | [] -> (skip,start)
  | l :: lengths ->
    let wrap i = i mod (Array.length bytes) in
    bytes |> Array.sub_circ start l |> List.iteri (fun i n -> bytes.(wrap (start + i)) <- n);
    lengths |> transform bytes (skip + 1, wrap (start + l + skip))
;;

let part1 size str =
  let bytes = Array.init size (fun i -> i) in
  let as_lengths = (Str.split (Str.regexp ",")) >> List.map int_of_string in
  let check () = bytes.(0) * bytes.(1) in
  str |> as_lengths |> List.filter (( <> ) (Char.code ',')) |> transform bytes (0,0) |> ignore;
  check ()
;;

let densify sparse =
  let block n = Array.sub sparse (n * 16 + 1) 15 |> Array.fold_left ( lxor ) sparse.(n * 16) in
  let rec fold dense = function
    | 0 -> dense
    | n -> fold (block (n - 1) :: dense) (n - 1)
  in fold [] 16
;;

let as_hex = List.map (Printf.sprintf "%02x") >> List.fold_left ( ^ ) "";;

let part2 lengths =
  let bytes = Array.init 256 (fun i -> i) in
  let as_codes = List.append (lengths |> String.to_list |> List.map Char.code) [17;31;73;47;23] in
  let rec iter pos = function
    | 0 -> bytes
    | n -> iter (transform bytes pos as_codes) (n - 1)
  in iter (0,0) 64
  |> densify
  |> as_hex
;;

assert (example |> part1 5 = 12);;
input |> part1 256 |> Printf.printf "part1: %d\n%!";;

assert ("" |> part2         = "a2582a3a0e66e6e86e3812dcb672a272");;
assert ("AoC 2017" |> part2 = "33efeb34ea91902bb2f59c9920caa6cd");;
assert ("1,2,3" |> part2    = "3efbe78a8d82f29979031a4aa0b16a9d");;
assert ("1,2,4" |> part2    = "63960835bcdc130f0b66d7ff4f6a5a8e");;
input |> part2 |> Printf.printf "part2: %s\n%!";;
