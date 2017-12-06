#use "./lib.ml";;
(*
6666665
6444435
6422135
642.135
6423335
6455555
6...
*)
let input = 277678;;

let unwind found =
  let directions = [|1,0;0,1;-1,0;0,-1|] in
  let rec walk i (x,y) dir steps_until_turn segment =
    match found i (x,y) with
    | Some ret -> ret
    | None ->
      let (dx,dy) = directions.(dir) in
      let walk = walk (i + 1) (x+dx,y+dy) in
      let turn = walk ((dir + 1) mod 4) in
      begin match segment with
      | `BeforeTurn 1          -> turn steps_until_turn (`AfterTurn steps_until_turn)
      | `BeforeTurn steps_left -> walk dir steps_until_turn (`BeforeTurn (steps_left - 1))
      | `AfterTurn 1           -> turn (steps_until_turn + 1) (`BeforeTurn (steps_until_turn + 1))
      | `AfterTurn steps_left  -> walk dir steps_until_turn (`AfterTurn (steps_left - 1))
      end
  in walk 1 (0,0) 0 1 (`BeforeTurn 1)
;;
let locate index = unwind (fun i loc -> if i = index then Some loc else None);;
let distance (x,y) = abs x + abs y;;

let part1 = locate >> distance;;

assert (1 |> part1 = 0);;
assert (12 |> part1 = 3);;
assert (23 |> part1 = 2);;
assert (1024 |> part1 = 31);;

input |> part1 |> Printf.printf "part1: %d\n%!";;

let part2 cutoff =
  let squares = Hashtbl.create 300_000 in
  let lookup (x,y) (dx,dy) = try Hashtbl.find squares (x+dx,y+dy) with _ -> 0 in
  let adjecents_of loc =
    [
      -1, 1; 0, 1; 1, 1;
      -1, 0      ; 1, 0;
      -1,-1; 0,-1; 1,-1;
    ] |> List.map (lookup loc) |> List.fold_left ( + ) 0
  in
  unwind (fun i loc ->
    let to_write = if i = 1 then 1 else adjecents_of loc in
    if to_write > cutoff then Some to_write
    else (Hashtbl.add squares loc to_write; None)
  )
;;

assert (4 |> part2 = 5);;
assert (5 |> part2 = 10);;
assert (23 |> part2 = 25);;

input |> part2 |> Printf.printf "part2: %d\n%!";;
