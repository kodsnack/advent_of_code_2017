#use "./lib.ml";;

module Knot = struct

  let sub_circ start length arr =
    let wrap i = i mod (Array.length arr) in
    let rec collect sub i = function
      | 0 -> sub
      | n -> collect (arr.(wrap i) :: sub) (wrap (i + 1)) (n - 1)
    in collect [] start length
  ;;

  let rec transform bytes (skip,start) = function
    | [] -> (skip,start)
    | l :: lengths ->
      let wrap i = i mod (Array.length bytes) in
      bytes |> sub_circ start l |> List.iteri (fun i n -> bytes.(wrap (start + i)) <- n);
      lengths |> transform bytes (skip + 1, wrap (start + l + skip))
  ;;

  let densify sparse =
    let block n = Array.sub sparse (n * 16 + 1) 15 |> Array.fold_left ( lxor ) sparse.(n * 16) in
    let rec fold dense = function
      | 0 -> dense
      | n -> fold (block (n - 1) :: dense) (n - 1)
    in fold [] 16
  ;;

  let as_hex = List.map (Printf.sprintf "%02x") >> List.fold_left ( ^ ) "";;

  let hash lengths =
    let bytes = Array.init 256 (fun i -> i) in
    let as_codes = List.append (lengths |> String.to_list |> List.map Char.code) [17;31;73;47;23] in
    let rec iter pos = function
      | 0 -> bytes
      | n -> iter (transform bytes pos as_codes) (n - 1)
    in iter (0,0) 64
    |> densify
  ;;

end

let rec bits_in = function
  | 0 -> 0
  | n -> 1 + (bits_in (n land (n - 1)))
;;

let example = "flqrgnkx";;

Seq.range 0 127
|> Seq.map (Printf.printf "%s-%d" example)
|> Seq.map (fun key -> key |> Knot.hash |> List.map bits_in |> List.fold_left ( + ) 0)
|> Seq.to_list
|> List.fold_left ( + ) 0
|> print_int
;;
