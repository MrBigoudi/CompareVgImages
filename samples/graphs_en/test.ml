let check_color = true;;

let q1 () = 
  Assume.compatible "draw_basis" [%ty : unit -> Vg.image];
  Check.name1 "draw_basis" [%ty : unit -> Vg.image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (unit))]
    [];;

let q2 () =
  Assume.compatible "graph_f_int" [%ty : (int -> int) -> (int*int) -> float -> float -> Vg.path ];
  let module Code = struct
    let graph_f_int = Get.value "graph_f_int" [%ty : (int -> int) -> (int*int) -> float -> float -> Vg.path ]
  end in
  let f0 n = n in
  let f1 n = n+1 in
  let f2 n = 2*n in
  let f3 n = n*n in
  let f4 n = 1 in
  Check.expr4 
    [%code (fun f bounds x y -> let i = I.const (Color.red) |> I.cut (Code.graph_f_int f bounds x y) 
                            in (I.blend i (Solution.draw_basis())))]
    [%ty : (int -> int) -> (int*int) -> float -> float -> Vg.image ]
      ~equal: (Compare.image_equal ~check_color)
      ~testers: [ Autotest.(tester (tuple4 (oneof [f0;f1;f2;f3;f4]) (tuple2 (int 0 10) (int 10 100)) (float 0 1) (float 0 1))) ]
      [(f0,(-10,10),0.1,0.1)];;

let q3 () =
  Assume.compatible "graph_f_int_hist" [%ty : (int -> int) -> (int*int) -> float -> float -> float -> Vg.path ];
  let module Code = struct
    let graph_f_int_hist = Get.value "graph_f_int_hist" [%ty : (int -> int) -> (int*int) -> float -> float -> float -> Vg.path ]
  end in
  let f0 n = n in
  let f1 n = n+1 in
  let f2 n = 2*n in
  let f3 n = n*n in
  let f4 n = 1 in
  Check.expr5 
    [%code (fun f bounds x y w -> let i = I.const (Color.red) |> I.cut (Code.graph_f_int_hist f bounds x y w) 
                            in (I.blend i (Solution.draw_basis())))]
    [%ty : (int -> int) -> (int*int) -> float -> float -> float -> Vg.image ]
      ~equal: (Compare.image_equal ~check_color)
      ~testers: [ Autotest.(tester (tuple5 (oneof [f0;f1;f2;f3;f4]) (tuple2 (int 0 10) (int 10 100)) (float 0 1) (float 0 1) (float 0 1))) ]
      [(f0,(-10,10),0.1,0.1,0.05)];;


(** set result *)
let () =
  Result.set (Result.questions [q1;q2;q3]);;