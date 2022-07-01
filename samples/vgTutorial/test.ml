let q1 () =
  Assume.compatible "create_color" [%ty : float -> float -> float -> float -> color];
  Check.name4 "create_color" [%ty : float -> float -> float -> float -> color]  
    ~testers: [ Autotest.(tester (tuple4 (float 0 1) (float 0 1) (float 0 1) (float 0 1))) ]
    [0.,0.,0.,0.;1.,1.,1.,1.];;

let red = Solution.create_color 1.0 0.0 0.0 1.0;;
let green = Solution.create_color 0.0 1.0 0.0 1.0;;
let blue = Solution.create_color 0.0 0.0 1.0 1.0;;

let epsilon = 1e-3;;


let q2 () = 
  Assume.compatible "create_circle" [%ty : float -> float -> color -> float -> image];
  Check.name4 "create_circle" [%ty : float -> float -> color -> float -> image]
    ~equal: (Compare.image_equal ~epsilon)
    ~testers: [ Autotest.(tester (tuple4 (float 0 1) (float 0 1) (oneof [red; green; blue]) (float 0 1)))]
    [];;

let q3 () =
  Assume.compatible "create_dot_square" [%ty : float -> float -> float -> color -> float -> image];
  Check.name5 "create_dot_square" [%ty : float -> float -> float -> color -> float -> image]
    ~equal: Compare.image_equal
    ~testers: [ Autotest.(tester (tuple5 (float 0 1) (float 0 1) (float 0 1) (oneof [red; green; blue]) (float 0 1)))]
    [];;

let q4 () =
  Assume.compatible "create_square_with_outline" [%ty : float -> float -> float -> color -> float -> image];
  Check.name5 "create_square_with_outline" [%ty : float -> float -> float -> color -> float -> image]
    ~equal: Compare.image_equal
    ~testers: [ Autotest.(tester (tuple5 (float 0 1) (float 0 1) (float 0 1) (oneof [red; green; blue]) (float 0 1)))]
    [];;

let check_color = true;;

let q5 () =
  Assume.compatible "create_block_j" [%ty : float -> float -> float -> image];
  Assume.compatible "create_block_l" [%ty : float -> float -> float -> image];
  Assume.compatible "create_block_o" [%ty : float -> float -> float -> image];
  Assume.compatible "create_block_s" [%ty : float -> float -> float -> image];
  Assume.compatible "create_block_t" [%ty : float -> float -> float -> image];
  Assume.compatible "create_block_z" [%ty : float -> float -> float -> image];
  Assume.compatible "create_block_i" [%ty : float -> float -> float -> image];
  Check.name3 "create_block_j" [%ty : float -> float -> float -> image]
    ~equal: (Compare.image_equal ~epsilon ~check_color)
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) (float 0 1) (float 0 1)))]
    [];
  Check.name3 "create_block_l" [%ty : float -> float -> float -> image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) (float 0 1) (float 0 1)))]
    [];
  Check.name3 "create_block_o" [%ty : float -> float -> float -> image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) (float 0 1) (float 0 1)))]
    [];
  Check.name3 "create_block_s" [%ty : float -> float -> float -> image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) (float 0 1) (float 0 1)))]
    [];
  Check.name3 "create_block_t" [%ty : float -> float -> float -> image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) (float 0 1) (float 0 1)))]
    [];
  Check.name3 "create_block_z" [%ty : float -> float -> float -> image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) (float 0 1) (float 0 1)))]
    [];
  Check.name3 "create_block_i" [%ty : float -> float -> float -> image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) (float 0 1) (float 0 1)))]
    [];;

let block_j = Solution.create_block_j 0.1 0.1 0.1;;
let block_l = Solution.create_block_l 0.1 0.1 0.1;;
let block_o = Solution.create_block_o 0.1 0.1 0.1;;
let block_s = Solution.create_block_s 0.1 0.1 0.1;;
let block_t = Solution.create_block_t 0.1 0.1 0.1;;
let block_z = Solution.create_block_z 0.1 0.1 0.1;;
let block_i = Solution.create_block_i 0.1 0.1 0.1;;

let q6 () =
  Assume.compatible "rotate_45_deg" [%ty : image -> int -> image];
  Check.name2 "rotate_45_deg" [%ty : image -> int -> image]
    ~equal: Compare.image_equal
    ~testers: [ Autotest.(tester (tuple2 
                (oneof [block_j;block_l;block_o;block_s;block_t;block_z;block_i])
                (nat 100))) ]
    [];;

(** set result *)
let () =
  Result.set (Result.questions [q1;q2;q3;q4;q5;q6])