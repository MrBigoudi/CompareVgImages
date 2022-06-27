(*List of tests*)
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

(** Tests for creating a tree, (it only prints the input and the output of the ManipulateVg.create_i_tree function). *)
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
  Printf.printf "Fin de tests create i-tree.\n\n\n";;

let test_rot_cut = "(i-tr (rot 2)"^test_cut^")";;

(** Tests for getting the paths point of a tree, (it prints the input and the output of the ManipulateVg.get_paths function). *)
let test_get_points_i_tree () =
  Printf.printf "Tests get points i-tree:\n\n\n";
  Printf.printf "Test rot_cut input:\n%s\n\n" test_rot_cut;
  Compare.ManipulateVg.print_list_paths (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_rot_cut));
  Printf.printf "Test super hard input:\n%s\n\n" test_super_hard;
  Compare.ManipulateVg.print_list_paths (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_super_hard));
  Printf.printf "Fin de tests get points i-tree.\n\n\n";;


(** Tests for comparing tuples. *)
let test_equal_tuples () = 
  Printf.printf "Tests equal tuples:\n\n";
  let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
    let t1 = (1.,2.) in
    let t2 = (2.,1.) in
    let t3 = (1.0001,2.) in
    let t4 = (1.,1.9999) in
    let t5 = (1.0000001,2.) in
    let t6 = (1.,1.999999) in
    let t7 = (1.563789,0.235) in
    let t8 = (1.563788,0.235) in
    begin
      Printf.printf "Assert %s %s\n" (tuple_to_string t1) (tuple_to_string t1);
      (assert ((Compare.ManipulateVg.equal_float_tuple t1 t1) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t1) (tuple_to_string t2);
      (assert ((Compare.ManipulateVg.equal_float_tuple t1 t2) == false));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t2) (tuple_to_string t1);
      (assert ((Compare.ManipulateVg.equal_float_tuple t2 t1) == false));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t1) (tuple_to_string t1);
      (assert ((Compare.ManipulateVg.equal_float_tuple t1 t3) == false));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t3) (tuple_to_string t1);
      (assert ((Compare.ManipulateVg.equal_float_tuple t3 t1) == false));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t1) (tuple_to_string t4);
      (assert ((Compare.ManipulateVg.equal_float_tuple t1 t4) == false));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t4) (tuple_to_string t1);
      (assert ((Compare.ManipulateVg.equal_float_tuple t4 t1) == false));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t1) (tuple_to_string t5);
      (assert ((Compare.ManipulateVg.equal_float_tuple t1 t5) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t5) (tuple_to_string t1);
      (assert ((Compare.ManipulateVg.equal_float_tuple t5 t1) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t1) (tuple_to_string t6);
      (assert ((Compare.ManipulateVg.equal_float_tuple t1 t6) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t6) (tuple_to_string t1);
      (assert ((Compare.ManipulateVg.equal_float_tuple t6 t1) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t7) (tuple_to_string t8);
      (assert ((Compare.ManipulateVg.equal_float_tuple t7 t8) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert %s %s\n" (tuple_to_string t8) (tuple_to_string t7);
      (assert ((Compare.ManipulateVg.equal_float_tuple t8 t7) == true));
      Printf.printf "Done\n";
    end;
    Printf.printf "Fin de tests equal tuples.\n\n\n";;

(** Tests tuple exists in list. *)
let test_list_mem_bis () =
  Printf.printf "Tests list mem bis:\n\n";
  let print_list_tuple l = 
    Printf.printf "paths: [";
    let rec aux l = match l with
      | [] -> Printf.printf "]\n"
      | (x,y)::[] -> Printf.printf "(%f,%f)]" x y; (aux [])
      | (x,y)::t -> Printf.printf "(%f,%f);" x y; (aux t)
    in (aux l)
  in
  let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
    let t = (1.563789,0.235) in
    let t_string = (tuple_to_string t) in
    let l1 = [] in
    let l2 = [(1.563789,0.235000)] in
    let l3 = [(0.3,2.34);(0.5,0.3281)] in
    let l4 = [(0.454,0.233);(1.563788,0.235);(0.5,0.3281)] in
      begin
        Printf.printf "Assert t:%s, l:" t_string;
        print_list_tuple l1;
        (assert ((Compare.ManipulateVg.list_mem_bis t l1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert t:%s, l:" t_string; 
        print_list_tuple l2;
        (assert ((Compare.ManipulateVg.list_mem_bis t l2) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert t:%s, l:" t_string; 
        print_list_tuple l3;
        (assert ((Compare.ManipulateVg.list_mem_bis t l3) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert t:%s, l:" t_string; 
        print_list_tuple l4;
        (assert ((Compare.ManipulateVg.list_mem_bis t l4) == true));
        Printf.printf "Done\n";
      end;
    Printf.printf "Fin de tests list mem bis.\n\n\n";;


let main () =
  test_create_i_tree();
  test_get_points_i_tree();
  test_equal_tuples();
  test_list_mem_bis();;


let () = main();;