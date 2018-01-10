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
  freq : int;
  is_done : bool;
  sends : int;
  send : int -> unit;
  receive : unit -> int option;
  waiting : bool;
};;

let common = [
  parse "set %c %d" (fun dst value -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = set dst value regs });
  parse "set %c %c" (fun dst src -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = set dst (get src regs) regs });
  parse "add %c %d" (fun dst value -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_imm dst value ( + ) regs });
  parse "add %c %c" (fun dst src -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_ref dst src ( + ) regs });
  parse "mul %c %d" (fun dst value -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_imm dst value ( * ) regs });
  parse "mul %c %c" (fun dst src -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_ref dst src ( * ) regs });
  parse "mod %c %d" (fun dst value -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_imm dst value ( mod ) regs });
  parse "mod %c %c" (fun dst src -> fun ({ pc; regs; } as state) -> { state with pc = pc + 1; regs = update_ref dst src ( mod ) regs });
  parse "jgz %d %d" (fun value offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if value > 0 then offset else 1) });
  parse "jgz %c %d" (fun src offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if get src regs > 0 then offset else 1) });
  parse "jgz %d %c" (fun value offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if value > 0 then get offset regs else 1) });
  parse "jgz %c %c" (fun src offset -> fun ({ pc; regs; } as state) -> { state with pc = pc + (if get src regs > 0 then get offset regs else 1) });
];;

let execute instruction_set program ({ pc; is_done; } as state) =
  if is_done then state
  else if pc < 0 || pc >= Array.length program then { state with is_done = true }
  else state |> choose program.(pc) instruction_set
;;

let part1 program =
  let instruction_set = common @ [
    parse "snd %d" (fun value -> fun ({ pc; freq; } as state) -> { state with pc = pc + 1; freq = value });
    parse "snd %c" (fun src -> fun ({ pc; freq; regs; } as state) -> { state with pc = pc + 1; freq = get src regs });
    parse "rcv %c" (fun src -> fun ({ pc; regs; is_done; } as state ) -> if get src regs <> 0 then { state with is_done = true } else { state with pc = pc + 1 });
  ] in
  let rec step ({ is_done } as state) =
    if is_done then state.freq
    else state |> execute instruction_set program |> step
  in step
;;
let part1_init () = { pc = 0; freq = 0; regs = Registers.empty; is_done = false; sends = 0; send = (fun _ -> ()); receive = (fun () -> None); waiting = false; };;

let example1 = [|
  "set a 1";
  "add a 2";
  "mul a a";
  "mod a 5";
  "snd a";
  "set a 0";
  "rcv a";
  "jgz a -1";
  "set a 1";
  "jgz a -2";
|];;

assert (part1_init () |> part1 example1 = 4);;

let part2 program =
  let instruction_set = common @ [
    parse "snd %d" (fun value -> fun ({ pc; sends; send; } as state) -> send value; { state with pc = pc + 1; sends = sends + 1 });
    parse "snd %c" (fun src -> fun ({ pc; sends; regs; send; } as state) -> send (get src regs); { state with pc = pc + 1; sends = sends + 1 });
    parse "rcv %c" (fun dst -> fun ({ pc; regs; receive; } as state ) ->
      match receive () with
      | None -> { state with waiting = true }
      | Some value -> { state with pc = pc + 1; regs = set dst value regs; waiting = false; }
    );
  ] in
  let rec step (state0, state1) =
    if state0.is_done && state1.is_done then state1.sends
    else if state0.waiting && state1.waiting then state1.sends
    else (state0 |> execute instruction_set program, state1 |> execute instruction_set program) |> step
  in step
;;

let part2_init () =
  let input0 = Queue.create () in
  let input1 = Queue.create () in
  let send q v = Queue.add v q in
  let receive q = fun () -> try Some (Queue.pop q) with Queue.Empty -> None in
  { pc = 0; regs = Registers.(empty |> add 'p' 0); sends = 0; freq = 0; is_done = false; send = send input1; receive = receive input0; waiting = false; },
  { pc = 0; regs = Registers.(empty |> add 'p' 1); sends = 0; freq = 0; is_done = false; send = send input0; receive = receive input1; waiting = false; }
;;

let example2 = [|
  "snd 1";
  "snd 2";
  "snd p";
  "rcv a";
  "rcv b";
  "rcv c";
  "rcv d";
|];;

assert (part2_init () |> part2 example2 = 3);;

File.open_in "day18.input" (fun ch ->
  let program = Stream.of_lines ch |> Stream.to_array in
  part1_init () |> part1 program |> Printf.printf "part1: %d\n%!";
  part2_init () |> part2 program |> Printf.printf "part2: %d\n%!";
);;
