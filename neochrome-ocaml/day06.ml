let redistribute banks =
  let (max_bank, max_blocks) =
    banks
    |> List.mapi (fun i b -> i,b)
    |> List.fold_left (fun (max_bank,max_blocks) (bank,blocks) ->
      if blocks > max_blocks then (bank,blocks)
      else (max_bank,max_blocks)
    ) (0,0)
  in
  let banks = Array.of_list banks in
  let length = Array.length banks in
  banks.(max_bank) <- 0;
  let rec spread = function
    | 0, _ -> Array.to_list banks
    | blocks, bank ->
      banks.(bank) <- banks.(bank) + 1;
      spread (blocks - 1, (bank + 1) mod length)
  in spread (max_blocks, (max_bank + 1) mod length)
;;

exception Expected of int list * int list;;
let must_be what got =
  if got = what then got
  else raise (Expected (what, got))
;;

[0;2;7;0]
|> redistribute |> must_be [2;4;1;2]
|> redistribute |> must_be [3;1;2;3]
|> redistribute |> must_be [0;2;3;4]
|> redistribute |> must_be [1;3;4;1]
|> redistribute |> must_be [2;4;1;2]
;;

let reallocate banks =
  let seen = Hashtbl.create 10_000 in
  let rec cycle n banks =
    if Hashtbl.mem seen banks then n, n - Hashtbl.find seen banks
    else begin
      Hashtbl.add seen banks n;
      banks |> redistribute |> cycle (n + 1)
    end
  in banks |> cycle 0
;;

let () =
  let part1,part2 = [0;2;7;0] |> reallocate in
  assert (part1 = 5);
  assert (part2 = 4);
;;

let () =
  let part1,part2 =
    [5;1;10;0;1;7;13;14;3;12;8;10;7;12;0;6]
    |> reallocate
  in
  Printf.printf "part1: %d\n%!" part1;
  Printf.printf "part2: %d\n%!" part2;
;;
