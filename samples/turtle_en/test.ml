let q1 () =
  Assume.compatible "make_turtle" [%ty : float -> float -> turtle ];
  Check.name2 "make_turtle" [%ty : float -> float -> turtle ] 
    ~testers: [ Autotest.(tester (tuple2 (float 0 1) (float 0 1))) ]
    [(0.,0.);(0.,1.);(1.,0.);(1.,1.)];
  let module Code = struct 
    let make_turtle = Get.value "make_turtle" [%ty : float -> float -> turtle ]
  end in
  Check.expr2
      [%code fun x y -> (draw ((Code.make_turtle x y).path))]
      [%ty : float -> float -> Vg.image]
      ~equal: (Compare.image_equal)
      ~testers: [ Autotest.(tester (tuple2 (float 0 1) (float 0 1))) ]
      [(0.,0.);(0.,1.);(1.,0.);(1.,1.)];;


let turtle_1 = {x=0.; y=0.; angle=45.; path = Vg.P.empty};;
let turtle_2 = {x=1.; y=1.; angle=90.; path = Vg.P.empty |> Vg.P.sub (Gg.P2.v 1. 0.) |> Vg.P.line (Gg.P2.v 0. 1.)};;
let turtle_3 = {x=0.; y=1.; angle=0. ; path = Vg.P.empty |> Vg.P.sub (Gg.P2.v 1. 0.) |> Vg.P.sub (Gg.P2.v 0. 1.)};;


let q2 () =
  Assume.compatible "forward" [%ty : float -> bool -> turtle -> turtle ];
  Check.name3 "forward" [%ty : float -> bool -> turtle -> turtle ]
    ~testers: [ Autotest.(tester (tuple3 (float 0 1) bool (oneof [turtle_1; turtle_2; turtle_3]))) ]
    [(1.,true,turtle_1);((-1.),false,turtle_2);(0.,false,turtle_3)];
  let module Code = struct 
    let forward = Get.value "forward" [%ty : float -> bool -> turtle -> turtle ]
  end in
  Check.expr3
      [%code fun x b t -> (draw ((Code.forward x b t).path))]
      [%ty : float -> bool -> turtle -> Vg.image ]
      ~equal: (Compare.image_equal)
      ~testers: [ Autotest.(tester (tuple3 (float 0 1) bool (oneof [turtle_1; turtle_2; turtle_3]))) ]
      [(1.,true,turtle_1);((-1.),false,turtle_2);(0.,false,turtle_3)];;

let command_1 = Line(0.5);;
let command_2 = Move(0.5);;
let command_3 = Turn(0.5);;
let command_4 = Repeat((3,[command_1;command_2]));;

let q3 () =
  Assume.compatible "run" [%ty : commands -> turtle -> turtle];
  Check.name2 "run" [%ty : commands -> turtle -> turtle]
    ~testers: [ Autotest.(tester (tuple2 (list ~length:(nat 50) (oneof [command_1; command_2; command_3; command_4])) (oneof [turtle_1; turtle_2; turtle_3]))) ]
    [ ([command_1;command_2;command_3;command_4],turtle_1);
      ([command_1;command_2;command_3;command_4],turtle_2);
      ([command_1;command_2;command_3;command_4],turtle_3) ];
  let module Code = struct 
    let run = Get.value "run" [%ty : commands -> turtle -> turtle]
  end in
  Check.expr2
      [%code fun c t -> (draw ((Code.run c t).path))]
      [%ty : commands -> turtle -> Vg.image ]
      ~equal: (Compare.image_equal)
      ~testers: [ Autotest.(tester (tuple2 (list ~length:(nat 50) (oneof [command_1; command_2; command_3; command_4])) (oneof [turtle_1; turtle_2; turtle_3]))) ]
      [ ([command_1;command_2;command_3;command_4],turtle_1);
        ([command_1;command_2;command_3;command_4],turtle_2);
        ([command_1;command_2;command_3;command_4],turtle_3) ];;

let q4 () =
  Assume.compatible "triangle" [%ty : float -> commands ];
  Check.name1 "triangle" [%ty : float -> commands ]
    ~testers: [ Autotest.(tester (float 0 1)) ]
    [0.;1.;0.8;0.5];
  let module Code = struct 
    let run = Get.value "run" [%ty : commands -> turtle -> turtle]
    let triangle = Get.value "triangle" [%ty : float -> commands ]
  end in
  Check.expr2
    [%code fun f t -> (draw ((Code.run (Code.triangle f) t).path))]
    [%ty : float -> turtle -> Vg.image ]
    ~equal: (Compare.image_equal)
    ~testers: [ Autotest.(tester (tuple2 (float 0 1) (oneof [turtle_1; turtle_2; turtle_3]))) ]
    [(0.,turtle_1);(0.25,turtle_2);(0.5,turtle_3);(0.75,turtle_1);(1.,turtle_2)];; 


let q5 () =
  Assume.compatible "square" [%ty : float -> commands ];
  Check.name1 "square" [%ty : float -> commands ]
    ~testers: [ Autotest.(tester (float 0 1)) ]
    [0.;1.;0.8;0.5];
  Assume.compatible "polygon" [%ty : int -> float -> commands ];
  Check.name2 "polygon" [%ty : int -> float -> commands ]
    ~testers: [ Autotest.(tester (tuple2 (int 1 100) (float 0 1))) ]
    [(2,0.);(3,1.);(47,1.);(7,0.5);(42,0.5)];
  let module Code = struct 
    let run = Get.value "run" [%ty : commands -> turtle -> turtle ]
    let square = Get.value "square" [%ty : float -> commands ]
    let polygon = Get.value "polygon" [%ty : int -> float -> commands ]
  end in
  Check.expr2
    [%code fun f t -> (draw ((Code.run (Code.square f) t).path))]
    [%ty : float -> turtle -> Vg.image ]
    ~equal: (Compare.image_equal)
    ~testers: [ Autotest.(tester (tuple2 (float 0 1) (oneof [turtle_1; turtle_2; turtle_3]))) ]
    [(0.,turtle_1);(1.,turtle_2);(1.,turtle_3);(0.5,turtle_1);(0.5,turtle_2)];
  Check.expr3
    [%code fun i f t -> (draw ((Code.run (Code.square f) t).path))]
    [%ty : int -> float -> turtle -> Vg.image ]
    ~equal: (Compare.image_equal)
    ~testers: [ Autotest.(tester (tuple3 (int 1 100) (float 0 1) (oneof [turtle_1; turtle_2; turtle_3]))) ]
    [(1,0.,turtle_1);(2,1.,turtle_2);(3,1.,turtle_3);(4,0.5,turtle_1);(5,0.5,turtle_2)];;


let q6 () =
  Assume.compatible "spiral" [%ty : float -> float -> float -> int -> commands ];
  Check.name4 "spiral" [%ty : float -> float -> float -> int -> commands ]
    ~testers: [ Autotest.(tester (tuple4 (float 0 1) (float 0 1) (float 0 360) (int 1 1000))) ]
    [(0.1,0.95,10.,100)];
  let module Code = struct 
    let run = Get.value "run" [%ty : commands -> turtle -> turtle ]
    let spiral = Get.value "spiral" [%ty : float -> float -> float -> int -> commands ]
  end in
  Check.expr5
    [%code fun s f a n t -> (draw ((Code.run (Code.spiral s f a n) t).path))]
    [%ty : float -> float -> float -> int -> turtle -> Vg.image ]
    ~equal: (Compare.image_equal)
    ~testers: [ Autotest.(tester (tuple5 (float 0 1) (float 0 1) (float 0 360) (int 1 1000) (oneof [turtle_1; turtle_2; turtle_3]))) ]
    [(0.1,0.95,10.,100,turtle_3)];;



(** set result *)
let () =
  Result.set (Result.questions [q1;q2;q3;q4;q5;q6])