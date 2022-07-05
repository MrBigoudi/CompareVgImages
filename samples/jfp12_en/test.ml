let allow_translations = true;;
let epsilon = 1e-3;;
(* let check_color = true;; *)

let q1 () =
  Assume.compatible "get_n_termes_T" [%ty : int -> int -> int list];
  Check.name2 "get_n_termes_T" [%ty : int -> int -> int list]
    ~testers: [ Autotest.(tester (tuple2 (nat 1000000) (nat 100))) ]
    [(231,20);(0,20);(231,0);(3453,24)];;

let q2 () =
  Assume.compatible "gen_matrix" [%ty : (int * int * int * int) list -> int array array];
  Check.name1 "gen_matrix" [%ty : (int * int * int * int) list -> int array array]
    ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple4 (int 1 7) (nat 23) (nat 11) (nat 3))))]
    [[(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)]];;


let q2_5 () =
  Assume.compatible "draw_tetris" [%ty : int array array -> Vg.image];
  let gen_matrix = Get.value "gen_matrix" [%ty : (int * int * int * int) list -> int array array] in
  let draw_tetris = Get.value "draw_tetris" [%ty : int array array -> Vg.image] in
  Check.expr1 
      [%code (fun list -> draw_tetris@@gen_matrix@@list)]
      [%ty: (int * int * int * int) list -> Vg.image] 
      ~equal: (Compare.image_equal ~epsilon ~allow_translations)
      ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple4 (int 1 7) (nat 23) (nat 11) (nat 3)))) ]
      [[(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)]];;

let q3 () =
  (* Test draw *)
  let gen_matrix_gravity = Get.value "gen_matrix_gravity" [%ty : (int * int * int) list -> int array array] in
  let draw_tetris = Get.value "draw_tetris" [%ty : int array array -> Vg.image] in
  Check.expr1 
      [%code fun list -> draw_tetris@@gen_matrix_gravity@@list ]
      [%ty: (int * int * int) list -> Vg.image] 
      ~equal: (Compare.image_equal ~epsilon ~allow_translations)
      ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple3 (int 1 7) (nat 11) (nat 3))))]
      [[(1,0,0);(2,1,0);(3,2,0);(4,3,0);(5,4,0);(6,5,0);(7,6,0);(1,7,0);(2,8,0);(3,9,0)]];;


(** set result *)
let () =
  Result.set (Result.questions [q1;q2;q2_5;q3])