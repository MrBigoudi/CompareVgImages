let test_outline = "(outline (width 0) (cap Butt) (join Miter) (miter-angle 0))";; 
let test_path = "(path S (0 1) L (0 2) L (0 3) L (0 4) L (0 5) Z)";; 
let test_const = "(i-const (0 0 0 0))";; 
let test_tr_move = "(i-tr (move (0 0))"^test_const^")";; 
let test_tr_rot = "(i-tr (rot 0)"^test_const^")";;
let test_tr_scale = "(i-tr (scale (0 0))"^test_const^")";; 
let test_blend = "(i-blend "^test_tr_move^test_const^")";;
let test_cut = "(i-cut "^test_outline^test_path^test_const^")";;
let test_hard = "(i-blend "^test_blend^"(i-blend "^test_blend^test_cut^"))";;

let test_super_hard = "(i-blend Over
(i-blend Over
 (i-tr (move (1 0.5))
  (i-cut anz
  (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
    (0.1 0.205) Z)
  (i-const (1 0 0 1))))
 (i-tr (rot 0.5)
  (i-cut
    (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
    (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
    (0.1 0.205) Z)
    (i-const (0.522522 0 0 1)))))
(i-blend Over
 (i-blend Over
  (i-cut anz
   (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
    (0.205 0.1) Z)
   (i-const (1 0 0 1)))
  (i-cut
   (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
   (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
    (0.205 0.1) Z)
   (i-const (0.522522 0 0 1))))
 (i-blend Over
  (i-blend Over
   (i-cut anz
    (path S (0.205 0.205) L (0.305 0.205) L (0.305 0.305) L (0.205 0.305) L
     (0.205 0.205) Z)
    (i-const (1 0 0 1)))
   (i-cut
    (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
    (path S (0.205 0.205) L (0.305 0.205) L (0.305 0.305) L (0.205 0.305) L
     (0.205 0.205) Z)
    (i-const (0.522522 0 0 1))))
  (i-blend Over
   (i-cut anz
    (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L (0.31 0.1)
     Z)
    (i-const (1 0 0 1)))
   (i-cut
    (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
    (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L (0.31 0.1)
     Z)
    (i-const (0.522522 0 0 1)))))))";;

let test_create_i_tree () =
  Printf.printf "Tests create i-tree:\n\n\n";
  Printf.printf "Test outline input:\n%s\n\n" test_outline;
  Printf.printf "Test outline output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_outline));
  Printf.printf "Test path input:\n%s\n\n" test_path;
  Printf.printf "Test path output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_path));
  Printf.printf "Test const input:\n%s\n\n" test_const;
  Printf.printf "Test const output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_const));
  Printf.printf "Test tr move input:\n%s\n\n" test_tr_move;
  Printf.printf "Test tr move output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_tr_move));
  Printf.printf "Test tr rot input:\n%s\n\n" test_tr_rot;
  Printf.printf "Test tr rot output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_tr_rot));
  Printf.printf "Test tr scale input:\n%s\n\n" test_tr_scale;
  Printf.printf "Test tr scale output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_tr_scale));
  Printf.printf "Test blend input:\n%s\n\n" test_blend;
  Printf.printf "Test blend output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_blend));
  Printf.printf "Test cut input:\n%s\n\n" test_cut;
  Printf.printf "Test cut output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_cut));
  Printf.printf "Test hard input:\n%s\n\n" test_hard;
  Printf.printf "Test hard output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_hard));
  Printf.printf "Test super hard input:\n%s\n\n" test_super_hard;
  Printf.printf "Test super hard output:\n%s\n\n\n" (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_super_hard));
  Printf.printf "Fin de tests create i-tree:\n\n\n";;

let test_rot_cut = "(i-tr (rot 2)"^test_cut^")";;

let test_get_points_i_tree () =
  Printf.printf "Tests get points i-tree:\n\n\n";
  Printf.printf "Test rot_cut input:\n%s\n\n" test_rot_cut;
  Compare.ManipulateVg.print_list_paths (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_rot_cut));
  Printf.printf "Test super hard input:\n%s\n\n" test_super_hard;
  Compare.ManipulateVg.print_list_paths (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_super_hard));
  Printf.printf "Fin de tests get points i-tree:\n\n\n";;



let main () =
  test_create_i_tree();
  test_get_points_i_tree();;


let () = main();;