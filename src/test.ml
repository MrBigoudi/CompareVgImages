open Compare;;

let test_outline = "(outline (width 0) (cap Butt) (join Miter) (miter-angle 0))";; 
let test_path = "(path S (0 1) L (0 2) L (0 3) L (0 4) L (0 5) Z)";; 
let test_const = "(i-const (0 0 0 0))";; 
let test_tr_move = "(i-tr (move (0 0))"^test_const^")";; 
let test_tr_rot = "(i-tr (rot 0)"^test_const^")";;
let test_tr_scale = "(i-tr (scale (0 0))"^test_const^")";; 
let test_blend = "(i-blend "^test_tr_move^test_const^")";;
let test_cut = "(i-cut "^test_outline^test_path^test_const^")";;
let test_hard = "(i-blend "^test_blend^"(i-blend "^test_blend^test_cut^"))";;

let test_create_i_tree () =
  Printf.printf "Tests create i-tree:\n\n\n";
  Printf.printf "Test outline input:\n%s\n\n" test_outline;
  Printf.printf "Test outline output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_outline));
  Printf.printf "Test path input:\n%s\n\n" test_path;
  Printf.printf "Test path output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_path));
  Printf.printf "Test const input:\n%s\n\n" test_const;
  Printf.printf "Test const output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_const));
  Printf.printf "Test tr move input:\n%s\n\n" test_tr_move;
  Printf.printf "Test tr move output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_tr_move));
  Printf.printf "Test tr rot input:\n%s\n\n" test_tr_rot;
  Printf.printf "Test tr rot output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_tr_rot));
  Printf.printf "Test tr scale input:\n%s\n\n" test_tr_scale;
  Printf.printf "Test tr scale output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_tr_scale));
  Printf.printf "Test blend input:\n%s\n\n" test_blend;
  Printf.printf "Test blend output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_blend));
  Printf.printf "Test cut input:\n%s\n\n" test_cut;
  Printf.printf "Test cut output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_cut));
  Printf.printf "Test hard input:\n%s\n\n" test_hard;
  Printf.printf "Test hard output:\n%s\n\n\n" (ManipulateVg.to_string (ManipulateVg.create_i_tree test_hard));;









