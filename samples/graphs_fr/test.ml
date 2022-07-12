let check_color = true;;

let q1 () = 
  Assume.compatible "draw_basis" [%ty : unit -> Vg.image];
  Check.name1 "draw_basis" [%ty : unit -> Vg.image]
    ~equal: (Compare.image_equal ~check_color)
    ~testers: [ Autotest.(tester (unit))]
    [];;


let q2 () =
  Assume.compatible "graph_f_int" [%ty : (int -> int) -> (int*int) -> (float*float) -> Vg.path ];
  let module Code = struct
    let graph_f_int = Get.value "graph_f_int" [%ty : (int -> int) -> (int*int) -> (float*float) -> Vg.path ]
  end in
  let f0 n = n in
  let f1 n = n+1 in
  let f2 n = 2*n in
  let f3 n = n*n in
  let f4 n = 1 in
  Check.expr3 
    [%code (fun f bounds scale -> let i = I.const (Color.red) |> I.cut (Code.graph_f_int f bounds scale) 
                            in (I.blend i (Solution.draw_basis())))]
    [%ty : (int -> int) -> (int*int) -> (float*float) -> Vg.image ]
      ~equal: (Compare.image_equal ~check_color)
      ~testers: [ Autotest.(tester (tuple3 (oneof [f0;f1;f2;f3;f4]) (tuple2 (int 0 10) (int 10 100)) (tuple2 (float 0 1) (float 0 1)))) ]
      [(f0,(-10,10),(0.1,0.1))];;


let q3 () =
  Assume.compatible "graph_f_int_hist" [%ty : (int -> int) -> (int*int) -> (float*float) -> float -> Vg.path ];
  let module Code = struct
    let graph_f_int_hist = Get.value "graph_f_int_hist" [%ty : (int -> int) -> (int*int) -> (float*float) -> float -> Vg.path ]
  end in
  let f0 n = n in
  let f1 n = n+1 in
  let f2 n = 2*n in
  let f3 n = n*n in
  let f4 n = 1 in
  Check.expr4 
    [%code (fun f bounds scale w -> let i = I.const (Color.red) |> I.cut (Code.graph_f_int_hist f bounds scale w) 
                            in (I.blend i (Solution.draw_basis())))]
    [%ty : (int -> int) -> (int*int) -> (float*float) -> float -> Vg.image ]
      ~equal: (Compare.image_equal ~check_color)
      ~testers: [ Autotest.(tester (tuple4 (oneof [f0;f1;f2;f3;f4]) (tuple2 (int 0 10) (int 10 100)) (tuple2 (float 0 1) (float 0 1)) (float 0 1))) ]
      [(f0,(-10,10),(0.1,0.1),0.05)];;


let q4 () =
  Assume.compatible "graph_f_float" [%ty : (float -> float) -> (float*float) -> (float*float) -> float -> Vg.path ];
  let module Code = struct
    let graph_f_float = Get.value "graph_f_float" [%ty : (float -> float) -> (float*float) -> (float*float) -> float -> Vg.path ]
  end in
  let f0 x = x in
  let f1 x = sqrt x in
  let f2 x = 1./.x in
  let f3 x = x*.x in
  let f4 x = 1. in
  Check.expr4 
    [%code (fun f bounds scale space -> let i = I.const (Color.red) |> I.cut (Code.graph_f_float f bounds scale space) 
                            in (I.blend i (Solution.draw_basis())))]
    [%ty : (float -> float) -> (float*float) -> (float*float) -> float -> Vg.image ]
      ~equal: (Compare.image_equal ~check_color)
      ~testers: [ Autotest.(tester (tuple4 (oneof [f0;f1;f2;f3;f4]) (tuple2 (float 0 10) (float 10 100)) (tuple2 (float 0 1) (float 0 1)) (float 0 1))) ]
      [(f1,(-10.,10.),(0.1,0.1),0.001)];;


let q5 () =
  Assume.compatible "graph_integral" [%ty : (float -> float) -> (float*float) -> (float*float) -> float -> float -> Vg.path ];
  let module Code = struct
    let graph_integral = Get.value "graph_integral" [%ty : (float -> float) -> (float*float) -> (float*float) -> float -> float -> Vg.path ]
  end in
  let f0 x = x in
  let f1 x = sqrt x in
  let f2 x = 1./.x in
  let f3 x = x*.x in
  let f4 x = 1. in
  Check.expr5 
    [%code (fun f bounds scale space width -> let i = I.const (Color.red) |> I.cut (Code.graph_integral f bounds scale space width) 
                            in (I.blend i (Solution.draw_basis())))]
    [%ty : (float -> float) -> (float*float) -> (float*float) -> float -> float -> Vg.image ]
      ~equal: (Compare.image_equal ~check_color)
      ~testers: [ Autotest.(tester (tuple5 (oneof [f0;f1;f2;f3;f4]) (tuple2 (float 0 10) (float 10 100)) (tuple2 (float 0 1) (float 0 1)) (float 0 1) (float 0 1))) ]
      [(f1,(-10.,10.),(0.1,0.1),0.001,0.001)];;

(** set result *)
let () =
  Result.set (Result.questions [q1;q2;q3;q4;q5]);;