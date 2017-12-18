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

let rec bits_set_in = function
  | 0 -> 0
  | n -> 1 + (bits_set_in (n land (n - 1)))
;;

let disk_hashes input =
  Seq.range 0 127 |> Seq.to_list
  |> List.map (Printf.sprintf "%s-%d" input)
  |> List.map (Knot.hash)
;;

let example = "flqrgnkx" |> disk_hashes;;
let input = "jzgqcdpd" |> disk_hashes;;

let count_all_set_bits = List.map bits_set_in >> List.fold_left ( + ) 0;;

let part1 = List.map count_all_set_bits >> List.fold_left ( + ) 0;;

assert (example |> part1 = 8108);;
input |> part1 |> Printf.printf "part1: %d\n%!";;

let test = [|
  [|0;0;0;0;0;0|];
  [|0;1;0;0;0;0|];
  [|0;1;1;0;1;0|];
  [|0;0;0;0;1;0|];
  [|0;1;0;1;1;0|];
  [|0;0;0;0;0;0|];
|];;

let count_regions grid =
  let size = Array.length grid - 1 in
  let rec iter x y count =
    if y = size then count
    else if x = size then iter 0 (y + 1) count
    else if grid.(1 + y).(1 + x) <> 1 then iter (x + 1) y count
    else begin
      fill (1 + x) (1 + y);
      iter (x + 1) y (count + 1)
    end
  and fill x y =
    if grid.(y).(x) <> 1 then ()
    else begin
      grid.(y).(x) <- 2;
      [0,-1;1,0;0,1;-1,0] |> List.iter (fun (dx,dy) -> fill (x + dx) (y + dy));
    end
  in iter 0 0 0
;;

assert (test |> count_regions = 3);;

let is_set i n = (1 lsl i) land n <> 0;;

let as_grid width hashes =
  (Array.make (width + 2) 0) ::
  (List.map (fun hash ->
    let bits = Array.make (width + 2) 0 in
    hash |> List.iteri (fun i n ->
      for j = 0 to 7 do
        if is_set j n then bits.((i * 8) + 8 - j) <- 1
      done
    );bits
  ) hashes) @ [Array.make (width + 2) 0]
  |> Array.of_list
;;

let part2 = as_grid 128 >> count_regions;;

assert (example |> part2 = 1242);;
input |> part2 |> Printf.printf "part2: %d\n%!";;
