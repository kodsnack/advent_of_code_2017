#use "./lib.ml";;

let split after lst =
  let rec find head = function
    | _,[] -> head, []
    | i,hd::tl when i = after -> (hd :: head), tl
    | i,hd::tl -> find (hd::head) (i + 1, tl)
  in find [] (0, lst)
;;

let insert_after i item items =
  let before, after = items |> split i in List.rev_append before (item::after)
;;

let insert rounds step =
  let rec iter items i n =
    let length = List.length items in
    if n > rounds then i,items
    else
      let i' = (i + step) mod length in
      iter (items |> insert_after i' n) (i' + 1) (n + 1)
  in iter [0] 0 1
;;

let example = 3;;
let input = 380;;

let part1 = insert 2017 >> (fun (i,items) -> List.nth items ((i + 1) mod (List.length items)));;
assert (example |> part1 = 638);;

input |> part1 |> Printf.printf "part1: %d\n%!";;

let part2 rounds step =
  let rec spin step za i l =
    if l = rounds + 1 then za
    else begin
      let i' = (i + step) mod l in
      let l' = (l + 1) in
      let za' = if i' = 0 then l else za in
      spin step za' (i' + 1) l'
    end
  in spin step 0 0 1
;;

assert ((example |> part2 2017) = (example |> insert 2017 |> snd |> (fun l -> List.nth l 1)));;
input |> part2 50_000_000 |> Printf.printf "part2: %d\n%!";;
