open Vg;;
open Gg;;

module ManipulateVg : sig
  (*Split string using ' ' as delimiter + remove empty component in the result array*)
  val split : string -> string list

  (*Filter list to omly keep numbers*)
  val empty_array : string list -> string list

  (*Remove parentheses in a list of strings*)
  val clean_array : string list -> string list

  (*Cast a string to a float*)
  val float_of_string : string -> float

  (*Debug tool to print a string list*)
  val print_arr : string list -> unit

  (*Cast a string list to a tuple of float list*)
  val create_tuple_list : string list -> (float * float) list

  (*Transform a Vg image to a tuple of float list*)
  val decompose : image -> (float * float) list

  (*Remove copies in a tuple of float list*)
  val remove_double : (float * float) list -> (float * float) list

  (*Compare two tuple of float list*)
  val compare_list_tuples : (float * float) list -> (float * float) list -> bool

end = struct 

  let split str =
    str
    |> String.split_on_char ' '
    |> List.filter (fun s -> s <> "");;

  let empty_array arr = 
    let is_int c = 
      let code = (Char.code c) 
      in ((code>=(Char.code '0'))&&(code<=(Char.code '9')))
    in 
    let f s = match s.[0] with
      | '(' -> (is_int s.[1])
      | a -> (is_int a) && ((String.length s)>1)
    in (List.filter f arr);;

  let clean_array arr = 
    let f s = 
      let rec f1 s = 
        let len = (String.length s) in
        match s.[len-1] with
        | '\n' -> f1 (String.sub s 0 (len-1))
        | ')' -> f1 (String.sub s 0 (len-1))
        | _ -> s 
      in 
      let rec f2 s = 
        let len = (String.length s) in
        match s.[0] with
        | '(' -> f2 (String.sub s 1 (len-1)) 
        | _ -> s
      in (f2 (f1 s))
    in (List.map f arr);;

  let float_of_string s =
    let t = (Scanf.sscanf s "%f" (fun x -> x)) in t;;

  let rec print_arr arr = match arr with
    | [] -> Printf.printf "\n\n\n"
    | h::t -> Printf.printf "%s" (h^"  ");(print_arr t);;

  let create_tuple_list arr =
    let rec aux acc arr = match arr with
      | [] -> acc
      | l::r::t -> (aux (((float_of_string l),(float_of_string r))::acc) t)
      | h::[] -> acc
    in (aux [] arr);;

  let decompose i =
    let str = I.to_string i in 
    let arr = split str in
    let arr = (empty_array arr) in
    let arr = (clean_array arr) in
    (create_tuple_list arr);;

  let remove_double l =
    let rec aux acc arr = match arr with
      | [] -> acc
      | h::t -> if (List.mem h acc) then (aux acc t)
          else (aux (h::acc) t)
    in (aux [] l);; 

  let compare_list_tuples l1 l2 =
    let l1_unique = (remove_double l1) in
    let l2_unique = (remove_double l2) in
    let f1 tuple = List.mem tuple l2_unique in
    let f2 tuple = List.mem tuple l1_unique in
    ((List.length l1_unique)==(List.length l2_unique)) 
    && (List.for_all f1 l1_unique)
    && (List.for_all f2 l2_unique);;

end

let image_equal i1 i2 =
  let i1_tuples = ManipulateVg.decompose i1 in
  let i2_tuples = ManipulateVg.decompose i2 in 
  (ManipulateVg.compare_list_tuples i1_tuples i2_tuples);;