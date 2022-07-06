let allow_translations = true;;
let epsilon = 1e-3;;
(* let check_color = true;; *)

let q1 () =
  Assume.compatible "get_n_termes_T" [%ty : int -> int -> int list];
  Check.name2 "get_n_termes_T" [%ty : int -> int -> int list]
    ~testers: [ Autotest.(tester (tuple2 (nat 1000000) (nat 100))) ]
    [(231,20);(0,20);(231,0);(3453,24)];;

let q2 () =
  Assume.compatible "gen_matrice" [%ty : (int * int * int * int) list -> int array array];
  Check.name1 "gen_matrice" [%ty : (int * int * int * int) list -> int array array]
    ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple4 (int 1 7) (nat 23) (nat 11) (nat 3))))]
    [[(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)]];;

let q2_5 () =
  Assume.compatible "draw_tetris" [%ty : int array array -> Vg.image];
  let module Code = struct 
    let gen_matrice = Get.value "gen_matrice" [%ty : (int * int * int * int) list -> int array array]
    let draw_tetris = Get.value "draw_tetris" [%ty : int array array -> Vg.image]
  end in
  Check.expr1 
      [%code (fun list -> Code.draw_tetris@@Code.gen_matrice@@list)]
      [%ty: (int * int * int * int) list -> Vg.image] 
      ~equal: (Compare.image_equal ~epsilon ~allow_translations)
      ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple4 (int 1 7) (nat 23) (nat 11) (nat 3)))) ]
      [[(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)]];
  Check.name1 "gen_matrice" [%ty : (int * int * int * int) list -> int array array]
    ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple4 (int 1 7) (nat 23) (nat 11) (nat 3))))]
    [[(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)]];;


let q3 () =
  (* Test generation matrice *)
  Assume.compatible "gen_matrice_gravity" [%ty : (int * int * int) list -> int array array];
  Check.name1 "gen_matrice_gravity" [%ty : (int * int * int) list -> int array array]
      ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple3 (int 1 7) (nat 11) (nat 3))))]
      [[(1,0,0);(2,1,0);(3,2,0);(4,3,0);(5,4,0);(6,5,0);(7,6,0);(1,7,0);(2,8,0);(3,9,0)]];
  (* Test affichage *)
  let module Code = struct 
    let gen_matrice_gravity = Get.value "gen_matrice_gravity" [%ty : (int * int * int) list -> int array array]
    let draw_tetris = Get.value "draw_tetris" [%ty : int array array -> Vg.image]
  end in
  Check.expr1 
      [%code fun list -> Code.draw_tetris@@Code.gen_matrice_gravity@@list ]
      [%ty: (int * int * int) list -> Vg.image] 
      ~equal: (Compare.image_equal ~epsilon ~allow_translations)
      ~testers: [ Autotest.(tester (list ~length:(nat 100) (tuple3 (int 1 7) (nat 11) (nat 3))))]
      [[(1,0,0);(2,1,0);(3,2,0);(4,3,0);(5,4,0);(6,5,0);(7,6,0);(1,7,0);(2,8,0);(3,9,0)]];;


let l = [(1,8,2);(3,7,0);(5,4,2);(3,1,2);(4,1,2);(4,10,3);(7,8,3);(7,6,3);(5,3,2);(2,0,3);(1,8,2);
(6,4,0);(1,0,2);(3,7,0);(5,0,2);(7,10,3);(4,5,2);(6,3,0);(3,9,0);(6,1,1);(6,7,1);(1,3,2);(1,4,2);
(5,0,3);(6,9,2);(4,2,3);(5,7,2);(2,0,3);(3,10,1);(3,5,1);(4,3,3);(6,8,0);(6,0,2);(7,6,3);(3,4,1);
(3,0,0);(2,9,0);(4,9,2);(6,2,0);(6,7,1);(7,5,3);(4,0,2);(7,3,3);(3,9,0);(3,0,0);(1,5,2);(1,8,2);
(6,6,1);(4,4,2);(4,2,2);(2,9,2);(1,5,2);(2,1,3);(7,10,3);(3,4,0);(7,8,3);(6,2,1);(6,0,3);(4,6,3);
(2,9,0);(5,3,2);(6,1,1);(6,7,0);(2,3,0);(2,9,0);(7,0,3);(4,7,2);(6,1,0);(2,4,0);(3,0,0);(7,10,3);
(3,7,0);(6,4,2);(1,1,2);(4,9,2);(3,6,0);(1,2,2);(6,0,3);(2,7,2);(7,5,3);(5,2,2);(5,9,2);(7,0,3);
(3,4,0);(7,7,3);(1,3,2);(4,10,3)];;

let q4 () =
  Assume.compatible "calcul_score" [%ty : int -> (int * int * int) list -> (int array array*int)];
  let module Code = struct 
    let calcul_score = Get.value "calcul_score" [%ty : int -> (int * int * int) list -> (int array array*int)]
    let draw_tetris = Get.value "draw_tetris" [%ty : int array array -> Vg.image]
  end in
  Check.name2 "calcul_score" [%ty : int -> (int * int * int) list -> (int array array*int)]
      ~testers: [ Autotest.(tester (tuple2 (nat 1000) (list ~length:(nat 50) (tuple3 (int 1 7) (nat 11) (nat 3)))))]
      [(231,l)];
  (* Test draw *)
  let get_generated_matrix x = match x with (mat,_) -> mat in
  Check.expr2 
      [%code fun s list -> (Code.draw_tetris (get_generated_matrix (Code.calcul_score s list))) ]
      [%ty : int -> (int * int * int) list -> Vg.image]
      ~equal: (Compare.image_equal ~epsilon ~allow_translations)
      ~testers: [ Autotest.(tester (tuple2 (nat 1000) (list ~length:(nat 50) (tuple3 (int 1 7) (nat 11) (nat 3)))))]
      [(231,l)];;


let q5 () =
  Assume.compatible "gen_list" [%ty : int -> (int*int*int) list];
  Check.name1 "gen_list" [%ty : int -> (int*int*int) list]
    ~equal: (fun s1 s2 -> s1!=[] && s2!=[])
    ~testers: [ Autotest.(tester (nat 1000))]
    [231;0;1];
  let module Code = struct 
    let gen_list = Get.value "gen_list" [%ty : int -> (int*int*int) list]
    let calcul_score = Get.value "calcul_score" [%ty : int -> (int * int * int) list -> (int array array*int)]
  end in
  let get_score s = 
    let (_,score) = (Code.calcul_score s (Code.gen_list s)) in score 
  in
  Check.expr1 
    [%code get_score ]
    [%ty : int -> int ]
    ~equal: (fun s1 s2 -> (s1>=s2))
    ~testers: [ Autotest.(tester (nat 1000))]
    [231;0;1];;

(** set result *)
let () =
  Result.set (Result.questions [q1;q2;q2_5;q3;q4;q5]);;