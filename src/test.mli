(** Module for testing functions. 
  @author MrBigoudi
*)

(** {1 Summary} 

  This module checks if all the functions defined in compare.mli work as expected. 
*)


(** {2 Do all the tests at once} *)

val main : unit -> unit


(** {2 Tests for intermediate functions to manipulate a string.} *)

(** Tests for intermediate string manipulation. *)
val tests_intermediate_string_manipulation : unit -> unit

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



(** {2 Tests for tokens getter from the Vg.image as a string.} *)

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



(** {2 Tests for intermediate operations over paths.} *)

(** ests for intermediate operations over paths. *)
val tests_intermediate_paths_manipulation : unit -> unit

(** Tests to move a tuple. *)
val test_move : unit -> unit
(* 
(** Tests to rotate a tuple. *)
val test_rot : unit -> unit

(** Tests to scale a tuple. *)
val test_scale : unit -> unit *)


(** {2 i_tree manipulation.}*)

(** Tests for i_tree manipulation. *)
val tests_i_tree_manipulation : unit -> unit

(** Tests for creating a tree, (it only prints the input and the output of the ManipulateVg.create_i_tree function). *)
val test_create_i_tree : unit -> unit

(** Tests for getting the paths point of a tree, (it prints the input and the output of the ManipulateVg.get_paths function). *)
val test_get_points_i_tree : unit -> unit



(** {2 Intermediate functions to compare i_tree} *)

(** Tests for intermediate functions to compare i_tree. *)
val tests_intermediate_i_tree_manipulation : unit -> unit

(** Tests for comparing tuples. *)
val test_equal_tuples : unit -> unit

(** Tests tuple exists in list. *)
val test_list_mem_bis : unit -> unit

(** Tests remove tuple repetitions in list. *)
val test_remove_double : unit -> unit


