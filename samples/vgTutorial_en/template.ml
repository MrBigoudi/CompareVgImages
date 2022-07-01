(*Question 1*)
let create_color r g b a = failwith "TODO";;
(*Test question 1*)
let red = create_color 1. 0. 0. 1.;;

(*Question 2*)
let create_circle x y color r = failwith "TODO";;
(*Test question 2*)
create_circle 0.1 0.1 red 0.01;;

(*Question 3*)
let create_dot_square x y l color r = failwith "TODO";;
(*Test question 3*)
create_dot_square 0.1 0.1 0.4 red 0.01;;

(*Question 4*)
let create_square_with_outline x y l color w = failwith "TODO";;
(*Test question 4*)
create_square_with_outline 0.1 0.1 0.4 red 0.04;;

(*Question 5*)
let j_color = create_color 0. 0.443 0.757 1.;;
let l_color = create_color 1. 0.753 0. 1.;;
let o_color = create_color 1. 1. 0.004 1.;;
let s_color = create_color 0.573 0.82 0.31 1.;;
let t_color = create_color 0.439 0.188 0.627 1.;;
let z_color = create_color 1. 0. 0. 1.;;
let i_color = create_color 0.004 0.690 0.945 1.;;

let create_block_j x y l = failwith "TODO";;
let create_block_l x y l = failwith "TODO";;
let create_block_o x y l = failwith "TODO";;
let create_block_s x y l = failwith "TODO";;
let create_block_t x y l = failwith "TODO";;
let create_block_z x y l = failwith "TODO";;
let create_block_i x y l = failwith "TODO";;

(*Test question 5*)
let block_j = create_block_j 0.1 0.1 0.1;;
let block_l = create_block_l 0.1 0.1 0.1;;
let block_o = create_block_o 0.1 0.1 0.1;;
let block_s = create_block_s 0.1 0.1 0.1;;
let block_t = create_block_t 0.1 0.1 0.1;;
let block_z = create_block_z 0.1 0.1 0.1;;
let block_i = create_block_i 0.1 0.1 0.1;;

(*Question 6*)
let pi = Float.pi;;
let centre = (P2.v 0.5 0.);;
let rotate_45_deg piece nb_rotation =  failwith "TODO";;

(*Test question 6*)
block_j;;
let rotate1_j = (rotate_45_deg block_j 1);;
let rotate2_j = (rotate_45_deg block_j 2);;
let rotate3_j = (rotate_45_deg block_j 3);;
let rotate4_j = (rotate_45_deg block_j 4);;