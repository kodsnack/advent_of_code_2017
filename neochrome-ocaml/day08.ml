#use "./lib.ml";;

module StringMap = Map.Make(String);;

let execute instruction (highest,registers) =
  Scanf.sscanf instruction "%s %s %d if %s %[<>!=] %d" (fun register opcode value test_register test_opcode test_value ->
    let value_of reg = try StringMap.find reg registers with _ -> 0 in
    if match test_opcode with
      | "==" -> (value_of test_register) = test_value
      | "!=" -> (value_of test_register) <> test_value
      | ">" -> (value_of test_register) > test_value
      | "<" -> (value_of test_register) < test_value
      | ">=" -> (value_of test_register) >= test_value
      | "<=" -> (value_of test_register) <= test_value
      | _ -> failwith ("unsupported condition: " ^ test_opcode)
    then
      let value' = match opcode with
        | "inc" -> (value_of register) + value
        | "dec" -> (value_of register) - value
        | _ -> failwith ("unsupported operation: " ^ opcode)
      in
      (max value' highest,registers |> StringMap.add register value')
    else
      (highest,registers)
  )
;;

let solve (part2, part1) =
  part1 |> StringMap.bindings |> List.map snd |> List.max, part2
;;

let (part1, part2) = [
  "b inc 5 if a > 1";
  "a inc 1 if b < 5";
  "c dec -10 if a >= 1";
  "c inc -20 if c == 10";
] |> List.fold_left (fun a b -> execute b a) (0,StringMap.empty) |> solve;;
assert (part1 = 1);;
assert (part2 = 10);;

File.open_in "day08.input" (fun ch ->
  let (part1, part2) = Stream.of_lines ch |> Stream.fold execute (0,StringMap.empty) |> solve in
  Printf.printf "part1: %d\n%!" part1;
  Printf.printf "part2: %d\n%!" part2;
);;
