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

(** set result *)
let () =
  Result.set (Result.questions [q1;q2])