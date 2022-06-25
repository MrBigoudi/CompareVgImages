(** Module to compare Vg images. 
  @author MrBigoudi
*)

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

(** A module for all the functions used to compare images. *)
module ManipulateVg : sig
    (** Get offset of next empty space. *)
    val next_space : string -> int -> int

    (** Get offset of next left parenthesis. *)
    val next_left_p : string -> int -> int

    (** Get offset of next right parenthesis. *)
    val next_right_p : string -> int -> int

    (** Get offset of next image modification. *)
    val next_image_modif : string -> int -> int

    (** Get a sub string with the start and end position (exclude). *)
    val get_sub_string : string -> int -> int -> string

    (** Print a list of offsets. *)
    val print_list_offset : int list -> unit

    (** Print a list of float tuple. *)
    val print_list_paths : (float*float) list -> unit
  

  
    (** Get a tr_token and the new offset. *)
    val get_tr_token : string -> int -> tr_token*int

    (** Get the 2 new offsets to divide the next research. *)
    val get_blend_token : string -> int -> int*int

    (** Get the list of new offsets to divide the next researches. *)
    val get_cut_token : string -> int -> int list

    (** Get a const_token, ie (float float float float). *)
    val get_const_token : string -> int -> (float*float*float*float)

    (** Get a path_token, ie S (float float) L (float float) ... L (float float) Z. *)
    val get_path_token : string -> int -> (float*float) list

    (** Get an outline_token, ie the width of the outline. *)
    val get_outline_token : string -> int -> float
  


    (** Move a tuple. *)
    val move : (float*float) -> (float*float) -> (float*float)

    (** Rotate a tuple. *)
    val rot : float -> (float*float) -> (float*float)

    (** Scale a tuple. *)
    val scale : (float*float) -> (float*float) -> (float*float)
  


    (** Create a tree of tokens representing an image from a string. *)
    val create_i_tree : string -> i_tree

    (** Convert an i_tree into a string. *)
    val to_string : i_tree -> string

    (** Get the list of path points in a tree, after applying necessary changes on it. *)
    val get_points : i_tree -> (float*float) list
  


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
    val create_tuple_list : string list -> (float * float) list

    (** Transform a Vg image to a tuple of float list. *)
    val decompose : Vg.image -> (float * float) list

    (** Remove copies in a tuple of float list. *)
    val remove_double : (float * float) list -> (float * float) list

    (** Compare two tuple of float list. *)
    val compare_list_tuples : (float * float) list -> (float * float) list -> bool
end  

(** Compare 2 Vg images. 
    @return True if the images are equal, False otherwise.
*)
val image_equal : Vg.image -> Vg.image -> bool