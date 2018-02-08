#use "./lib.ml";;

let connect p (a,b) =
  if a = p then Some b
  else if b = p then Some a
  else None
;;

let rec build bridges = function
  | [] -> bridges
  | (port, bridge, prev, next) :: steps ->
    begin match next with
    | [] -> build (bridge :: bridges) steps
    | component :: next' ->
      let prev' = component :: prev in
      begin match connect port component with
      | None -> build bridges ((port, bridge, prev', next') :: steps)
      | Some port' -> build bridges (
          (port', component :: bridge, [], prev @ next') ::
          (port, bridge, prev', next') ::
          steps
        )
      end
    end
;;

let build_all components = build [] [0, [], [], components];;

let strength b = List.fold_right (fun (a,b) sum -> sum + a + b) b 0;;

let part1 = List.rev_map strength >> List.fast_sort compare >> List.rev >> List.hd;;

let part2 =
  List.rev_map (fun b -> List.length b, strength b)
  >> List.fast_sort (fun (l1,s1) (l2,s2) ->
    match compare l1 l2 with
    | 0 -> compare s1 s2
    | c -> c
  ) >> List.rev >> List.hd >> snd
;;

let example = [
  0,2;
  2,2;
  2,3;
  3,4;
  3,5;
  0,1;
  10,1;
  9,10;
] |> build_all;;

assert (example |> part1 = 31);;
assert (example |> part2 = 19);;

File.open_in "./day24.input" (fun ch ->
  let input = Stream.of_lines ch |> Stream.map (fun l -> Scanf.sscanf l "%d/%d" (fun a b -> a,b)) |> Stream.to_list |> build_all in
  input |> part1 |> Printf.printf "part1: %d\n";
  input |> part2 |> Printf.printf "part2: %d\n";
);;
