#use "./lib.ml";;

let spin n programs =
  let l = String.length programs in
  String.init l (fun i -> if i < n then programs.[l - n + i] else programs.[i - n])
;;
assert ("abcd" |> spin 2 = "cdab");;
assert ("abcde" |> spin 3 = "cdeab");;

let exchange a b programs =
  String.init (String.length programs) (
    function
    | i when i = a -> programs.[b]
    | i when i = b -> programs.[a]
    | i -> programs.[i]
  )
;;
assert ("abcd" |> exchange 1 3 = "adcb");;
assert ("abcd" |> exchange 3 1 = "adcb");;
assert ("abcd" |> exchange 1 1 = "abcd");;

let partner a b programs =
  let rec find p i = if programs.[i] = p then i else find p (i + 1) in
  exchange (find a 0) (find b 0) programs
;;
assert ("abcd" |> partner 'c' 'a' = "cbad");;

let move rule f code = try Some (Scanf.sscanf code rule f) with _ -> None;;
let rec choose code = function
  | [] -> failwith ("no matching move for: " ^ code)
  | rule :: rules ->
    begin match rule code with
    | None -> choose code rules
    | Some move -> move
    end
;;

let rec dance programs = function
  | [] -> programs
  | code :: codes ->
    let programs' =
      choose code [
        move "s%d" spin;
        move "x%d/%d" exchange;
        move "p%c/%c" partner;
      ] programs
    in dance programs' codes
;;

let parse = Str.split (Str.regexp ",");;

let part1 programs = parse >> dance programs;;
assert ("s1,x3/4,pe/b" |> part1 "abcde" = "baedc");;

let part2 programs sequence =
  let codes = parse sequence in
  let seen = Hashtbl.create 1000 in
  let rec find_repeated programs = function
    | 0 -> programs
    | n ->
      try step programs (n mod (Hashtbl.find seen programs - n))
      with Not_found -> Hashtbl.add seen programs n; find_repeated (dance programs codes) (n - 1)
  and step programs = function
    | 0 -> programs
    | n -> step (dance programs codes) (n - 1)
  in find_repeated programs 1_000_000_000
;;

File.open_in "day16.input" (fun ch ->
  let sequence = Stream.of_lines ch |> Stream.to_list |> List.hd in
  sequence |> part1 "abcdefghijklmnop" |> Printf.printf "part1: %s\n%!";
  sequence |> part2 "abcdefghijklmnop" |> Printf.printf "part2: %s\n%!";
);;
