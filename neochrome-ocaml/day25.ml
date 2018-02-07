type dir = Left | Right;;

let example state value =
  match state with
  | 'A' -> if value = 0 then (1, Right, 'B') else (0, Left, 'B')
  | 'B' -> if value = 0 then (1, Left, 'A') else (1, Right, 'A')
  | _ -> failwith (Printf.sprintf "unsupported state: %c" state)
;;

let input state value =
  match state with
  | 'A' -> if value = 0 then (1, Right, 'B') else (0, Left, 'C')
  | 'B' -> if value = 0 then (1, Left, 'A') else (1, Right, 'D')
  | 'C' -> if value = 0 then (0, Left, 'B') else (0, Left, 'E')
  | 'D' -> if value = 0 then (1, Right, 'A') else (0, Right, 'B')
  | 'E' -> if value = 0 then (1, Left, 'F') else (1, Left, 'C')
  | 'F' -> if value = 0 then (1, Right, 'D') else (1, Right, 'A')
  | _ -> failwith (Printf.sprintf "unsupported state: %c" state)
;;

module Tape = struct
  let initial = [],0,[]

  let write value dir (left,current,right) =
    match left,right,dir with
    | [],[],Right -> [],0,[value]
    | [],_, Right -> [],0,value::right
    | l::left',_,Right -> left',l,value::right
    | [],[],Left -> [value],0,[]
    | _,r::right',Left -> value::left,r,right'
    | _,[],Left -> value::left,0,[]

  let read (_,current,_) = current

  let to_list (left,current,right) = (List.rev right) @ [current] @ left

  let dump t = t |> to_list |> List.map string_of_int |> String.concat "," |> print_endline; t

  let checksum t = t |> to_list |> List.fold_left ( + ) 0
end;;

let rec execute states steps state tape =
  if steps = 0 then tape
  else
    let value,dir,state' = tape |> Tape.read |> states state in
    tape |> Tape.write value dir |> execute states (steps - 1) state'
;;

assert (Tape.initial |> execute example 6 'A' |> Tape.checksum = 3);;

Tape.initial |> execute input 12481997 'A' |> Tape.checksum |> Printf.printf "part1: %d\n";;
