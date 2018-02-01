#use "./lib.ml";;

module Registers = Map.Make(Char);;

let parse fmt map instruction = try Some (Scanf.sscanf instruction fmt map) with _ -> None;;

let rec choose instruction = function
  | [] -> failwith ("can't handle: " ^ instruction)
  | parser :: parsers ->
    begin match parser instruction with
    | None -> choose instruction parsers
    | Some op -> op
    end
;;

let get reg regs = try Registers.find reg regs with Not_found -> 0;;
let set reg value regs = Registers.add reg value regs;;
let update_imm dst value f regs = set dst (f (get dst regs) value) regs;;
let update_ref dst src f regs = set dst (f (get dst regs) (get src regs)) regs;;

type state = {
  pc : int;
  regs : int Registers.t;
  is_done : bool;
  multiplies : int;
};;
let initial_state = { pc = 0; regs = Registers.empty; is_done = false; multiplies = 0 };;

let instruction_set = [
  parse "set %c %d" (fun dst value -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = set dst value regs });
  parse "set %c %c" (fun dst src -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = set dst (get src regs) regs });
  parse "sub %c %d" (fun dst value -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_imm dst value ( - ) regs });
  parse "sub %c %c" (fun dst src -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_ref dst src ( - ) regs });
  parse "mul %c %d" (fun dst value -> fun ({ pc; regs; multiplies; } as state) -> { state with pc = pc + 1; regs = update_imm dst value ( * ) regs; multiplies = multiplies + 1 });
  parse "mul %c %c" (fun dst src -> fun ({ pc; regs; multiplies;} as state) -> { state with pc = pc + 1; regs = update_ref dst src ( * ) regs; multiplies = multiplies + 1 });
  parse "jnz %d %d" (fun value offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if value <> 0 then offset else 1) });
  parse "jnz %c %d" (fun src offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if get src regs <> 0 then offset else 1) });
  parse "jnz %d %c" (fun value offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if value <> 0 then get offset regs else 1) });
  parse "jnz %c %c" (fun src offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if get src regs <> 0 then get offset regs else 1) });
];;

let execute program ({ pc; is_done; } as state) =
  if is_done then state
  else if pc < 0 || pc >= Array.length program then { state with is_done = true }
  else state |> choose program.(pc) instruction_set
;;

let part1 program =
  let rec step ({ is_done } as state) =
    if is_done then state.multiplies
    else state |> execute program |> step
  in step initial_state
;;

assert ([|"mul a 1"|] |> part1 = 1);;

File.open_in "day23.input" (fun ch ->
  let program = Stream.of_lines ch |> Stream.to_array in
  program |> part1 |> Printf.printf "part1: %d\n%!";
);;

let is_prime n =
  if n <= 1 then false
  else if n <= 3 then true
  else if n mod 2 = 0 || n mod 3 = 0 then false
  else
    let rec search i =
      if i * i > n then true
      else if n mod i = 0 || n mod (i + 2) = 0 then false
      else search (i + 1)
    in search 5
;;

let part2 () =
  let b = 79 * 100 + 100_000 in
  let c = b + 17_000 in
  let rec count_non_primes h n =
    if n <= c then
      count_non_primes (if is_prime n then h else h + 1) (n + 17)
    else
      h
  in count_non_primes 0 b
;;

part2 () |> Printf.printf "part2: %d\n%!";;
