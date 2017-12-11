#use "./lib.ml";;

let rec gc count = function
  | [] -> count, []
  | '!' :: _ :: chars -> chars |> gc count
  | '>' :: chars -> count, chars
  | _ :: chars -> chars |> gc (count + 1)
;;

[
  "<>", 0;
  "<random characters>", 17;
  "<<<<>", 3;
  "<{!>}>", 2;
  "<!!>", 0;
  "<!!!>>", 0;
  "<{o\"i!a,<{i<a>", 10;
] |> List.iter (fun (chars,expected) ->
  let (actual,cleaned) =
    chars
    |> String.to_list
    |> gc 0
    |> (fun (actual,cleaned) -> actual - 1, cleaned |> String.of_list)
  in
  if cleaned <> "" then
    failwith (Printf.sprintf "not properly cleaned: %s -> %s" chars cleaned)
  else if actual <> expected then
    failwith (Printf.sprintf "%s: expected %d, got %d\n%!" chars expected actual)
  else ()
);;

let rec analyze sum depth garbage = function
  | [] -> sum, garbage
  | '{' :: chars -> chars |> analyze sum (depth + 1) garbage
  | '<' :: chars -> let (garbage',chars') = chars |> gc garbage in chars' |> analyze sum depth garbage'
  | '}' :: chars -> chars |> analyze (sum + depth) (depth - 1) garbage
  | _ :: chars -> chars |> analyze sum depth garbage
;;

[
  "{}", 1;
  "{{{}}}", 6;
  "{{},{}}", 5;
  "{{{},{},{{}}}}", 16;
  "{<a>,<a>,<a>,<a>}", 1;
  "{{<ab>},{<ab>},{<ab>},{<ab>}}", 9;
  "{{<!!>},{<!!>},{<!!>},{<!!>}}", 9;
  "{{<a!>},{<a!>},{<a!>},{<ab>}}", 3;
] |> List.iter (fun (chars,expected) ->
  let (actual,_) = chars |> String.to_list |> analyze 0 0 0 in
  if actual <> expected
  then failwith (Printf.sprintf "%s: expected %d, got %d\n%!" chars expected actual)
  else ()
);;

File.open_in "day09.input" (fun ch ->
  let input = Stream.of_lines ch |> Stream.to_list |> List.hd in
  let (score,garbage) = input |> String.to_list |> analyze 0 0 0 in
  score |> Printf.printf "part1: %d\n%!";
  garbage |> Printf.printf "part2: %d\n%!";
);;
