#use "./lib.ml";;

type program = string * int * string list;;
let parse line : program =
  Scanf.sscanf line "%s (%d)%_[^a-z]%[\000-\255]" (fun name weight disc ->
    name, weight, Str.split (Str.regexp ", ?") disc
  )
;;

exception ExpectedLine of program * program;;
let must_be what got =
  if got = what then what
  else raise (ExpectedLine (what, got))
;;

"abc (123)" |> parse |> must_be ("abc", 123, []);;
"def (42) -> abc" |> parse |> must_be ("def", 42, ["abc"]);;
"def (42) -> abc, ghi" |> parse |> must_be ("def", 42, ["abc"; "ghi"]);;

let example = [
  "pbga (66)";
  "xhth (57)";
  "ebii (61)";
  "havc (66)";
  "ktlj (57)";
  "fwft (72) -> ktlj, cntj, xhth";
  "qoyq (66)";
  "padx (45) -> pbga, havc, qoyq";
  "tknk (41) -> ugml, padx, fwft";
  "jptl (61)";
  "ugml (68) -> gyxo, ebii, jptl";
  "gyxo (61)";
  "cntj (57)";
] |> List.map parse;;

module StringSet = Set.Make(String);;
let find_root (programs : program list )=
  let subs = programs |> List.fold_left (fun subs (_,_,disc) ->
    List.fold_right StringSet.add disc subs
  ) StringSet.empty in
  programs
  |> List.map (fun (name,_,_) -> name)
  |> List.find (fun name -> subs |> StringSet.mem name = false)
;;

assert (example |> find_root = "tknk");;

module StringMap = Map.Make(String);;

let find_imbalance (programs : program list) =
  let lookup = programs |> List.fold_left (fun map (name,weight,disc) ->
    map |> StringMap.add name (weight,disc)
  ) StringMap.empty in
  let rec search name =
    let (weight,disc) = lookup |> StringMap.find name in
    if disc = [] then `Searching (weight,weight)
    else
      let sub_weights = disc |> List.map search in
      try
        sub_weights |> List.find (function `Found _ -> true | _ -> false)
      with Not_found ->
        let sub_weights = sub_weights |> List.map (function `Searching weights -> weights | _ -> failwith "should not happen") in
        let min_sub = List.minf snd sub_weights and max_sub = List.maxf snd sub_weights in
        let diff = (snd max_sub) - (snd min_sub) in
        let full_weight = sub_weights |> List.map snd |> List.fold_left ( + ) weight in
        if diff = 0 then `Searching (weight,full_weight)
        else `Found ((fst max_sub) - diff)
  in
  match search (find_root programs) with
  | `Found weight -> weight
  | _ -> failwith "no imbalance detected!"
;;

assert (example |> find_imbalance = 60);;

File.open_in "day07.input" (fun ch ->
  let programs = Stream.of_lines ch |> Stream.map parse |> Stream.to_list in
  programs |> find_root |> Printf.printf "part1: %s\n%!";
  programs |> find_imbalance |> Printf.printf "part2: %d\n%!";
);;
