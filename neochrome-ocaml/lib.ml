module Math = struct

  let rec fact n =
    if n = 0 then 1
    else n * (fact (n - 1))
  ;;

  let rec pow x n =
    if n = 0 then 1
    else x * (pow x (n - 1))
  ;;

end

let ( **. ) = Pervasives.( ** );;
let ( ** ) = Math.pow;;
let ( !! ) = Math.fact;;
let ( >> ) f g x = g (f x);;
let ( <| ) = ( @@ );;

module Seq = struct

  type 'a seq =
    | Empty
    | Element of 'a * (unit -> 'a seq)
  ;;

  let empty = Empty;;

  let rec unfold f state =
    match f state with
    | None -> Empty
    | Some(e, state') -> Element(e, fun () -> unfold f state')
  ;;

  let of_list = function
    | [] -> Empty
    | lst -> unfold (function [] -> None | hd :: tl -> Some (hd, tl)) lst
  ;;

  let range s e =
    unfold (function n when n <= e -> Some (n, n + 1) | _ -> None) s
  ;;

  let to_list =
    let rec to_list lst = function
      | Empty -> lst |> List.rev
      | Element (e, seq) -> to_list (e :: lst) (seq ())
    in
    to_list []
  ;;

  let rec flatten = function
    | Empty -> Empty
    | Element (seq, next) ->
        let rec unwind = function
          | Empty -> flatten (next ())
          | Element (e, next') -> Element (e, fun () -> unwind (next' ()))
    in unwind seq
  ;;

  let hd = function
    | Empty -> failwith "hd - empty sequence"
    | Element(e, _) -> e
  ;;

  let tl = function
    | Empty -> failwith "tl - empty sequence"
    | Element(_, seq) -> seq ()
  ;;

  let rec iter f = function
    | Empty -> ()
    | Element(e, seq) -> f e; iter f (seq ())
  ;;

  let fold f init seq =
    let acc = ref init in
    iter (fun e -> acc := f !acc e) seq;
    !acc
  ;;

  let rec map f = function
    | Empty -> Empty
    | Element(e, seq) -> Element(f e, fun () -> map f (seq ()))
  ;;

  let rec map2 f seq1 seq2 =
    match (seq1,seq2) with
    | Empty,Empty -> Empty
    | Empty,_ -> raise (Invalid_argument "1st sequence ran out of elements")
    | _,Empty -> raise (Invalid_argument "2nd sequence ran out of elements")
    | Element (e1,seq1), Element (e2,seq2) ->
      Element (f e1 e2, fun () -> map2 f (seq1 ()) (seq2 ()))
  ;;

  let rec filter p = function
    | Empty -> Empty
    | Element(e, seq) ->
      if p e then Element(e, fun () -> filter p (seq ()))
      else filter p (seq ())
  ;;

  let rec find p = function
    | Empty -> None
    | Element(e, seq) ->
      if p e then Some(e)
      else find p (seq ())
  ;;

  let rec take_while p = function
    | Empty -> Empty
    | Element(e, seq) ->
      if p e then Element(e, fun () -> take_while p (seq ()))
      else Empty
  ;;

  let rec take n = function
    | Empty -> Empty
    | Element(e, seq) ->
      if n = 0 then Empty
      else Element(e, fun () -> take (n - 1) (seq ()))
  ;;

  let rec skip_while p = function
    | Empty -> Empty
    | Element(e, seq) as elm ->
      if not (p e) then elm
      else skip_while p (seq ())
  ;;

  let rec skip n = function
    | Empty -> Empty
    | Element(e, seq) as elm ->
      if n = 0 then elm
      else skip (n - 1) (seq ())
  ;;

  let min seq =
    let min = ref (hd seq) in
    let minf x = if x < !min then min := x in
    iter minf (seq |> tl);
    !min
  ;;

  let max seq =
    let max = ref (hd seq) in
    let maxf x = if x > !max then max := x in
    iter maxf (seq |> tl);
    !max
  ;;

end


module File = struct

  let open_in filename fn =
    let ch = open_in filename in
    try
      let res = fn ch in
      close_in ch;
      res
    with e ->
      close_in ch;
      raise e
  ;;

end


#load "str.cma";;
module String = struct
  include String

  let to_list s =
    let rec build n l =
      if n = 0 then l
      else build (n - 1) (s.[n - 1] :: l)
    in
    build (String.length s) []
  ;;

  let from_list chars =
    String.init (List.length chars) (fun i -> List.nth chars i)
  ;;
  let of_list = from_list;;

  let starts_with prefix s =
    Str.string_match (Str.regexp ("^" ^ (Str.quote prefix))) s 0
  ;;

  let fold f init s =
    let rec collect acc = function
      | 0 -> f acc s.[0]
      | n -> collect (f acc s.[n]) (n - 1)
    in collect init (String.length s - 1)
  ;;
end


module Stream = struct
  include Stream

  let of_chars = Stream.of_channel
  ;;

  let of_lines ch =
    Stream.from (fun _ ->
      try Some (input_line ch)
      with End_of_file -> None
    )
  ;;

  let map f stream =
    let rec next i =
      try Some (f (Stream.next stream))
      with Stream.Failure -> None
    in
    Stream.from next
  ;;

  let mapi f stream =
    let rec next i =
      try Some (f i (Stream.next stream))
      with Stream.Failure -> None
    in
    Stream.from next
  ;;

  let find f stream =
    let rec search v =
      if f v then v
      else search @@ Stream.next stream
    in
    try
      search @@ Stream.next stream
    with Stream.Failure -> raise Not_found
  ;;

  let fold f init stream =
    let result = ref init in
    Stream.iter (fun x -> result := f x !result) stream;
    !result
  ;;

  let reduce = fold;;

  let fold_while f init stream =
    let rec iter acc =
      match Stream.peek stream with
      | None   -> acc
      | Some x -> Stream.junk stream;
        begin match f x acc with
        | None      -> acc
        | Some acc' -> iter acc'
        end
    in iter init
  ;;

  let reduce_while = fold_while;;

  let max stream =
    let rec search mx =
      match Stream.peek stream with
      | None    -> mx
      | Some(x) ->
        Stream.junk stream; search (Pervasives.max mx x)
    in
    search (Stream.next stream)
  ;;

  let maxf f stream =
    let maxf a b = if f a > f b then a else b in
    let rec search mx =
      match Stream.peek stream with
      | None    -> mx
      | Some(x) -> Stream.junk stream; search (maxf mx x)
    in
    search (Stream.next stream)
  ;;

  let filter p stream =
    let rec next i =
      match Stream.peek stream with
      | None -> None
      | Some x ->
        Stream.junk stream;
        if p x then Some x
        else next i
    in Stream.from next
  ;;

  let collect p stream =
    let rec next bag i =
      try
        let item = Stream.next stream in
        if p item then next (item :: bag) i
        else
          match bag with
          | [] -> next bag i
          | _ -> Some(List.rev bag)
      with Stream.Failure -> None
    in
    Stream.from (next [])
  ;;

  let to_list stream =
    let list = ref [] in
    Stream.iter (fun v -> list := !list @ [v]) stream;
    !list
  ;;

  let to_array stream =
    stream |> to_list |> Array.of_list
  ;;

  let skip n stream =
    for _ = 1 to n do
      Stream.junk stream
    done;
    stream
  ;;

  let take n stream =
    let rec take i =
      if i = n then None
      else Some(Stream.next stream)
    in
    Stream.from take
  ;;

  let concat s1 s2 =
    let rec concat i =
      begin match Stream.peek s1 with
      | None ->
        begin match Stream.peek s2 with
        | None -> None
        | Some _ -> Some(Stream.next s2)
        end
      | Some _ -> Some(Stream.next s1)
      end
    in
    Stream.from concat
  ;;

  let flatten streams =
    let lst = ref [] in
    let rec flatten i =
      match !lst with
      | [] ->
        begin match Stream.peek streams with
        | None -> None
        | Some _ -> lst := Stream.next streams; flatten i
        end
      | h :: t -> lst := t; Some(h)
    in
    Stream.from flatten
  ;;

  let chunk by stream =
    let chunks = Queue.create () in
    let rec next chunks i =
      match Stream.peek stream, Queue.is_empty chunks with
      | None, true -> None
      | Some item, true ->
        Stream.junk stream;
        by item |> List.iter (fun chunk -> Queue.add chunk chunks);
        next chunks i
      | _, false -> Some (Queue.take chunks)
    in Stream.from (next chunks)
  ;;

  let batch size stream =
    let rec next i =
      let rec batch items n =
        match Stream.peek stream with
        | None -> items
        | Some item ->
          Stream.junk stream;
          if n = 1 then item :: items |> List.rev
          else batch (item :: items) (n - 1)
      in match batch [] size with
      | [] -> None
      | items -> Some items
    in Stream.from next
  ;;

  let count stream =
    let rec count n =
      match Stream.peek stream with
      | Some _ -> Stream.junk stream; count (n + 1)
      | None -> n
    in count 0
  ;;

  let length = count;;

end


module List = struct
  include List

  let keep = List.filter;;
  let reject f = List.filter (fun x -> not (f x));;

  let filteri p items =
    let rec search i matching = function
      | [] -> matching
      | x :: items' ->
        if p i x then search (i + 1) (x :: matching) items'
        else search (i + 1) matching items'
    in
    search 0 [] items |> List.rev
  ;;

  let min items =
    let rec search items =
      match items with
      | [] -> failwith "min requires a non-empty list"
      | [x] -> x
      | x :: tail -> min x @@ search tail
    in
    search items
  ;;

  let max items =
    let rec search = function
      | [] -> failwith "a non-empty list is required"
      | [x] -> x
      | x :: tail -> Pervasives.max x (search tail)
    in
    search items
  ;;

  let minf f xs =
    let minf a b = if f a < f b then a else b in
    let rec search mx = function
      | [] -> mx
      | x :: xs -> search (minf mx x) xs
    in
    match xs with
    | [] -> failwith "a non-empty list is required"
    | x :: xs -> search x xs
  ;;

  let maxf f xs =
    let maxf a b = if f a > f b then a else b in
    let rec search mx = function
      | [] -> mx
      | x :: xs -> search (maxf mx x) xs
    in
    match xs with
    | [] -> failwith "a non-empty list is required"
    | x :: xs -> search x xs
  ;;

  let of_string = String.to_list
  ;;

  let skip n items =
    let rec build n s =
      if n = 0 then s
      else build (n-1) (List.tl s)
    in
    build n items
  ;;

  let take n items =
    let rec build acc n xs =
      match n,xs with
      | 0,_ | _,[] -> acc |> List.rev
      | _, x :: xs -> build (x :: acc) (n - 1) xs
    in build [] n items
  ;;

  let reduce f init items =
    let rec build acc = function
      | [] -> acc
      | h :: t -> build (f h acc) t
    in
    build init items
  ;;

  let rec remove x = function
    | [] -> []
    | hd :: tl when hd = x -> tl
    | hd :: tl -> hd :: remove x tl
  ;;
  let except = remove;;

  let rol = function
    | [] -> []
    | x :: xs ->
      let rec rol = function
        | [] -> [x]
        | hd :: tl -> hd :: rol tl
      in
      rol xs
  ;;

end

let ( -- ) xs x = List.remove x xs;;

module Option = struct
  let value_of o =
    match o with
    | Some x -> x
    | None -> failwith "no value"
  ;;

  let is_some o =
    match o with
    | Some _ -> true
    | None -> false
  ;;

  let is_none o = not @@ is_some o
  ;;
end


module Map = struct

  module type S = sig
    include Map.S
    val keys: 'a t -> key list
    val from_list: (key * 'a) list -> 'a t
    val from_stream: (key * 'a) Stream.t -> 'a t
  end

  module Make (Ord : Map.OrderedType) : S with type key = Ord.t = struct
    module Map = Map.Make(Ord)
    include Map

    let keys m = Map.fold (fun k _ acc -> k :: acc) m [];;

    let from_list l =
      let rec build l m =
        match l with
        | [] -> m
        | (k,v) :: t -> build t (Map.add k v m)
      in
      build l (Map.empty)
    ;;

    let from_stream s =
      let rec build s m =
        try
          let (k,v) = Stream.next s in
          build s (Map.add k v m)
        with Stream.Failure -> m
      in
      build s (Map.empty)
    ;;
  end

end

module Set = struct
  module type S = sig
    include Set.S
    val fold: (elt -> 'a -> 'a) -> 'a -> t -> 'a
  end

  module Make (Ord: Set.OrderedType) : S with type elt = Ord.t = struct
    module Set = Set.Make(Ord)
    include Set

    let fold f init set = Set.fold f set init;;
  end
end

module BFS = struct
  module type StateType = sig
    type t
    val possible_from: t -> t list
    val is_final: t -> bool
    type 'a hash
    val hash: t -> 'a hash
  end
  module Make (State: StateType) = struct
    let search ?trace initial_state =
      let states = Queue.create () in
      let seen = Hashtbl.create 10000 in

      let queue_if_not_seen steps = List.iter (fun state ->
        let hashed = State.hash state in
        if not (Hashtbl.mem seen hashed) then begin
          Queue.push (steps,state) states;
          Hashtbl.add seen hashed true
        end
      ) in

      let rec iter n =
        if Queue.is_empty states then None
        else
          let steps,state = Queue.pop states in
          begin match trace with
          | Some iterations when n mod iterations = 0 ->
            Printf.printf "search: iterations=%d steps=%d states=%d seen=%d\n%!" n steps (Queue.length states) (Hashtbl.length seen)
          | _ -> ()
          end;
          if State.is_final state then Some (steps,state)
          else begin
            State.possible_from state |> queue_if_not_seen (steps + 1);
            iter (n+1)
          end
      in

      State.possible_from initial_state |> queue_if_not_seen 1;
      iter 0
    ;;
  end
end;;
