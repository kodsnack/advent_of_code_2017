#use "./lib.ml";;

let example = (65,8921)
let input = (703,516)

let next factor previous = (previous * factor) mod 2147483647;;
let nextA = next 16807;;
assert (nextA (fst example) = 1092455);;
let nextB = next 48271;;
assert (nextB (snd example) = 430625591);;

let compare16 (a,b) = (a land 0xffff) = (b land 0xffff);;
assert (compare16 (245556042, 1431495498));;

let part1 input =
  Seq.unfold (fun ((a,b) as pair) -> Some (pair, (nextA a, nextB b))) input
  |> Seq.skip 1
  |> Seq.take 40_000_000
  |> Seq.filter compare16
  |> Seq.map (fun _ -> 1)
  |> Seq.fold ( + ) 0
;;

let generator next filter input =
  Seq.unfold (fun prev -> Some (prev, next prev)) input
  |> Seq.skip 1
  |> Seq.filter filter
  |> Seq.take 5_000_000
;;

let is_multiple_of m n = n mod m = 0;;

let generatorA = generator nextA (is_multiple_of 4);;
assert (example |> fst |> generatorA |> Seq.take 5 |> Seq.to_list = [1352636452;1992081072;530830436;1980017072;740335192]);;
let generatorB = generator nextB (is_multiple_of 8);;
assert (example |> snd |> generatorB |> Seq.take 5 |> Seq.to_list = [1233683848;862516352;1159784568;1616057672;412269392]);;

let part2 (inputA,inputB) =
  Seq.map2 (fun a b -> a,b) (generatorA inputA) (generatorB inputB)
  |> Seq.filter compare16
  |> Seq.map (fun _ -> 1)
  |> Seq.fold ( + ) 0
;;

(* assert (example |> part1 = 588);; *)
(* assert (example |> part2 = 309);; *)

input |> part1 |> Printf.printf "part1: %d\n%!";;
input |> part2 |> Printf.printf "part2: %d\n%!";;
