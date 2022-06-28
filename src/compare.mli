(** Module to compare Vg images.
    @author MrBigoudi *)

    
(** {1 Summary} 

  The Vg module let you use an equal function that checks if two images are exactly equals.

  However, when you look at two images, they can look alike even if they don't have the same constructors (example the image of an 'L' and the image of a 'J' which was mirrored.
    
  This module tries to check if two images are visually equal. 
*)
     

(** {1 How it works} 

  Vg.image constructors are hidden, in order to do pattern-matching with a Vg.image you need to reconstruct the constructors tree.
  
  In order to do that we use the Vg.I.to_string function to transform images to string and then, with some custom parsing, we transfom a Vg.image to an Compare.i_tree.
  
  Having this tree we can manipulate the images' infos to try compare them. 
*)



(** {2 Tokens}*)


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



(** {2 Intermediate module to manipulate the image.} *)


(** A module for all the functions used to compare images. *)
module ManipulateVg : sig


    (** {2 Intermediate functions to manipulate a string.} *)


    (** Get offset of next empty space. *) 
        
    (** {i next_space s n} -> offset of next empty space in {b s} starting from {b n} (include) *)
    val next_space : string -> int -> int


    (** Get offset of the next left parenthesis. *) 
    
    (** {i next_left_p s n} -> offset of next left parenthesis in {b s} starting from {b n} (include) *)
    val next_left_p : string -> int -> int


    (** Get offset of the next right parenthesis. *)

    (** {i next_right_p s n} -> offset of next right parenthesis in {b s} starting from {b n} (include) *)
    val next_right_p : string -> int -> int


    (** Get offset of the next i_token. *)

    (** {i next_image_modif s n} -> offset of next i_token in {b s} starting from {b n} (include) *)
    val next_image_modif : string -> int -> int


    (** Get a sub string. *)

    (** {i get_sub_string s first last} -> sub string of {b s} with the {b first} and {b end} position (exclude) *)
    val get_sub_string : string -> int -> int -> string


    (** Print a list of offsets. *)

    (** {i print_list_offset l} -> print the list {b l} *)
    val print_list_offset : int list -> unit


    (** Print a list of float tuple. *)

    (** {i print_list_paths l} -> print the list {b l} *)
    val print_list_paths : (float*float) list -> unit
  


    (** {2 Tokens getter from the Vg.image as a string.} *)


    (** Get a tr_token and the new offset. *)

    (** {i get_tr_token image_as_string current_offset} -> (token,new_offset) *)
    val get_tr_token : string -> int -> tr_token*int


    (** Get the 2 new offsets to divide the next research. *)

    (** {i get_blend_token image_as_string current_offset} -> (offset_image1,offset_image2) *)
    val get_blend_token : string -> int -> int*int


    (** Get the list of new offsets to divide the next researches. *)

    (** {i get_cut_token image_as_string current_offset} -> [offset_(image | path | outline);...] *)
    val get_cut_token : string -> int -> int list


    (** Get a const_token, ie an r,g,b,a color. *)

    (** {i get_const_token image_as_string current_offset} -> (r,g,b,a) *)
    val get_const_token : string -> int -> (float*float*float*float)


    (** Get a path_token, ie S (float float) L (float float) ... L (float float) Z. *)

    (** {i get_path_token image_as_string current_offset} -> [(x1,y1);...;(xn,yn)] *)
    val get_path_token : string -> int -> (float*float) list


    (** Get an outline_token {i (only the width of the outline for the moment)}. *)

    (** {i get_path_token image_as_string current_offset} -> width *)
    val get_outline_token : string -> int -> float  



    (** {2 Intermediate operations over paths.} *)


    (** Move a tuple. *)

    (** {i move (x1,y1) (x2,y2)} -> (x1+.x2,y1+.y2) *)
    val move : (float*float) -> (float*float) -> (float*float)

    (** Rotate a tuple. *)

    (** {i rot r (x,y)} -> (x*cos(r)-y*sin(r),x*sin(r)+y*cos(r)) *)
    val rot : float -> (float*float) -> (float*float)

    (** Scale a tuple. *)

    (** {i scale (x1,y1) (x2,y2)} -> (x1*.x2,y1*.y2) *)
    val scale : (float*float) -> (float*float) -> (float*float)
  


    (** {2 i_tree manipulation.}*)


    (** Create a tree of tokens representing an image from a string. *)

    (** {i create_i_tree image_as_string} -> i_tree representing the image as a tree of i_token *)
    val create_i_tree : string -> i_tree


    (** Convert an i_tree into a string. *)

    (** {i to_string tree} -> string to check if the create_tree function worked*)
    val to_string : i_tree -> string


    (** Get the list of path points in a tree, after applying necessary changes on it. *)

    (** {i get_points tree} -> [(x1,y1);...;(xn,yn)]*)
    val get_points : i_tree -> (float*float) list
  


    (** {2 Intermediate functions to compare i_tree} *)

(* 
    (** Split string using ' ' as delimiter + remove empty component in the result array. *)
    val split : string -> string list

    (** Filter list to omly keep numbers. *)
    val empty_array : string list -> string list

    (** Remove parentheses in a list of strings. *)
    val clean_array : string list -> string list

    (** Cast a string to a float*)
    val float_of_string : string -> float

    (** Debug tool to print a string list. *)
    val print_arr : string list -> unit

    (** Cast a string list to a tuple of float list. *)
    val create_tuple_list : string list -> (float * float) list *)

    (** Transform a Vg image to a tuple of float list. *)

    (** {i decompose i} -> [(x1,y1);...;(xn,yn)] *)
    val decompose : Vg.image -> (float * float) list

    (** Return true if two tuple of floats are equal. *)

    (** {i equal_float_tuple t1 t2} -> E(x1-x2)<=1e5 && E(y1-y2)<=1e5 *)
    val equal_float_tuple : (float * float) -> (float * float) -> bool
  
    (** Return true if a tuple of float is in a list. *)

    (** {i list_mem_bis t l} -> true if t in l {i (~equal: equal_float_tuple)} *)
    val list_mem_bis : (float * float) -> (float * float) list -> bool

    (** Remove copies in a list of float tuple. *)

    (** {i remove_double l} -> [(x1,y1);...;(xn,yn)] with (x1,y1) unique {i (~equal: equal_float_tuple)} *)
    val remove_double : (float * float) list -> (float * float) list

    (** Compare two list of float tuple. *)
    
    (** {i compare_list_tuples l1 l2} -> true if all t in l1 exists in l2 and vice-versa {i (~exists: equal_float_tuple or translated)} *)
    val compare_list_tuples : (float * float) list -> (float * float) list -> bool
end  



(** {2 Main function} *)


(** Compare two images *)

(** {i image_equal i1 i2} -> true if {b i1} and {b i2} are visually equal *)
val image_equal : Vg.image -> Vg.image -> bool