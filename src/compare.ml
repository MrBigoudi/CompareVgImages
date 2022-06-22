open Vg;;
open Gg;;

type tr_token =
    | Move of (float*float)
    | Rot of float
    | Scale of (float*float);;

  type i_token = 
    | Tr of tr_token
    | Blend
    | Cut
    | Path of (float*float) list
    | Outline of float
    | Const of (float*float*float*float);;

  type i_tree = 
    | F of i_token
    | Node of i_token * i_tree list;;

module ManipulateVg : sig
  (*Get offset of next empty space*)
  val next_space : string -> int -> int
  (*Get offset of next left parenthesis*)
  val next_left_p : string -> int -> int
  (*Get offset of next right parenthesis*)
  val next_right_p : string -> int -> int
  (*Get offset of next image modification*)
  val next_image_modif : string -> int -> int
  (*Get a sub string with the start and end position (exclude)*)
  val get_sub_string : string -> int -> int -> string


  (*Get a tr_token and the new offset*)
  val get_tr_token : string -> int -> tr_token*int
  (*Get the 2 new offsets to divide the next research*)
  val get_blend_token : string -> int -> int*int
  (*Get the list of new offsets to divide the next researches*)
  val get_cut_token : string -> int -> int list
  (*Get a const_token, ie (float float float float)*)
  val get_const_token : string -> int -> (float*float*float*float)
  (*Get a path_token, ie S (float float) L (float float) ... L (float float) Z*)
  val get_path_token : string -> int -> (float*float) list
  (*Get an outline_token, ie the width of the outline*)
  val get_outline_token : string -> int -> float


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
  let next_space str n = 
    String.index_from str n ' ';;
  let next_left_p str n = 
    String.index_from str n '(';;
  let next_right_p str n = 
    String.index_from str n ')';;
  let next_image_modif str n = 
    let len = String.length str in
      let rec aux offset =
        if (offset-1)>=len then failwith "can't find next image modif" else
        let n = (String.index_from str offset 'i') in
          match str.[n+1] with
          | '-' -> n+2(* from 'i-abc' to abc *)
          | _   -> (aux (offset+1))
      in (aux n);;

  let get_sub_string str s f =
    (String.sub str s (f-1));;
  
  let get_tr_token str offset = 
    let offset = (next_left_p str offset)+1 in
      let new_offset = (next_right_p str offset) in
        match str.[offset] with
        | 'm' -> let sub = (get_sub_string str offset new_offset) in
                  let res = (Scanf.sscanf sub "move (%f %f)" (fun x y -> (x,y))) in
                    let new_offset = (next_image_modif str new_offset) in
                      (Move(res),new_offset)

        | 'r' -> let sub = (get_sub_string str offset new_offset) in
                  let res = (Scanf.sscanf sub "rot %f" (fun x -> x)) in
                    let new_offset = (next_image_modif str new_offset) in
                      (Rot(res),new_offset)

        | 's' -> let sub = (get_sub_string str offset new_offset) in
                  let res = (Scanf.sscanf sub "scale (%f %f)" (fun x y -> (x,y))) in
                    let new_offset = (next_image_modif str new_offset) in
                      (Scale(res),new_offset)

        | _ -> failwith "unknown transformation";;

  let get_blend_token str offset = 
    let len = String.length str in
      let blend1 = (next_image_modif str offset) in
        let rec get_next_i nb_par cur_offset =
          if cur_offset >= len then failwith "can't find second image blended" else
            if nb_par == 0 then (next_image_modif str cur_offset) else
              match str.[cur_offset] with
              | '(' -> (get_next_i (nb_par+1) (cur_offset+1))
              | ')' -> (get_next_i (nb_par-1) (cur_offset+1))
              | _   -> (get_next_i nb_par (cur_offset+1))
            in 
              let blend2 = (get_next_i 1 blend1) in
                (blend1,blend2);;


  let get_cut_token str offset = failwith "TODO";;

  let get_const_token str offset = 
    let offset = (next_left_p str offset)+1 in
      let new_offset = (next_right_p str offset) in
        let sub = (get_sub_string str offset new_offset) in
          let res = (Scanf.sscanf sub "%f %f %f %f" (fun w x y z -> (w,x,y,z))) in res;;

  let get_path_token str offset = 
    let len = String.length str in
      let get_point offset =
        let end_of_tuple = (next_right_p str offset)+1 in
          let sub = (get_sub_string str offset end_of_tuple) in
            let res = (Scanf.sscanf sub "(%f %f)" (fun x y -> (x,y))) in 
              (*if end of path, ie '))'*)
              if str.[end_of_tuple]==')' then (res,end_of_tuple)
              else (res,(next_left_p str end_of_tuple))
      in
        let rec get_points cur_offset acc =
          if cur_offset>=len then failwith "can't find end of path" else
            match str.[cur_offset] with
            | ')' -> acc
            | '(' -> let (point,next_offset) = (get_point cur_offset) in
                      (get_points next_offset (point::acc))
            | _   -> let msg = (Printf.sprintf "unknown charactere '%c', at pos: %d\n" str.[cur_offset] cur_offset) in
                      failwith msg
        in (get_points (next_left_p str offset) []);;
  
  let get_outline_token str offset = 
    let offset = (next_left_p str offset)+1 in
    let new_offset = (next_right_p str offset) in
    let sub = (get_sub_string str offset new_offset) in
      let width = (Scanf.sscanf sub "width %f" (fun x -> x)) in width;;

  let create_i_tree str =
    let len = String.length str in
    let rec aux offset fin = 
      if offset >= fin then []
      else match str.[offset] with
        (*i-tr*)
        | 't' -> let (tr,new_offset) = (get_tr_token str offset)
                  in [(Node(Tr(tr),(aux new_offset fin)))]
        (*i-blend*)
        | 'b' -> let (new_offset1,new_offset2) = (get_blend_token str offset)
                  in [(Node(Blend,(aux new_offset1 new_offset2)@(aux new_offset2 fin)))]
        (*i-const || i-cut*)
        | 'c' -> let offset = offset+1 
                  (*i-const*)
                  in if str.[offset]=='o' then 
                    let const = (get_const_token str offset)
                    in [F(Const(const))]
                  (*i-cut*)
                  else let new_offsets = (get_cut_token str offset) in
                    let rec aux_cut l acc = 
                      match l with
                      | [] -> (Node(Cut,acc))
                      | h::[] -> (aux_cut [] ((aux h fin)@acc))
                      | h1::h2::t -> (aux_cut (h2::t) ((aux h1 h2)@acc))
                    in [(aux_cut new_offsets [])]
        (*path*)
        | 'p' -> let path = (get_path_token str offset)
                    in [F(Path(path))]
        (*outline*)
        | 'o' -> let outline = (get_outline_token str offset)
                    in [F(Outline(outline))] 
        (*error*)
        | _ -> let res = Printf.sprintf "unknown token at pos: %d\n" offset 
                    in failwith res
    in (aux 3 len);;


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
      (*remove right parentheses*)
      let rec f1 s = 
        let len = (String.length s) in
        match s.[len-1] with
        | '\n' -> f1 (String.sub s 0 (len-1))
        | ')' -> f1 (String.sub s 0 (len-1))
        | _ -> s 
      in 
      (*remove left parentheses*)
      let rec f2 s = 
        let len = (String.length s) in
        match s.[0] with
        | '(' -> f2 (String.sub s 1 (len-1)) 
        | _ -> s
      in (f2 (f1 s))
    (*remove all parentheses*)
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


 (*(i-tr (move (0.5 0))
  (i-tr (rot 1.5708)
   (i-blend Over
    (i-blend Over
     (i-cut anz
      (path S (0.1 0.142) L (0.14 0.142) L (0.14 0.182) L (0.1 0.182) L
       (0.1 0.142) Z)
      (i-const (1 0 0 1)))
     (i-cut
      (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.1 0.142) L (0.14 0.142) L (0.14 0.182) L (0.1 0.182) L
       (0.1 0.142) Z)
      (i-const (0.522522 0 0 1))))
    (i-blend Over
     (i-blend Over
      (i-cut anz
       (path S (0.142 0.1) L (0.182 0.1) L (0.182 0.14) L (0.142 0.14) L
        (0.142 0.1) Z)
       (i-const (1 0 0 1)))
      (i-cut
       (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
       (path S (0.142 0.1) L (0.182 0.1) L (0.182 0.14) L (0.142 0.14) L
        (0.142 0.1) Z)
       (i-const (0.522522 0 0 1))))
     (i-blend Over
      (i-blend Over
       (i-cut anz
        (path S (0.142 0.142) L (0.182 0.142) L (0.182 0.182) L (0.142 0.182)
         L (0.142 0.142) Z)
        (i-const (1 0 0 1)))
       (i-cut
        (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.142 0.142) L (0.182 0.142) L (0.182 0.182) L (0.142 0.182)
         L (0.142 0.142) Z)
        (i-const (0.522522 0 0 1))))
      (i-blend Over
       (i-cut anz
        (path S (0.184 0.1) L (0.224 0.1) L (0.224 0.14) L (0.184 0.14) L
         (0.184 0.1) Z)
        (i-const (1 0 0 1)))
       (i-cut
        (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.184 0.1) L (0.224 0.1) L (0.224 0.14) L (0.184 0.14) L
         (0.184 0.1) Z)
        (i-const (0.522522 0 0 1))))))))) *)
 











  