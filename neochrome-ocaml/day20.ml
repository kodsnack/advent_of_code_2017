#use "./lib.ml";;

type vector = int * int * int;;
type particle = { id : int; position : vector; velocity : vector; acceleration : vector; };;

let mdist (x,y,z) = (abs x) + (abs y) + (abs z);;
let vadd (ax,ay,az) (bx,by,bz) = ax+bx,ay+by,az+bz;;
let move ({position;velocity;acceleration} as particle) =
  let velocity = vadd acceleration velocity in
  let position = vadd velocity position in
  { particle with position; velocity }
;;
let by_pos p1 p2 = compare p1.position p2.position;;

let closest =
  List.fast_sort (fun a b ->
    match compare (mdist a.acceleration) (mdist b.acceleration) with
    | 0 ->
      begin match compare (mdist a.velocity) (mdist b.velocity) with
      | 0 -> compare (mdist a.position) (mdist b.position)
      | c -> c
      end
    | c -> c
  )
  >> List.hd >> (fun { id } -> id)
;;

let example1 = [
  { id = 0; position = 3,0,0; velocity = 2,0,0; acceleration = -1,0,0 };
  { id = 1; position = 4,0,0; velocity = 0,0,0; acceleration = -2,0,0 };
];;

assert (example1 |> closest = 0);;

let simulate times =
  let rec collide left last = function
    | [] ->
        begin match last with
        | `None | `Multiple _ -> left
        | `Single last -> last :: left
        end
    | p :: particles ->
      begin match last with
      | `None -> collide left (`Single p) particles
      | `Single last | `Multiple last when p.position = last.position -> collide left (`Multiple last) particles
      | `Single last -> collide (last :: left) (`Single p) particles
      | `Multiple last -> collide left (`Single p) particles
      end
  in
  let rec iter n particles =
    if n = 0 then particles
    else
      particles
      |> List.map move
      |> List.fast_sort by_pos
      |> collide [] `None
      |> iter (n - 1)
  in iter times
;;

let example2 = [
  { id = 0; position = -6,0,0; velocity =  3,0,0; acceleration = 0,0,0 };
  { id = 1; position = -4,0,0; velocity =  2,0,0; acceleration = 0,0,0 };
  { id = 2; position = -2,0,0; velocity =  1,0,0; acceleration = 0,0,0 };
  { id = 3; position =  3,0,0; velocity = -1,0,0; acceleration = 0,0,0 };
];;

assert (example2 |> simulate 3 |> (fun ps -> List.length ps = 1 && (List.hd ps).id = 3));;

let parse id line =
  Scanf.sscanf line
    "p=<%d,%d,%d>, v=<%d,%d,%d>, a=<%d,%d,%d>"
    (fun px py pz vx vy vz ax ay az ->
      { id; position = px,py,pz; velocity = vx,vy,vz; acceleration = ax,ay,az }
    )
;;

File.open_in "day20.input" (fun ch ->
  let input = Stream.of_lines ch |> Stream.to_list |> List.mapi parse in
  input |> closest |> Printf.printf "part1: %d\n%!";
  input |> simulate 100 |> List.length |> Printf.printf "part2: %d\n%!";
);;
