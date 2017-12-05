#use "./lib.ml";;

let example = [|0;3;0;1;-3|];;

let execute rewrite instructions =
  let local_instructions =
    Array.init (Array.length instructions) (Array.get instructions)
  in
  let outside pc =
    pc < 0 || pc >= Array.length local_instructions
  in
  let rec jump steps pc =
    if outside pc then steps
    else
      let offset = local_instructions.(pc) in
      local_instructions.(pc) <- rewrite offset;
      jump (steps + 1) (pc + offset)
  in jump 0 0
;;

let part1 = execute (fun offset -> offset + 1);;

assert (example |> part1 = 5);;

let part2 = execute (fun offset -> offset + (if offset >= 3 then -1 else 1));;

assert (example |> part2 = 10);;

File.open_in "day05.input" (fun ch ->
  let input = Stream.of_lines ch |> Stream.map int_of_string |> Stream.to_array in
  input |> part1 |> Printf.printf "part1: %d\n%!";
  input |> part2 |> Printf.printf "part2: %d\n%!";
);;
