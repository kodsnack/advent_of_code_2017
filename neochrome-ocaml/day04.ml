#use "./lib.ml";;

let has_duplicates =
  let rec search = function
    | [] | _::[] -> false
    | a::b::_ when a = b -> true
    | _::words -> search words
  in
  List.fast_sort (Pervasives.compare) >> search
;;

let part1 =
  List.reject has_duplicates
  >> List.length
;;
 
let example1 = [
  ["aa";"bb";"cc";"dd";"ee"];  (* valid *)
  ["aa";"bb";"cc";"dd";"aa"];  (* invalid *)
  ["aa";"bb";"cc";"dd";"aaa"]; (* valid *)
];;

assert (example1 |> part1 = 2);;

let is_anagram a b =
  let sort =
    String.to_list
    >> List.fast_sort (Pervasives.compare)
    >> String.from_list
  in
  (sort a) = (sort b)
;;

assert (is_anagram "abc123" "123bac" = true);;
assert (is_anagram "abc123" "abc234" = false);;
assert (is_anagram "abc123" "12bac" = false);;
assert (is_anagram "" "" = true);;

let has_anagrams words =
  List.exists (fun a ->
    List.exists (fun b ->
      if a = b then false
      else is_anagram a b
    ) words
  ) words
;;

let part2 =
  List.reject has_duplicates
  >> List.reject has_anagrams
  >> List.length
;;

let example2 = [
  ["abcde";"fghij"];                    (* valid *)
  ["abcde";"xyz";"ecdab"];              (* invalid *)
  ["a";"ab";"abc";"abd";"abf";"abj"];   (* valid *)
  ["iiii";"oiii";"ooii";"oooi";"oooo"]; (* valid *)
  ["oiii";"ioii";"iioi";"iiio"];        (* invalid *)
];;

assert (example2 |> part2 = 3);;

File.open_in "day04.input" (fun ch ->
  let as_words = Str.split (Str.regexp " ") in
  let input = Stream.of_lines ch |> Stream.map as_words |> Stream.to_list in
  input |> part1 |> Printf.printf "part1: %d\n%!";
  input |> part2 |> Printf.printf "part2: %d\n%!";
);;
