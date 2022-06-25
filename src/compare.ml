open Vg;;
open Gg;;


(** Tokens for translation. *)
type tr_token =
  | Move of (float*float) (** Move token. *)
  | Rot of float (** Rotation token. *)
  | Scale of (float*float) (** Scale token. *)
;;

(** Tokens for image. *)
type i_token = 
  | Tr of tr_token (** Represents a translation. *)
  | Blend (** Represents a blend of two images. *)
  | Cut (** Represents a cut image. *)
  | Path of (float*float) list (** Represents a list of path. *)
  | Outline of float (** Represents an outlined image. *)
  | Const of (float*float*float*float) (** Represnts a color. *)
;;

(** Represents an image as a tree token. *)
type i_tree = 
  | Empty (** The empty tree. *)
  | F of i_token (** A tree leaf. *)
  | Node of i_token * i_tree list (** A tree node. *)
;;

(** A hidden module for all the functions used to compare images. *)
module ManipulateVg = struct 
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

  let print_list_offset l = 
    let rec aux l = match l with
      | [] -> Printf.printf "\n"
      | offset::t -> Printf.printf "%d;" offset; (aux t)
    in (aux l);;

  let print_list_paths l = 
    Printf.printf "\npaths: [";
    let rec aux l = match l with
      | [] -> Printf.printf "\n\n"
      | (x,y)::[] -> Printf.printf "(%f,%f)]" x y; (aux [])
      | (x,y)::t -> Printf.printf "(%f,%f);" x y; (aux t)
    in (aux l);;

  let to_string i =
    let rec aux i =
      match i with
      | Empty -> ""
      | F(Const(w,x,y,z)) -> Printf.sprintf "const (%f,%f,%f,%.f)\n" w x y z
      | F(Outline(x)) -> Printf.sprintf "outline (%f)\n" x
      | F(Path(l)) -> let rec aux l acc = match l with
          | [] -> acc^"\n"
          | (x,y)::[] -> let tmp = Printf.sprintf "(%f,%f)]" x y in (aux [] (acc^tmp))
          | (x,y)::t -> let tmp = Printf.sprintf "(%f,%f);" x y in (aux t (acc^tmp))
          in (aux l "path [")
      | Node(Tr(Move(x,y)),l) -> let rec aux2 i_list =
                                   match i_list with
                                   | [] -> ""
                                   | h::t -> (aux h)^(aux2 t)
          in (Printf.sprintf "tr move (%f,%f)\n" x y)^(aux2 l)
      | Node(Tr(Rot(x)),l) -> let rec aux2 i_list =
                                match i_list with
                                | [] -> ""
                                | h::t -> (aux h)^(aux2 t)
          in (Printf.sprintf "tr rot %f\n" x)^(aux2 l)
      | Node(Tr(Scale(x,y)),l) -> let rec aux2 i_list =
                                    match i_list with
                                    | [] -> ""
                                    | h::t -> (aux h)^(aux2 t)
          in (Printf.sprintf "tr scale (%f,%f)\n" x y)^(aux2 l)
      | Node(Blend,l) -> let rec aux2 i_list =
                           match i_list with
                           | [] -> ""
                           | h::t -> (aux h)^(aux2 t)
          in "blend\n"^(aux2 l)
      | Node(Cut,l) -> let rec aux2 i_list =
                         match i_list with
                         | [] -> ""
                         | h::t -> (aux h)^(aux2 t)
          in "cut\n"^(aux2 l)
      | _ -> failwith "\n\nerror to_string: unkown i_tree\n\n"
    in (aux i);;


  let get_sub_string str s f = (String.sub str s (f-s));;
  

  let get_tr_token str offset = 
    let offset = (next_left_p str offset)+1 in
    let new_offset = (next_right_p str offset) in
    match str.[offset] with
    | 'm' -> let new_offset = new_offset+1 in
        let sub = (get_sub_string str offset new_offset) in
                    (* Printf.printf "get_tr_token -> move\n%s" sub; *)
        let res = (Scanf.sscanf sub "move (%f %f)" (fun x y -> (x,y))) in
                      (* Printf.printf "done\n"; *)
        let new_offset = (next_image_modif str new_offset) in
        (Move(res),new_offset)

    | 'r' -> let sub = (get_sub_string str offset new_offset) in
                  (* Printf.printf "get_tr_token -> rot\n"; *)
        let res = (Scanf.sscanf sub "rot %f" (fun x -> x)) in
                    (* Printf.printf "done\n"; *)
        let new_offset = (next_image_modif str new_offset) in
        (Rot(res),new_offset)

    | 's' -> let new_offset = new_offset+1 in
        let sub = (get_sub_string str offset new_offset) in
                    (* Printf.printf "get_tr_token -> scale\n"; *)
        let res = (Scanf.sscanf sub "scale (%f %f)" (fun x y -> (x,y))) in
                      (* Printf.printf "done\n"; *)
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
    (* Printf.printf "blend1: %d; blend2: %d\n" blend1 blend2;
    Printf.printf "\n\nblend1: \n%s\n\n" (String.sub str blend1 (len-blend1));
    Printf.printf "\n\nblend2: \n%s\n\n" (String.sub str blend2 (len-blend2));                   *)
    (blend1,blend2);;


  let get_cut_token str offset = 
    let len = String.length str in
    let rec get_next_offset nb_par cur_offset =
      if cur_offset>=len then failwith "can't find end of cut" else
      if nb_par == 0 then let res = (next_left_p str cur_offset)+1 in
        begin
          res;
        end
      else
        match str.[cur_offset] with
        | '(' -> (get_next_offset (nb_par+1) (cur_offset+1))
        | ')' -> (get_next_offset (nb_par-1) (cur_offset+1))
        | _   -> (get_next_offset nb_par (cur_offset+1))
    in 
    let rec get_offsets cur_offset acc =
      if cur_offset>=len then failwith "can't find end of cut" else
            (*end of cut*)
      if str.[cur_offset] == 'i' then
        match acc with 
        | [] -> begin
            (* Printf.printf "\n\noffsets: %d -> fin offset\n\n" (cur_offset+2); *)
            [cur_offset+2]
          end
        | a::acc -> (*begin
            Printf.printf "\n\noffsets: ";
            (print_list_offset ((cur_offset+2)::acc)); 
            Printf.printf " -> fin offset\n\n";*)
            ((cur_offset+2)::acc)
          (* end *)
      else
        let cur_offset = (get_next_offset 1 cur_offset) in
        begin
                  (* Printf.printf "\n\ncur offset: \n%s\n\n" (String.sub str cur_offset (len-cur_offset)); *)
          (get_offsets cur_offset (cur_offset::acc))
        end
    in 
    let first_offset = (next_left_p str offset)+1 in
    (get_offsets first_offset [first_offset]);;


  let get_const_token str offset = 
    let offset = (next_left_p str offset)+1 in 
    let new_offset = (next_right_p str offset) in
    let sub = (get_sub_string str offset new_offset) in
          (* Printf.printf "get_const_token\n"; *)
    let res = (Scanf.sscanf sub "%f %f %f %f" (fun w x y z -> (w,x,y,z))) in (*Printf.printf "done\n";*) res;;


  let get_path_token str offset = 
    let len = String.length str in
    let get_point offset =
      let end_of_tuple = (next_right_p str offset)+1 in
      let sub = (get_sub_string str offset end_of_tuple) in
            (* Printf.printf "get_path_token\n"; *)
      let res = (Scanf.sscanf sub "(%f %f)" (fun x y -> (x,y))) in 
              (* Printf.printf "done\n"; *)
              (*if end of path, ie ') Z)'*)
      if str.[end_of_tuple+2]==')' then (res,(next_right_p str end_of_tuple))
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
      (* Printf.printf "get_outline_token\n";  *)
    let width = (Scanf.sscanf sub "width %f" (fun x -> x)) in (*Printf.printf "done\n";*) width;;


  let create_i_tree str =
    let len = String.length str in
    let rec aux offset fin = 
      let offset = (if str.[offset]=='i' then offset+2 else offset) in
      if offset >= fin then Empty
      else match str.[offset] with
        (*i-tr*)
        | 't' -> let (tr,new_offset) = (get_tr_token str offset)
            in (Node(Tr(tr),[(aux new_offset fin)]))
        (*i-blend*)
        | 'b' -> let (new_offset1,new_offset2) = (get_blend_token str offset)
            in (Node(Blend,[(aux new_offset1 new_offset2)]@[(aux new_offset2 fin)]))
        (*i-const || i-cut*)
        | 'c' -> let offset = offset+1 
                  (*i-const*)
            in if str.[offset]=='o' then 
              let const = (get_const_token str offset)
              in F(Const(const))
                  (*i-cut*)
            else let new_offsets = List.rev (get_cut_token str offset) in
              let rec aux_cut l acc = 
                match l with
                | [] -> (Node(Cut,acc))
                | h::[] -> (aux_cut [] ([(aux h fin)]@acc))
                | h1::h2::t -> (aux_cut (h2::t) ([(aux h1 h2)]@acc))
              in (aux_cut new_offsets [])
        (*path*)
        | 'p' -> let path = (get_path_token str offset)
            in F(Path(path))
        (*outline*)
        | 'o' -> let width = (get_outline_token str offset)
            in F(Outline(width)) 
        (*error*)
        | _ -> let res = Printf.sprintf "unknown token at pos: %d\n" offset 
            in failwith res
    in (aux 1 len);;

  (*Move a tuple*)
  let move t1 t2 =
    match t1 with (x1,y1) ->
      match t2 with (x2,y2) -> ((x1+.x2),(y1+.y2));;
  (*Rotate a tuple*)
  let rot r t =
    match t with (x,y) -> ((r*.x),(r*.y));;
  (*Scale a tuple*)
  let scale t1 t2 =
    match t1 with (x1,y1) ->
      match t2 with (x2,y2) -> ((x1*.x2),(y1*.y2));;

  let get_points i =
    let rec aux i = 
      match i with
      | Empty -> []
      | F(Const(w,x,y,z)) -> [] (*TODO color check*)
      | F(Outline(x)) -> [] (*TODO outline check*)
      | F(Path(l)) -> l
      | Node(Tr(Move(x,y)),l) -> let new_move t = (move (x,y) t) in
                                  let rec aux2 i =
                                   match i with
                                   | [] -> []
                                   | h::t -> (aux h)@(aux2 t) 
                                  in (List.map new_move (aux2 l))
      | Node(Tr(Rot(x)),l) -> let new_rot t = (rot x t) in
                                let rec aux2 i =
                                  match i with
                                  | [] -> []
                                  | h::t -> (aux h)@(aux2 t) 
                                in (List.map new_rot (aux2 l)) 
      | Node(Tr(Scale(x,y)),l) -> let new_scale t = (scale (x,y) t) in
                                    let rec aux2 i =
                                      match i with
                                      | [] -> []
                                      | h::t -> (aux h)@(aux2 t) 
                                    in (List.map new_scale (aux2 l))
      | Node(Blend,l) -> let rec aux2 i_list =
                          match i_list with
                          | [] -> []
                          | h::t -> (aux h)@(aux2 t) in (aux2 l)
      | Node(Cut,l) -> let rec aux2 i_list =
                        match i_list with
                        | [] -> []
                        | h::t -> (aux h)@(aux2 t) in (aux2 l)
      | _ -> failwith "\n\nerror get_points: unknown tree\n\n"
    in (aux i);;









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

let image_equal i1 i2 =
let di1 = (ManipulateVg.decompose i1) in
let di2 = (ManipulateVg.decompose i2) in (ManipulateVg.compare_list_tuples di1 di2);;

