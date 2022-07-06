open Test_lib
open Report

let mkturtle x y a = { x;y;angle=a; path = Path.empty |> Path.moveto x y }

let sample_float () : float = Float.of_int (Random.int 100) /. 100.

let sample_turtle () : turtle =
  mkturtle (sample_float ()) (sample_float ()) (Float.of_int (Random.int 360))

let epsilon = 1e-8
let eq_float x y = Float.abs (x-.y) < epsilon

let eq_path = Vg.P.equal_f eq_float

let eq_turtle t1 t2 =
  eq_float t1.x t2.x &&
  eq_float t1.y t2.y &&
  eq_float t1.angle t2.angle &&
  eq_path t1.path t2.path

(* Pour cette question, on compare les commands syntaxiquement
   (à part les float qu'on compare à epsilon près) *)

let rec eq_commands l1 l2 =
  match l1,l2 with
  | [],[] -> true
  | Line d1::l1', Line d2::l2' -> eq_float d1 d2 && eq_commands l1' l2'
  | Move d1::l1', Move d2::l2' -> eq_float d1 d2 && eq_commands l1' l2'
  | Turn a1::l1', Turn a2::l2' -> eq_float a1 a2 && eq_commands l1' l2'
  | Repeat (n1,cmds1)::l1', Repeat (n2,cmds2)::l2' ->
     n1=n2 && eq_commands cmds1 cmds2 && eq_commands l1' l2'
  | _ -> false

let question1 =
  let f = "make_turtle" in
  set_progress ("Grading function "^f);
  Section
    ([Text "Question 1 : "; Code f ],
     test_function_2_against_solution
       [%ty: float -> float -> turtle] f
       ~gen:3
       ~test:(test_eq_ok eq_turtle)
       [])

let question2 =
  let f = "forward" in
  set_progress ("Grading function "^f);
  Section
    ([Text "Question 2 : "; Code f ],
     test_function_3_against_solution
       [%ty: float -> bool -> turtle -> turtle] f
       ~gen:10
       ~test:(test_eq_ok eq_turtle)
       [])

let question3 =
  let f = "run" in
  set_progress ("Grading function "^f);
  Section
    ([Text "Question 3 : "; Code f ],
     test_function_2_against_solution
       [%ty: commands -> turtle -> turtle] f
       ~gen:0
       ~test:(test_eq_ok eq_turtle)
       (let tu = mkturtle 0.5 0.5 90. in
        [([],tu);
         ([Line 0.3],tu);
         ([Move 0.3],tu);
         ([Turn 45.; Line 0.3; Turn (-45.); Move 0.3], tu);
         ([Repeat (5,[Line 0.3; Turn 90.])], tu);
         ([Repeat (5,[Line 0.3; Repeat (4,[Line 0.1;Turn 45.]); Turn 90.])], tu)]))

let question4 =
  let f = "triangle" in
  set_progress ("Grading function "^f);
  Section
    ([Text "Question 4 : "; Code f ],
     test_function_1_against_solution
       [%ty: float -> commands] f
       ~gen:3
       ~test:(test_eq_ok eq_commands)
       [])

let question5 =
  let f = "square" in
  set_progress ("Grading function "^f);
  Section
    ([Text "Question 5 : "; Code f ],
     test_function_1_against_solution
       [%ty: float -> commands] f
       ~gen:3
       ~test:(test_eq_ok eq_commands)
       [])

let question5bis =
  let f = "polygon" in
  set_progress ("Grading function "^f);
  Section
    ([Text "Question 5 : "; Code f ],
     test_function_2_against_solution
       [%ty: int -> float -> commands] f
       ~gen:0
       ~test:(test_eq_ok eq_commands)
       [(4,0.1);
        (7,0.1);
        (10,0.1)])

let question6 =
  let f = "spiral" in
  set_progress ("Grading function "^f);
  Section
    ([Text "Question 6 : "; Code f ],
     test_function_4_against_solution
       [%ty: float -> float -> float -> int -> commands] f
       ~gen:0
       ~test:(test_eq_ok eq_commands)
       [(1.,0.7,90.,30);
        (0.1,0.95,10.,100)])

let () =
  set_result @@
  ast_sanity_check code_ast @@ fun () ->
  [ question1; question2; question3; question4;
    question5; question5bis; question6 ]
