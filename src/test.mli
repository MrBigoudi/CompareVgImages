(** Module for testing functions. 
  @author MrBigoudi
*)

(** {1 Summary} 

  This module checks if all the functions defined in compare.mli work as expected. 
*)

  

(** {2 Main tests} *)


(** Do all the tests at once. *)
val main : unit -> unit

(** Tests for image_equal, the main function of the Compare module. *)
val test_image_equal : unit -> unit



(** {2 Tests for intermediate functions to manipulate a string.} *)

(** Module containing tests for intermediate functions to manipulate a string. *)
module Intermediate_string_manipulation : sig

  (** Tests index to the next space. *)
  val test_next_space : unit -> unit

  (** Tests index to the next left parenthesis. *)
  val test_next_left_p : unit -> unit

  (** Tests index to the next right parenthesis. *)
  val test_next_right_p : unit -> unit

  (** Tests index of the next right i-token. *)
  val test_next_image_modif : unit -> unit

  (** Tests to get a sub string. *)
  val test_get_sub_string : unit -> unit

  (** Tests for intermediate string manipulation. *)
  val tests_intermediate_string_manipulation : unit -> unit

end



(** {2 Tests for tokens getter from the Vg.image as a string.} *)

(** Module containing tests for tokens getter from the Vg.image as a string.*)
module Token_getters : sig

  (** Tests for tokens getter from the Vg.image as a string. *)
  val tests_token_getters : unit -> unit

  (** Tests to get a tr_token. *)
  val test_get_tr_token : unit -> unit

  (** Tests to get a blend_token. *)
  val test_get_blend_token : unit -> unit

  (** Tests to get a cut_token. *)
  val test_get_cut_token : unit -> unit

  (** Tests to get a const_token. *)
  val test_get_const_token : unit -> unit

  (** Tests to get a path_token. *)
  val test_get_path_token : unit -> unit

  (** Tests to get an outline_token. *)
  val test_get_outline_token : unit -> unit

  (** Tests for tokens getter from the Vg.image as a string. *)
  val tests_token_getters : unit -> unit

end


(** {2 Tests for intermediate operations over paths.} *)

(** Module containing tests for intermediate operations over paths.*)
module Intermediate_paths_manipulation : sig

  (** Tests to move a tuple. *)
  val test_move : unit -> unit

  (** Tests to rotate a tuple. *)
  val test_rot : unit -> unit

  (** Tests to scale a tuple. *)
  val test_scale : unit -> unit
   
  (** Tests to move a path with its color. *)
  val test_move_color : unit -> unit
 
  (** Tests to rotate a path with its color. *)
  val test_rot_color : unit -> unit

  (** Tests to scale a path with its color. *)
  val test_scale_color : unit -> unit

  (** Tests for intermediate operations over paths. *)
  val tests_intermediate_paths_manipulation : unit -> unit

end



(** {2 Tests for intermediate functions to compare i_tree} *)

(** Module containing tests for intermediate functions to compare i_tree.*)
module Intermediate_i_tree_manipulation : sig

  (** Tests for comparing tuples. *)
  val test_equal_tuples : unit -> unit

  (** Tests tuple exists in list. *)
  val test_list_mem_bis : unit -> unit

  (** Tests remove tuple repetitions in list. *)
  val test_remove_double : unit -> unit

  (** Tests compare two list of float tuple. *)
  val test_compare_list_tuples : unit -> unit

  (** Tests for comparing colors. *)
  val test_equal_colors : unit -> unit

  (** Tests if an element is in a list of paths with their colors. *)
  val list_mem_color : unit -> unit

  (** Tests for intermediate functions to compare i_tree. *)
  val tests_intermediate_i_tree_manipulation : unit -> unit

end



(** {2 Tests for i_tree manipulation.}*)

(** Module containing tests for i_tree manipulation.*)
module I_tree_manipulation : sig

  (** Tests for creating a tree. *)
  val test_create_i_tree : unit -> unit

  (** Tests for getting the paths point of a tree. *)
  val test_get_points_i_tree : unit -> unit

  (** Tests for getting the paths point (with their color) of a tree. *)
  val test_get_points_color_i_tree : unit -> unit

  (** Tests for i_tree manipulation. *)
  val tests_i_tree_manipulation : unit -> unit

end