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


(** Default value as epsilon. *)
let epsilon = 1e-5;;

(** A module for all the functions used to compare images. *)
module ManipulateVg = struct 

  (** Get offset of next empty space. *)
  let next_space str n = 
    String.index_from str n ' ';;


  (** Get offset of the next left parenthesis. *)
  let next_left_p str n = 
    String.index_from str n '(';;


  (** Get offset of the next right parenthesis. *)
  let next_right_p str n = 
    String.index_from str n ')';;


  (** Get offset of the next i_token. *)
  let next_image_modif str n = 
    let len = String.length str in
    let rec aux offset =
      if (offset-1)>=len then failwith "can't find next image modif" else
        let n = (String.index_from str offset 'i') in
        match str.[n+1] with
        | '-' -> n+2(* from 'i-abc' to abc *)
        | _   -> (aux (offset+1))
    in (aux n);;


  (** Get a sub string. *)
  let get_sub_string str s f = (String.sub str s (f-s));;


  (** Print a list of offsets. *)
  let print_list_offset l = 
    let rec aux l = match l with
      | [] -> Printf.printf "\n"
      | offset::t -> Printf.printf "%d;" offset; (aux t)
    in (aux l);;


  (** Print a list of float tuple. *)
  let print_list_paths l = 
    Printf.printf "\npaths: [";
    let rec aux l = match l with
      | [] -> Printf.printf "\n\n"
      | (x,y)::[] -> Printf.printf "(%f,%f)]" x y; (aux [])
      | (x,y)::t -> Printf.printf "(%f,%f);" x y; (aux t)
    in (aux l);;


  (** Print a list of 6-uplet. *)
  let print_list_paths_color l = 
    Printf.printf "\npaths: [";
    let rec aux l = match l with
      | [] -> Printf.printf "\n\n"
      | (x,y,r,g,b,a)::[] -> Printf.printf "(%f,%f,%f,%f,%f,%f)]" x y r g b a; (aux [])
      | (x,y,r,g,b,a)::t -> Printf.printf "(%f,%f,%f,%f,%f,%f);" x y r g b a; (aux t)
    in (aux l);;


  (** Get a tr_token and the new offset. *)
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


  (** Get the 2 new offsets to divide the next research. *)
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


  (** Get the list of new offsets to divide the next researches. *)
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


  (** Get a const_token, ie an r,g,b,a color. *)
  let get_const_token str offset = 
    let offset = (next_left_p str offset)+1 in 
    let new_offset = (next_right_p str offset) in
    let sub = (get_sub_string str offset new_offset) in
          (* Printf.printf "get_const_token\n"; *)
    let res = (Scanf.sscanf sub "%f %f %f %f" (fun w x y z -> (w,x,y,z))) in (*Printf.printf "done\n";*) res;;


  (** Get a path_token, ie S (float float) L (float float) ... L (float float) Z. *)
  let get_path_token str offset = 
    let len = String.length str in
    let end_of_path n =
      (*if end of path, ie 'Z)'*) 
      let offset_next_z = (String.index_from str n 'Z') in
      let offset_next_l = (try (next_left_p str n) with Not_found -> len) in 
      if offset_next_z > offset_next_l then false
      else if (str.[offset_next_z+1]==')') then true 
        else false
    in
    let get_point offset =
      let end_of_tuple = (next_right_p str offset)+1 in
      let sub = (get_sub_string str offset end_of_tuple) in
      (* Printf.printf "get_path_token\n"; *)
      let res = (Scanf.sscanf sub "(%f %f)" (fun x y -> (x,y))) in 
      (* Printf.printf "done\n"; *)
      if (end_of_path end_of_tuple) then (res,(next_right_p str end_of_tuple))
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
  

  (** Get an outline_token {i (only the width of the outline for the moment)}. *)
  let get_outline_token str offset = 
    let offset = (next_left_p str offset)+1 in
    let new_offset = (next_right_p str offset) in
    let sub = (get_sub_string str offset new_offset) in
      (* Printf.printf "get_outline_token\n";  *)
    let width = (Scanf.sscanf sub "width %f" (fun x -> x)) in (*Printf.printf "done\n";*) width;;


  (*Move a tuple*)
  let move m t =
    match m with (x1,y1) ->
      match t with (x2,y2) -> ((x1+.x2),(y1+.y2));;
  (*Move with color*)
  let move_color m t =
    match m with (x1,y1) ->
      match t with (x2,y2,r,g,b,a) -> ((x1+.x2),(y1+.y2),r,g,b,a);;

  (*Rotate a tuple*)
  let rot r t =
    match t with (x,y) -> 
      let new_x = (x*.(Stdlib.cos r))-.(y*.(Stdlib.sin r)) in
      let new_y = (x*.(Stdlib.sin r))+.(y*.(Stdlib.cos r)) in
        (new_x,new_y);; 
  (*Rotate with color*)
  let rot_color r t =
    match t with (x,y,r1,g,b,a) -> 
      let new_x = (x*.(Stdlib.cos r))-.(y*.(Stdlib.sin r)) in
      let new_y = (x*.(Stdlib.sin r))+.(y*.(Stdlib.cos r)) in
        (* Printf.printf "r:%f, old:(%f,%f), new:(%f,%f)\n" r x y new_x new_y; *)
        (new_x,new_y,r1,g,b,a);;

  (*Scale a tuple*)
  let scale s t =
    match s with (x1,y1) ->
      match t with (x2,y2) -> ((x1*.x2),(y1*.y2));;
  (*Scale with color*)
  let scale_color s t =
    match s with (x1,y1) ->
      match t with (x2,y2,r,g,b,a) -> ((x1*.x2),(y1*.y2),r,g,b,a);;


  (** Create a tree of tokens representing an image from a string. *)
  let create_i_tree str =
    let len = String.length str in
    let rec aux offset fin = 
      let offset = (if str.[offset]=='i' then offset+2 else offset) in
      (* Printf.printf "\noffset: %d\n\n%s\n\n" offset (get_sub_string str offset len); *)
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

  
  (** Convert an i_tree into a string. *)
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

  
  (** Get the list of path points in a tree, after applying necessary changes on it. *)
  let get_points i =
    let rec aux i = 
      match i with
      | Empty -> []
      | F(Const(r,g,b,a)) -> [] (*TODO color check*)
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


  (** Get the list of path points with their color in a tree, after applying necessary changes on it. *)
  let get_points_color i =
    let map_color list r g b a =
      let rec aux l acc = match l with
        | [] -> acc
        | (x,y,-1.,-1.,-1.,-1.)::t -> (aux t ([(x,y,r,g,b,a)]@acc)) (* unmodified points *)
        | _::t -> (aux t acc)
      in (aux list [])
    in
    let rec aux i acc = 
      match i with
      | Empty -> acc
      | F(Const(r,g,b,a)) -> (map_color acc r g b a)
      | F(Outline(x)) -> acc (*TODO outline check*)
      | F(Path(l)) -> let tuple_to_color_tuple t = match t with (x,y)
                        -> (x,y,-1.,-1.,-1.,-1.) in
                        let new_l = List.map tuple_to_color_tuple l in
                          acc@new_l
      | Node(Tr(Move(x,y)),l) -> let new_move t = (move_color (x,y) t) in
                                  let rec aux2 i =
                                    match i with
                                    | [] -> []
                                    | h::t -> (aux h (acc@(aux2 t))) 
                                  in (List.map new_move (aux2 l))
      | Node(Tr(Rot(x)),l) -> (*Printf.printf "r:%f\n" x;*)
                              let new_rot t = (rot_color x t) in
                                let rec aux2 i =
                                    match i with
                                    | [] -> []
                                    | h::t -> (aux h (acc@(aux2 t)))
                                in (List.map new_rot (aux2 l)) 
      | Node(Tr(Scale(x,y)),l) -> let new_scale t = (scale_color (x,y) t) in
                                    let rec aux2 i =
                                      match i with
                                      | [] -> []
                                      | h::t -> (aux h (acc@(aux2 t)))
                                    in (List.map new_scale (aux2 l))
      | Node(Blend,l) -> let rec aux2 i_list =
                          match i_list with
                          | [] -> []
                          | h::t -> (aux h acc)@(aux2 t) in (aux2 l)
      | Node(Cut,l) -> let rec aux2 i_list =
                        match i_list with
                        | [] -> []
                        | h::t -> (aux h (acc@(aux2 t))) in (aux2 l)
      | _ -> failwith "\n\nerror get_points_with_color: unknown tree\n\n"
    in (aux i []);;


  (** Transform a Vg image to a tuple of float list. *)
  let decompose i = (get_points (create_i_tree (I.to_string i)));;


  (** Transform a Vg image to a 6-uplet of float list. *)
  let decompose_color i = (get_points_color (create_i_tree (I.to_string i)));;


  (** Return true if two tuple of floats are equal. *)
  let equal_float_tuple ?(epsilon=epsilon) t1 t2 =
    match t1 with (x1,y1) -> 
      match t2 with (x2,y2) ->
        let comp_x = (if (x1-.x2)<0. then ((x2-.x1)<=epsilon) else ((x1-.x2)<=epsilon)) in
          let comp_y = (if (y1-.y2)<0. then ((y2-.y1)<=epsilon) else ((y1-.y2)<=epsilon)) in
            (comp_x && comp_y);;


  (** Return true if two colors are equal. *)
  let equal_colors ?(epsilon) c1 c2 =
    match c1 with (r1,g1,b1,a1) ->
      match c2 with (r2,g2,b2,a2) ->
        (equal_float_tuple ?epsilon (r1,g1) (r2,g2)) && (equal_float_tuple ?epsilon (b1,a1) (b2,a2));;


  (** Return true if a tuple of float is in a list. *)
  let list_mem_bis ?(epsilon) ?(x_delta=0.) ?(y_delta=0.) t l = 
    let rec aux l = match l with
      | [] -> false
      | (x,y)::tl -> if (equal_float_tuple ?epsilon (x-.x_delta,y-.y_delta) t) then true
                  else (aux tl)
    in (aux l);;


  (** Return true if a path with its color is in a list of paths with their colors. *)
  let list_mem_color ?(epsilon) ?(x_delta=0.) ?(y_delta=0.) (p : ((float * float) * (float*float*float*float) list)) (l : ((float * float) * (float*float*float*float) list) list) =
    match p with (t,c) ->
      let rec in_color_list lc = match lc with
        | [] -> false
        | c1::tl -> match c with 
                    | [] -> failwith "This path doesn't have a color"
                    | c::[] -> if (equal_colors ?epsilon c1 c) then true
                                else (in_color_list tl)
                    | _ -> failwith "This path as more than one color"
      in
      let rec aux l = match l with
        | [] -> false
        | ((x,y),c1)::tl -> if ((equal_float_tuple ?epsilon (x-.x_delta,y-.y_delta) t)&&(in_color_list c1)) then true
                        else (aux tl)
      in (aux l);;

      
  (** Add a given path with its color in a list of path with their colors (without duplicate tuple). *)
  let add_color ?(epsilon) (p : ((float * float) * (float*float*float*float) list)) (l : ((float * float) * (float*float*float*float) list) list) =
    match p with (t,c) ->
      let rec aux l acc = match l with
        | [] -> acc@[(t,c)]
        | (t1,c1)::tl when (equal_float_tuple ?epsilon t1 t) -> 
            let newTuple = (t1,c1@c) in (acc@[newTuple]@tl)
        | h::tl -> (aux tl (acc@[h]))
      in (aux l []);;


  (** Remove copies in a list of float tuple. *)
  let remove_double ?(epsilon) l =
    let rec aux acc arr = match arr with
      | [] -> acc
      | h::t -> if (list_mem_bis ?epsilon h acc) then (aux acc t)
          else (aux (acc@[h]) t)
    in (aux [] l);; 


  (** Remove copies in a list of float 6-uplet and transfor them into a (float tuple * (float*float*float) list) tuple *)
  let remove_double_color ?(epsilon) l =
    let rec aux acc arr = match arr with 
      | [] -> acc
      | (x,y,r,g,b,a)::t -> let newAcc = (add_color ?epsilon ((x,y),[(r,g,b,a)]) acc)
                              in (aux newAcc t)
    in (aux [] l);;


  (* 
  (** Compare two list of float tuple (v1). *)
  let compare_list_tuples ?(epsilon) l1 l2 =
    let l1_unique = (remove_double ?epsilon l1) in
    let l2_unique = (remove_double ?epsilon l2) in
    let f1 tuple = list_mem_bis ?epsilon tuple l2_unique in
    let f2 tuple = list_mem_bis ?epsilon tuple l1_unique in
    (* print_list_paths l1_unique;
    print_list_paths l2_unique; *)
    ((List.length l1_unique)==(List.length l2_unique)) 
    && (List.for_all f1 l1_unique)
    && (List.for_all f2 l2_unique);; *)


  (** Compare two list of float tuple (v2). *)
  let compare_list_tuples ?(epsilon) l1 l2 =
    let l1_unique = (remove_double ?epsilon l1) in
    let l2_unique = (remove_double ?epsilon l2) in

    if l1=[] && l2=[] then true
    else
      if ((List.length l1_unique)!=(List.length l2_unique)) then false
      else
        (* get first element of list one *)
        match l1_unique with (x1,y1)::_ -> 
          let f1 x_delta y_delta tuple =
            list_mem_bis ?epsilon ~x_delta ~y_delta tuple l2_unique in
          let f2 x_delta y_delta tuple =
            list_mem_bis ?epsilon ~x_delta ~y_delta tuple l1_unique in 
          let rec aux l2 = match l2 with
            | [] -> false
            | (x2,y2)::t -> 
                (* get the delta *)
                let x_delta = (x2-.x1) in
                let y_delta = (y2-.y1) in
                  (* try with this delta *)
                  if (List.for_all (f1 x_delta y_delta) l1_unique) then
                    begin
                      (* try with the opposite of this delta for the other list *)
                      let x_delta = (-1.)*.x_delta in
                      let y_delta = (-1.)*.y_delta in
                      if (List.for_all (f2 x_delta y_delta) l2_unique) then true
                      else (aux t)
                    end
                  else (aux t)
          in (aux l2_unique);;


  (** Compare two list of path with their colors (v2). *)
  let compare_list_colors ?(epsilon) l1 l2 =
    let l1_unique = (remove_double_color ?epsilon l1) in
    let l2_unique = (remove_double_color ?epsilon l2) in

    if l1=[] && l2=[] then true
    else
      if ((List.length l1_unique)!=(List.length l2_unique)) then false
      else
        (* get first element of list one *)
        match l1_unique with ((x1,y1),_)::_ ->
          let at_least_one_color x_delta y_delta p list = 
            match p with ((x,y),colors) ->
              let rec aux colors = match colors with
                | [] -> false
                | (r,g,b,a)::tl -> let c = ((x,y),[(r,g,b,a)]) in
                                    if (list_mem_color ?epsilon ~x_delta ~y_delta c list) then true
                                      else (aux tl)
              in (aux colors)
          in
          let f1 x_delta y_delta p = 
            at_least_one_color x_delta y_delta p l2_unique in
          let f2 x_delta y_delta p = 
            at_least_one_color x_delta y_delta p l1_unique in
          let rec aux l2 = match l2 with
            | [] -> false
            | ((x2,y2),_)::t -> 
                (* get the delta *)
                let x_delta = (x2-.x1) in
                let y_delta = (y2-.y1) in
                  (* try with this delta *)
                  if (List.for_all (f1 x_delta y_delta) l1_unique) then
                    begin
                      (* try with the opposite of this delta for the other list *)
                      let x_delta = (-1.)*.x_delta in
                      let y_delta = (-1.)*.y_delta in
                      if (List.for_all (f2 x_delta y_delta) l2_unique) then true
                      else (aux t)
                    end
                  else (aux t)
          in (aux l2_unique);;


(* 
  (** Compare two list of path with their colors (v1). *)
  let compare_list_colors ?(epsilon) l1 l2 =
    let l1_unique = (remove_double_color ?epsilon l1) in
    let l2_unique = (remove_double_color ?epsilon l2) in
    let at_least_one_color p list = 
      match p with ((x,y),colors) ->
        let rec aux colors = match colors with
          | [] -> false
          | (r,g,b,a)::tl -> let c = ((x,y),[(r,g,b,a)]) in
                              if (list_mem_color ?epsilon c list) then true
                                else (aux tl)
        in (aux colors)
    in
      let f1 p = at_least_one_color p l2_unique in
      let f2 p = at_least_one_color p l1_unique in
      ((List.length l1_unique)==(List.length l2_unique)) 
      && (List.for_all f1 l1_unique)
      && (List.for_all f2 l2_unique);; *)

end

(** Compare 2 Vg images. *)
let image_equal ?(epsilon) ?(check_color=false) i1 i2 =
  if check_color then
    let di1 = (ManipulateVg.decompose_color i1) in
      let di2 = (ManipulateVg.decompose_color i2) in (ManipulateVg.compare_list_colors ?epsilon di1 di2)
  else
    let di1 = (ManipulateVg.decompose i1) in
      let di2 = (ManipulateVg.decompose i2) in (ManipulateVg.compare_list_tuples ?epsilon di1 di2);;
  