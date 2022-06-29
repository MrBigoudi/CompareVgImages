open Vg;;
open Gg;;


(** Tests index to the next space. *)
let test_next_space () =
  Printf.printf "Tests next space:\n\n";
  let s1 = " " in
  let s2 = " this is a test " in
  let s3 = "throwException" in
  let offset = 0 in
    begin
      Printf.printf "Assert s: '%s', offset: %d\n" s1 offset;
      let offset = (Compare.ManipulateVg.next_space s1 offset) in
        (assert ( offset == 0));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
        let offset = (Compare.ManipulateVg.next_space s2 offset)+1 in
          (assert ( offset-1 == 0));
          Printf.printf "Done\n";
          Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
          let offset = (Compare.ManipulateVg.next_space s2 offset)+1 in
            (assert ( offset-1 == 5));
            Printf.printf "Done\n";
            Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
            let offset = (Compare.ManipulateVg.next_space s2 offset)+1 in
              (assert ( offset-1 == 8));
              Printf.printf "Done\n";
              Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
              let offset = (Compare.ManipulateVg.next_space s2 offset)+1 in
                (assert ( offset-1 == 10));
                Printf.printf "Done\n";
                Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
                let offset = (Compare.ManipulateVg.next_space s2 offset) in
                  (assert ( offset == 15));
                  Printf.printf "Done\n";
                  let offset = 0 in
                  Printf.printf "Assert s: '%s', offset: %d\n" s3 offset;
                  try 
                    begin 
                      Printf.printf "Error: (Compare.ManipulateVg.next_space %s %d) = %d\n" s3 offset (Compare.ManipulateVg.next_space s3 offset); 
                      assert false;
                    end
                  with 
                    Not_found -> assert true; 
                    Printf.printf "Done\n";
                    let offset = (String.length s2) in
                      Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
                      try 
                        begin 
                          Printf.printf "Error: (Compare.ManipulateVg.next_space %s %d) = %d\n" s2 offset (Compare.ManipulateVg.next_space s2 offset); 
                          assert false;
                        end
                      with 
                        Not_found -> assert true; 
                        Printf.printf "Done\n";
                        let offset = -1 in
                        Printf.printf "Assert s: '%s', offset: %d\n" s3 offset;
                        try 
                          begin 
                            Printf.printf "Error: (Compare.ManipulateVg.next_space %s %d) = %d\n" s3 offset (Compare.ManipulateVg.next_space s3 offset); 
                            assert false;
                          end
                        with 
                          Invalid_argument(_) -> assert true; 
                          Printf.printf "Done\n";
    end;
    Printf.printf "End of tests next space.\n\n\n";;


(** Tests index to the next left parenthesis. *)
let test_next_left_p () =
  Printf.printf "Tests next left parenthesis:\n\n";
  let s1 = "(" in
  let s2 = "(this(is(a(test(" in
  let s3 = "throwException" in
  let offset = 0 in
    begin
      Printf.printf "Assert s: '%s', offset: %d\n" s1 offset;
      let offset = (Compare.ManipulateVg.next_left_p s1 offset) in
        (assert ( offset == 0));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
        let offset = (Compare.ManipulateVg.next_left_p s2 offset)+1 in
          (assert ( offset-1 == 0));
          Printf.printf "Done\n";
          Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
          let offset = (Compare.ManipulateVg.next_left_p s2 offset)+1 in
            (assert ( offset-1 == 5));
            Printf.printf "Done\n";
            Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
            let offset = (Compare.ManipulateVg.next_left_p s2 offset)+1 in
              (assert ( offset-1 == 8));
              Printf.printf "Done\n";
              Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
              let offset = (Compare.ManipulateVg.next_left_p s2 offset)+1 in
                (assert ( offset-1 == 10));
                Printf.printf "Done\n";
                Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
                let offset = (Compare.ManipulateVg.next_left_p s2 offset) in
                  (assert ( offset == 15));
                  Printf.printf "Done\n";
                  let offset = 0 in
                  Printf.printf "Assert s: '%s', offset: %d\n" s3 offset;
                  try 
                    begin 
                      Printf.printf "Error: (Compare.ManipulateVg.next_left_p %s %d) = %d\n" s3 offset (Compare.ManipulateVg.next_left_p s3 offset); 
                      assert false;
                    end
                  with 
                    Not_found -> assert true; 
                    Printf.printf "Done\n";
                    let offset = (String.length s2) in
                      Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
                      try 
                        begin 
                          Printf.printf "Error: (Compare.ManipulateVg.next_left_p %s %d) = %d\n" s2 offset (Compare.ManipulateVg.next_left_p s2 offset); 
                          assert false;
                        end
                      with 
                        Not_found -> assert true; 
                        Printf.printf "Done\n";
                        let offset = -1 in
                        Printf.printf "Assert s: '%s', offset: %d\n" s3 offset;
                        try 
                          begin 
                            Printf.printf "Error: (Compare.ManipulateVg.next_left_p %s %d) = %d\n" s3 offset (Compare.ManipulateVg.next_left_p s3 offset); 
                            assert false;
                          end
                        with 
                          Invalid_argument(_) -> assert true; 
                          Printf.printf "Done\n";
    end;
    Printf.printf "End of tests next left parenthesis.\n\n\n";;


(** Tests index to the next right parenthesis. *)
let test_next_right_p () =
  Printf.printf "Tests next right parenthesis:\n\n";
  let s1 = ")" in
  let s2 = ")this)is)a)test)" in
  let s3 = "throwException" in
  let offset = 0 in
    begin
      Printf.printf "Assert s: '%s', offset: %d\n" s1 offset;
      let offset = (Compare.ManipulateVg.next_right_p s1 offset) in
        (assert ( offset == 0));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
        let offset = (Compare.ManipulateVg.next_right_p s2 offset)+1 in
          (assert ( offset-1 == 0));
          Printf.printf "Done\n";
          Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
          let offset = (Compare.ManipulateVg.next_right_p s2 offset)+1 in
            (assert ( offset-1 == 5));
            Printf.printf "Done\n";
            Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
            let offset = (Compare.ManipulateVg.next_right_p s2 offset)+1 in
              (assert ( offset-1 == 8));
              Printf.printf "Done\n";
              Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
              let offset = (Compare.ManipulateVg.next_right_p s2 offset)+1 in
                (assert ( offset-1 == 10));
                Printf.printf "Done\n";
                Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
                let offset = (Compare.ManipulateVg.next_right_p s2 offset) in
                  (assert ( offset == 15));
                  Printf.printf "Done\n";
                  let offset = 0 in
                  Printf.printf "Assert s: '%s', offset: %d\n" s3 offset;
                  try 
                    begin 
                      Printf.printf "Error: (Compare.ManipulateVg.next_right_p %s %d) = %d\n" s3 offset (Compare.ManipulateVg.next_right_p s3 offset); 
                      assert false;
                    end
                  with 
                    Not_found -> assert true; 
                    Printf.printf "Done\n";
                    let offset = (String.length s2) in
                      Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
                      try 
                        begin 
                          Printf.printf "Error: (Compare.ManipulateVg.next_right_p %s %d) = %d\n" s2 offset (Compare.ManipulateVg.next_right_p s2 offset); 
                          assert false;
                        end
                      with 
                        Not_found -> assert true; 
                        Printf.printf "Done\n";
                        let offset = -1 in
                        Printf.printf "Assert s: '%s', offset: %d\n" s3 offset;
                        try 
                          begin 
                            Printf.printf "Error: (Compare.ManipulateVg.next_right_p %s %d) = %d\n" s3 offset (Compare.ManipulateVg.next_right_p s3 offset); 
                            assert false;
                          end
                        with 
                          Invalid_argument(_) -> assert true; 
                          Printf.printf "Done\n";
    end;
    Printf.printf "End of tests next right parenthesis.\n\n\n";;


(** Tests index of the next right i-token *)
let test_next_image_modif () =
  Printf.printf "Tests index of the next right i-token:\n\n";
  let s1 = "(i-tr (imove (1 0.5)) (i-const (1 0 0 1)))" in
  let s2 = "" in
  let offset = 0 in
    begin
      Printf.printf "Assert s: '%s', offset: %d\n" s1 offset;
      let offset = (Compare.ManipulateVg.next_image_modif s1 offset) in
        (assert ( offset == 3));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s', offset: %d\n" s1 offset;
        let offset = (Compare.ManipulateVg.next_image_modif s1 offset) in
          (assert ( offset == 25));
          Printf.printf "Done\n";
          Printf.printf "Assert s: '%s', offset: %d\n" s1 offset;
          try 
            begin 
              Printf.printf "Error: (Compare.ManipulateVg.next_image_modif %s %d) = %d\n" s1 offset (Compare.ManipulateVg.next_image_modif s1 offset); 
              assert false;
            end
          with 
            _ -> assert true; 
            Printf.printf "Done\n";
            let offset = 1 in
              Printf.printf "Assert s: '%s', offset: %d\n" s2 offset;
              try 
                begin 
                  Printf.printf "Error: (Compare.ManipulateVg.next_image_modif %s %d) = %d\n" s2 offset (Compare.ManipulateVg.next_image_modif s2 offset); 
                  assert false;
                end
              with 
                _ -> assert true; 
                Printf.printf "Done\n";
    end;
    Printf.printf "End of tests index of the next right i-token.\n\n\n";;


(** Tests to get a sub string. *)
let test_get_sub_string () =
  Printf.printf "Tests get sub-string:\n\n";
  let s1 = "need 'this' as a substring" in
  let s2 = "" in
  let s = 6 in
  let f = 10 in
    begin
      Printf.printf "Assert s: '%s', s: %d, f:%d\n" s1 s f;
      let sub = (Compare.ManipulateVg.get_sub_string s1 s f) in
        (assert (String.equal sub "this"));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s', s: %d, f:%d\n" s2 s f;
        try 
            begin 
              Printf.printf "Error: (Compare.ManipulateVg.get_sub_string %s %d %d) = %s\n" s2 s f (Compare.ManipulateVg.get_sub_string s1 s f); 
              assert false;
            end
          with 
            _ -> assert true; 
            Printf.printf "Done\n";
    end;
    Printf.printf "End of tests get sub-string.\n\n\n";;

  
(** Tests to get a tr_token. *)
let test_get_tr_token () =
  Printf.printf "Tests get tr-token:\n\n";
  let s0 = "(i-const (0 0 0 0))" in
  let s1 = "(i-tr (move (1 2))"^s0^")" in
  let s2 = "(i-tr (rot 3)"^s0^")" in
  let s3 = "(i-tr (scale (4 5))"^s0^")" in 
  let s4 = "unknown command" in
    begin
      Printf.printf "Assert s: '%s'\n" s1;
      let (Move(x,y), offset) = (Compare.ManipulateVg.get_tr_token s1 3) in
        (assert (Compare.ManipulateVg.equal_float_tuple (x,y) (1.,2.)));
        (assert (offset==21));
        Printf.printf "Done\n";
      Printf.printf "Assert s: '%s'\n" s2;
      let (Rot(x), offset) = (Compare.ManipulateVg.get_tr_token s2 3) in
        (assert (Compare.ManipulateVg.equal_float_tuple (x,0.) (3.,0.)));
        (assert (offset==16));
        Printf.printf "Done\n";
      Printf.printf "Assert s: '%s'\n" s3;
      let (Scale(x,y), offset) = (Compare.ManipulateVg.get_tr_token s3 3) in
        (assert (Compare.ManipulateVg.equal_float_tuple (x,y) (4.,5.)));
        (assert (offset==22));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s'\n" s4;
        try 
            begin 
              let (_,res) = (Compare.ManipulateVg.get_tr_token s4 0) in
                Printf.printf "Error: (Compare.ManipulateVg.get_tr_token %s %d)=(?,%d)\n" s4 0 res;  
              assert false;
            end
          with 
            _ -> assert true; 
            Printf.printf "Done\n";
    end;
    Printf.printf "End of tests get tr-token.\n\n\n";;


(** Tests to get a blend_token. *)
let test_get_blend_token () =
  Printf.printf "Tests get blend-token:\n\n";
  let s0 = "(i-const (0 0 0 0))" in
  let s1 = "(i-blend "^s0^s0^")" in
  let s2 = "unknown command" in
    begin
      Printf.printf "Assert s: '%s'\n" s1;
      let (offset1, offset2) = (Compare.ManipulateVg.get_blend_token s1 3) in
        (assert (offset1==12));
        (assert (offset2==31));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s'\n" s2;
        try 
            begin
              let (offset1,offset2) = (Compare.ManipulateVg.get_blend_token s2 0) in 
                Printf.printf "Error: (Compare.ManipulateVg.get_blend_token %s %d) = (%d,%d)\n" s2 0 offset1 offset2; 
              assert false;
            end
          with 
            _ -> assert true; 
            Printf.printf "Done\n";
    end;
    Printf.printf "End of tests get blend-token.\n\n\n";;


(** Tests to get a cut_token. *)
let test_get_cut_token () =
  Printf.printf "Tests get cut-token:\n\n";
  let test_outline = "(outline (width 0) (cap Butt) (join Miter) (miter-angle 0))" in 
  let test_path = "(path S (0 1) L (0 2) L (0 3) L (0 4) L (0 5) Z)" in
  let test_const = "(i-const (0 0 0 0))" in
  let s1 = "(i-cut "^test_outline^test_path^test_const^")" in
  let s2 = "unknown command" in
    begin
      Printf.printf "Assert s: '%s'\n" s1;
      let list = (Compare.ManipulateVg.get_cut_token s1 3) in
        (* Compare.ManipulateVg.print_list_offset list; *)
        let o1 = (String.length s1) - (String.length test_const) + 2 in
        (* Printf.printf "o1: %d\n" o1; *)
        let o2 = o1 - (String.length test_path) - 2 in
        (* Printf.printf "o2: %d\n" o2; *)
        let o3 = o2 - (String.length test_outline) in
        (* Printf.printf "o3: %d\n" o3; *)
          let rec equal l cpt = match (l,cpt) with 
            | (_,3) -> ()
            | (h::t,2) -> (assert (h==o3)); (equal t (cpt+1));
            | (h::t,1) -> (assert (h==o2)); (equal t (cpt+1));
            | (h::t,0) -> (assert (h==o1)); (equal t (cpt+1));
            | _ -> assert false
          in (equal list 0);
          Printf.printf "Done\n";
          Printf.printf "Assert s: '%s'\n" s2;
          try 
              begin
                let list = (Compare.ManipulateVg.get_cut_token s2 0) in
                  match list with
                  | [] -> ()
                  | h::t -> 
                    Printf.printf "Error: (Compare.ManipulateVg.get_cut_token %s %d) = (%d::t)\n" s2 0 h; 
                assert false;
              end
            with 
              _ -> assert true; 
              Printf.printf "Done\n";
    end;
    Printf.printf "End of tests get cut-token.\n\n\n";;


(** Tests to get a const_token. *)
let test_get_const_token () =
  Printf.printf "Tests get const-token:\n\n";
  let s1 = "(i-const (1 2 3 4))" in
  let s2 = "unknown command" in
    begin
      Printf.printf "Assert s: '%s'\n" s1;
      let (r,g,b,a) = (Compare.ManipulateVg.get_const_token s1 3) in
          (assert (r=1.));
          (assert (g=2.));
          (assert (b=3.));
          (assert (a=4.));
          Printf.printf "Done\n";
          Printf.printf "Assert s: '%s'\n" s2;
          try 
              begin
                let (r,g,b,a) = (Compare.ManipulateVg.get_const_token s2 0) in
                  Printf.printf "Error: (Compare.ManipulateVg.get_const_token %s %d) = (%f,%f,%f,%f)\n" s2 0 r g b a; 
                assert false;
              end
            with 
              _ -> assert true; 
              Printf.printf "Done\n";
    end;
    Printf.printf "End of tests get const-token.\n\n\n";;


(** Tests to get a const_token. *)
let test_get_path_token () =
  Printf.printf "Tests get path-token:\n\n";
  let s1 = "(path S (0 1) L (0 2) L (0 3) L (0 4) L 
    (0 5) Z)" 
  in
  let s2 = "unknown command" in
    begin
      Printf.printf "Assert s: '%s'\n" s1;
      let list = (Compare.ManipulateVg.get_path_token s1 3) in
      (* Compare.ManipulateVg.print_list_paths list; *)
      let (x1,y1) = (0.,5.) in
      (* Printf.printf "t1: (%f,%f)\n" x1 y1; *)
      let (x2,y2) = (0.,4.) in
      (* Printf.printf "t2: (%f,%f)\n" x2 y2; *)
      let (x3,y3) = (0.,3.) in
      (* Printf.printf "t3: (%f,%f)\n" x3 y3; *)
      let (x4,y4) = (0.,2.) in
      (* Printf.printf "t4: (%f,%f)\n" x4 y4; *)
      let (x5,y5) = (0.,1.) in
      (* Printf.printf "t5: (%f,%f)\n" x5 y5; *)
        let rec equal l cpt = match (l,cpt) with 
          | (_,6) -> ()
          | ((x,y)::t,5) -> (assert (x=x5)); (assert (y=y5)); (equal t (cpt+1));
          | ((x,y)::t,4) -> (assert (x=x4)); (assert (y=y4)); (equal t (cpt+1));
          | ((x,y)::t,3) -> (assert (x=x3)); (assert (y=y3)); (equal t (cpt+1));
          | ((x,y)::t,2) -> (assert (x=x2)); (assert (y=y2)); (equal t (cpt+1));
          | ((x,y)::t,1) -> (assert (x=x1)); (assert (y=y1)); (equal t (cpt+1));
          | _ -> assert false
        in (equal list 1);
          Printf.printf "Done\n";
          Printf.printf "Assert s: '%s'\n" s2;
          try 
              begin
                let list = (Compare.ManipulateVg.get_path_token s2 0) in
                match list with
                | [] -> ()
                | (x,y)::t -> 
                  Printf.printf "Error: (Compare.ManipulateVg.get_path_token %s %d) = (%f,%f)\n" s2 0 x y; 
                assert false;
              end
            with 
              _ -> assert true; 
              Printf.printf "Done\n";
    end;
    Printf.printf "End of tests get path-token.\n\n\n";;


(** Tests to get an outline_token. *)
let test_get_outline_token () =
  Printf.printf "Tests get outline-token:\n\n";
  let s1 = "(outline (width 0.5) (cap Butt) (join Miter) (miter-angle 0))" in
  let s2 = "unknown command" in
    begin
      Printf.printf "Assert s: '%s'\n" s1;
      let width = (Compare.ManipulateVg.get_outline_token s1 3) in
        (assert (width=0.5));
        Printf.printf "Done\n";
        Printf.printf "Assert s: '%s'\n" s2;
        try 
            begin
              let width = (Compare.ManipulateVg.get_outline_token s2 0) in
                Printf.printf "Error: (Compare.ManipulateVg.get_outline_token %s %d) = %f\n" s2 0 width; 
              assert false;
            end
          with 
            _ -> assert true; 
            Printf.printf "Done\n";
    end;
    Printf.printf "End of tests get outline-token.\n\n\n";;


(** Tests to move a tuple. *)
let test_move () =
  Printf.printf "Tests move tuple:\n\n";
  let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
  let t = (1.,1.) in
  let m1 = (1.,(-1.)) in
  let m2 = (0.,0.) in
  begin
    Printf.printf "Assert t:%s m:%s\n" (tuple_to_string t) (tuple_to_string m1);
    let t1 = Compare.ManipulateVg.move m1 t in
      let t2 = (2.,0.) in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
    Printf.printf "Assert t:%s m:%s\n" (tuple_to_string t) (tuple_to_string m2);
    let t1 = Compare.ManipulateVg.move m2 t in
      let t2 = t in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
  end;
  Printf.printf "End of tests move tuples.\n\n\n";;


(** Tests to rotate a tuple. *)
let test_rot () =
  Printf.printf "Tests rot tuple:\n\n";
  let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
  let t = (1.,1.) in
  let pi = Float.pi in
  let r1 = pi/.2. in
  let r2 = pi in
  let r3 = 0. in
  begin
    Printf.printf "Assert t:%s r:%f\n" (tuple_to_string t) r1;
    let t1 = Compare.ManipulateVg.rot r1 t in
      let t2 = ((-1.),1.) in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
    Printf.printf "Assert t:%s r:%f\n" (tuple_to_string t) r2;
    let t1 = Compare.ManipulateVg.rot r2 t in
      let t2 = ((-1.),(-1.)) in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
    Printf.printf "Assert t:%s r:%f\n" (tuple_to_string t) r3;
    let t1 = Compare.ManipulateVg.rot r3 t in
      let t2 = (1.,1.) in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
  end;
  Printf.printf "End of tests rot tuples.\n\n\n";;


(** Tests to scale a tuple. *)
let test_scale () =
  Printf.printf "Tests scale tuple:\n\n";
  let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
  let t = (0.5,1.) in
  let s1 = (1.,(-1.)) in
  let s2 = (0.5,0.2) in
  let s3 = (0.,0.) in
  begin
    Printf.printf "Assert t:%s s:%s\n" (tuple_to_string t) (tuple_to_string s1);
    let t1 = Compare.ManipulateVg.scale s1 t in
      let t2 = (0.5,(-1.)) in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
    Printf.printf "Assert t:%s s:%s\n" (tuple_to_string t) (tuple_to_string s2);
    let t1 = Compare.ManipulateVg.scale s2 t in
      let t2 = (0.25,0.2) in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
    Printf.printf "Assert t:%s s:%s\n" (tuple_to_string t) (tuple_to_string s3);
    let t1 = Compare.ManipulateVg.scale s3 t in
      let t2 = (0.,0.) in
        (assert (Compare.ManipulateVg.equal_float_tuple t1 t2));
    Printf.printf "Done\n";
  end;
  Printf.printf "End of tests scale tuples.\n\n\n";;


(** Tests for creating a tree. *)
let test_create_i_tree () =
  let test_outline = "(outline (width 0) (cap Butt) (join Miter) (miter-angle 0))" in
  let res_outline = "outline (0.000000)\n" in

  let test_path = "(path S (0 1) L (0 2) L (0 3) L (0 4) L (0 5) Z)" in 
  let res_path = "path [(0.000000,5.000000);(0.000000,4.000000);(0.000000,3.000000);(0.000000,2.000000);(0.000000,1.000000)]\n" in
  
  let test_const = "(i-const (0 0 0 0))" in 
  let res_const = "const (0.000000,0.000000,0.000000,0)\n" in
  
  let test_cut = "(i-cut "^test_outline^test_path^test_const^")" in
  let res_cut = "cut\n"^res_const^res_path^res_outline in
  
  let test_tr_move = "(i-tr (move (0 0))"^test_cut^")" in 
  let res_tr_move = "tr move (0.000000,0.000000)\n"^res_cut in
  
  let test_tr_rot = "(i-tr (rot 0)"^test_cut^")" in
  let res_tr_rot = "tr rot 0.000000\n"^res_cut in
  
  let test_tr_scale = "(i-tr (scale (0 0))"^test_cut^")" in
  let res_tr_scale = "tr scale (0.000000,0.000000)\n"^res_cut in
  
  let test_blend = "(i-blend "^test_tr_move^test_cut^")" in
  let res_blend = "blend\n"^res_tr_move^res_cut in
  
  let test_hard = "(i-blend "^test_blend^"(i-blend "^test_blend^test_cut^"))" in
  let res_hard = "blend\n"^res_blend^"blend\n"^res_blend^res_cut in
  
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
          (i-const (0.522522 0 0 1)))))))" in
  let res_super_hard = "blend\n"^
                      "blend\n"^
                      "tr move (1.000000,0.500000)\n"^
                      "cut\n"^
                      "const (1.000000,0.000000,0.000000,1)\n"^
                      "path [(0.100000,0.205000);(0.100000,0.305000);(0.200000,0.305000);(0.200000,0.205000);(0.100000,0.205000)]\n"^
                      "tr rot 0.500000\n"^
                      "cut\n"^
                      "const (0.522522,0.000000,0.000000,1)\n"^
                      "path [(0.100000,0.205000);(0.100000,0.305000);(0.200000,0.305000);(0.200000,0.205000);(0.100000,0.205000)]\n"^
                      "outline (0.010000)\n"^
                      "blend\n"^
                      "blend\n"^
                      "cut\n"^
                      "const (1.000000,0.000000,0.000000,1)\n"^
                      "path [(0.205000,0.100000);(0.205000,0.200000);(0.305000,0.200000);(0.305000,0.100000);(0.205000,0.100000)]\n"^
                      "cut\n"^
                      "const (0.522522,0.000000,0.000000,1)\n"^
                      "path [(0.205000,0.100000);(0.205000,0.200000);(0.305000,0.200000);(0.305000,0.100000);(0.205000,0.100000)]\n"^
                      "outline (0.010000)\n"^
                      "blend\n"^
                      "blend\n"^
                      "cut\n"^
                      "const (1.000000,0.000000,0.000000,1)\n"^
                      "path [(0.205000,0.205000);(0.205000,0.305000);(0.305000,0.305000);(0.305000,0.205000);(0.205000,0.205000)]\n"^
                      "cut\n"^
                      "const (0.522522,0.000000,0.000000,1)\n"^
                      "path [(0.205000,0.205000);(0.205000,0.305000);(0.305000,0.305000);(0.305000,0.205000);(0.205000,0.205000)]\n"^
                      "outline (0.010000)\n"^
                      "blend\n"^
                      "cut\n"^
                      "const (1.000000,0.000000,0.000000,1)\n"^
                      "path [(0.310000,0.100000);(0.310000,0.200000);(0.410000,0.200000);(0.410000,0.100000);(0.310000,0.100000)]\n"^
                      "cut\n"^
                      "const (0.522522,0.000000,0.000000,1)\n"^
                      "path [(0.310000,0.100000);(0.310000,0.200000);(0.410000,0.200000);(0.410000,0.100000);(0.310000,0.100000)]\n"^
                      "outline (0.010000)\n" in


  Printf.printf "Tests create i-tree:\n\n\n";
  Printf.printf "Test outline input:\n%s\n\n" test_outline;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_outline)) in
    Printf.printf "Test outline output:\n%s\n\n" output;
      (assert (String.equal res_outline output)); 
        Printf.printf "Done\n";
  Printf.printf "Test path input:\n%s\n\n" test_path;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_path)) in
    Printf.printf "Test path output:\n%s\n\n" output;
      (assert (String.equal res_path output));
        Printf.printf "Done\n";
  Printf.printf "Test const input:\n%s\n\n" test_const;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_const)) in
    Printf.printf "Test const output:\n%s\n\n" output;
      (assert (String.equal res_const output));
        Printf.printf "Done\n";
  Printf.printf "Test cut input:\n%s\n\n" test_cut;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_cut)) in
    Printf.printf "Test cut output:\n%s\n\n" output;
      (assert (String.equal res_cut output));
        Printf.printf "Done\n";
  Printf.printf "Test tr move input:\n%s\n\n" test_tr_move;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_tr_move)) in
    Printf.printf "Test tr move output:\n%s\n\n" output;
      (assert (String.equal res_tr_move output));
        Printf.printf "Done\n";
  Printf.printf "Test tr rot input:\n%s\n\n" test_tr_rot;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_tr_rot)) in
    Printf.printf "Test tr rot output:\n%s\n\n" output;
      (assert (String.equal res_tr_rot output));
        Printf.printf "Done\n";
  Printf.printf "Test tr scale input:\n%s\n\n" test_tr_scale;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_tr_scale)) in
    Printf.printf "Test tr scale output:\n%s\n\n" output;
      (assert (String.equal res_tr_scale output));
        Printf.printf "Done\n";
  Printf.printf "Test blend input:\n%s\n\n" test_blend;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_blend)) in
    Printf.printf "Test blend output:\n%s\n\n" output;
      (assert (String.equal res_blend output));
        Printf.printf "Done\n";
  Printf.printf "Test hard input:\n%s\n\n" test_hard;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_hard)) in
    Printf.printf "Test hard output:\n%s\n\n" output;
      (assert (String.equal res_hard output));
        Printf.printf "Done\n";
  Printf.printf "Test super hard input:\n%s\n\n" test_super_hard;
  let output = (Compare.ManipulateVg.to_string (Compare.ManipulateVg.create_i_tree test_super_hard)) in
    Printf.printf "Test super hard output:\n%s\n\n" output;
      (assert (String.equal res_super_hard output));
        Printf.printf "Done\n";
  Printf.printf "End of tests create i-tree.\n\n\n";;


(** Tests for getting the paths point of a tree, (it prints the input and the output of the ManipulateVg.get_paths function). *)
let test_get_points_i_tree () =
  let rec compare_list_paths l1 l2 = match (l1,l2) with
    | ([],[]) -> true
    | ([],_) -> false
    | (_,[]) -> false
    | (h1::t1, h2::t2) -> if Compare.ManipulateVg.equal_float_tuple h1 h2 then
                            (compare_list_paths t1 t2)
                          else false
  in

  let test_outline = "(outline (width 0) (cap Butt) (join Miter) (miter-angle 0))" in 
  let test_path = "(path S (0 1) L (0 2) L (0 3) L (0 4) L (0 5) Z)" in 
  let test_const = "(i-const (0 0 0 0))" in 

  let test_cut = "(i-cut "^test_outline^test_path^test_const^")" in
  let res_cut = [(0.,5.);(0.,4.);(0.,3.);(0.,2.);(0.,1.)] in

  let test_tr_move = "(i-tr (move (1 0))"^test_cut^")" in
  let res_tr_move = [(1.,5.);(1.,4.);(1.,3.);(1.,2.);(1.,1.)] in

  let pi_string = Printf.sprintf "%f" (Float.pi/.2.) in
  let test_tr_rot = "(i-tr (rot "^pi_string^")"^test_cut^")" in
  let res_tr_rot = [((-5.),0.);((-4.),0.);((-3.),0.);((-2.),0.);((-1.),0.)] in

  let test_tr_scale = "(i-tr (scale (1 2))"^test_cut^")" in 
  let res_tr_scale = [(0.,10.);(0.,8.);(0.,6.);(0.,4.);(0.,2.)] in

  let test_blend = "(i-blend "^test_tr_move^test_cut^")" in
  let res_blend = res_tr_move@res_cut in

  let test_hard = "(i-blend "^test_blend^"(i-blend "^test_blend^test_cut^"))" in
  let res_hard = res_blend@res_blend@res_cut in

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
          (i-const (0.522522 0 0 1)))))))" in
  let res_super_hard = [(1.1,0.705);(1.1,0.805);(1.2,0.805);(1.2,0.705);
                        (1.1,0.705);(-0.010524,0.227847);(-0.058467,0.315605);(0.029292,0.363548);
                        (0.077234,0.275790);(-0.010524,0.227847);(0.205,0.1);(0.205,0.2);
                        (0.305,0.2);(0.305,0.1);(0.205,0.1);(0.205,0.1);
                        (0.205,0.2);(0.305,0.2);(0.305,0.1);(0.205,0.1);
                        (0.205,0.205);(0.205,0.305);(0.305,0.305);(0.305,0.205);
                        (0.205,0.205);(0.205,0.205);(0.205,0.305);(0.305,0.305);
                        (0.305,0.205);(0.205,0.205);(0.31,0.1);(0.31,0.2);
                        (0.41,0.2);(0.41,0.1);(0.31,0.1);(0.31,0.1);
                        (0.31,0.2);(0.41,0.2);(0.41,0.1);(0.31,0.1)] in

  Printf.printf "Tests get points i-tree:\n\n\n";

  Printf.printf "Test cut input:\n%s\n\n" test_cut;
    let l = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_cut)) in
      Printf.printf "Test cut output:\n";
      Compare.ManipulateVg.print_list_paths l;
        (assert (compare_list_paths l res_cut));
          Printf.printf "Done\n";

  Printf.printf "Test tr_move input:\n%s\n\n" test_tr_move;
    let l = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_tr_move)) in
      Printf.printf "Test tr_move output:\n";
      Compare.ManipulateVg.print_list_paths l;
        (assert (compare_list_paths l res_tr_move));
          Printf.printf "Done\n";
        
  Printf.printf "Test tr_rot input:\n%s\n\n" test_tr_rot;
    let l = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_tr_rot)) in
      Printf.printf "Test tr_rot output:\n";
      Compare.ManipulateVg.print_list_paths l;
        (assert (compare_list_paths l res_tr_rot));
          Printf.printf "Done\n";
        
  Printf.printf "Test tr_scale input:\n%s\n\n" test_tr_scale;
    let l = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_tr_scale)) in
      Printf.printf "Test tr_scale output:\n";
      Compare.ManipulateVg.print_list_paths l;
        (assert (compare_list_paths l res_tr_scale));
          Printf.printf "Done\n";
        
  Printf.printf "Test blend input:\n%s\n\n" test_blend;
    let l = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_blend)) in
      Printf.printf "Test blend output:\n";
      Compare.ManipulateVg.print_list_paths l;
        (assert (compare_list_paths l res_blend));
          Printf.printf "Done\n";
        
  Printf.printf "Test hard input:\n%s\n\n" test_hard;
    let l = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_hard)) in
      Printf.printf "Test hard output:\n";
      Compare.ManipulateVg.print_list_paths l;
        (assert (compare_list_paths l res_hard));
          Printf.printf "Done\n";
        
  Printf.printf "Test super_hard input:\n%s\n\n" test_hard;
    let l = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree test_super_hard)) in
      Printf.printf "Test super_hard output:\n";
      Compare.ManipulateVg.print_list_paths l;
        (assert (compare_list_paths l res_super_hard));
          Printf.printf "Done\n";

  Printf.printf "End of tests get points i-tree.\n\n\n";;


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
    Printf.printf "End of tests equal tuples.\n\n\n";;


(** Tests tuple exists in list. *)
let test_list_mem_bis () =
  Printf.printf "Tests list mem bis:\n\n";
  let print_list_tuple l = 
    Printf.printf "[";
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
        Printf.printf "Assert t:%s, l: " t_string;
        print_list_tuple l1;
        (assert ((Compare.ManipulateVg.list_mem_bis t l1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert t:%s, l: " t_string; 
        print_list_tuple l2;
        (assert ((Compare.ManipulateVg.list_mem_bis t l2) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert t:%s, l: " t_string; 
        print_list_tuple l3;
        (assert ((Compare.ManipulateVg.list_mem_bis t l3) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert t:%s, l: " t_string; 
        print_list_tuple l4;
        (assert ((Compare.ManipulateVg.list_mem_bis t l4) == true));
        Printf.printf "Done\n";
      end;
    Printf.printf "End of tests list mem bis.\n\n\n";;


(** Tests remove tuple repetitions in list. *)
let test_remove_double () =
  Printf.printf "Tests remove double:\n\n";
  let print_list_tuple l = 
    Printf.printf "[";
    let rec aux l = match l with
      | [] -> Printf.printf "]\n"
      | (x,y)::[] -> Printf.printf "(%f,%f)]" x y; (aux [])
      | (x,y)::t -> Printf.printf "(%f,%f);" x y; (aux t)
    in (aux l)
  in
  let rec list_equal l1 l2 = match (l1,l2) with
    | ([],[]) -> true
    | ([],_) -> false
    | (_,[]) -> false
    | (h1::t1, h2::t2) -> if (Compare.ManipulateVg.equal_float_tuple h1 h2) then (list_equal t1 t2)
                            else false
  in
  let l1 = [] in
  let l2 = [(1.563789,0.235000)] in
  let l3 = [(0.3,2.34);(0.3,2.34)] in
  let l4 = [(0.454,0.233);(1.563788,0.235);(0.5,0.3281);(1.563789,0.235000)] in
  let l5 = l4@l4 in
    begin
      Printf.printf "Assert l: ";
      print_list_tuple l1;
      (assert ((list_equal (Compare.ManipulateVg.remove_double l1) []) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert l: "; 
      print_list_tuple l2;
      (assert ((list_equal (Compare.ManipulateVg.remove_double l2) l2) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert l: "; 
      print_list_tuple l3;
      (assert ((list_equal (Compare.ManipulateVg.remove_double l3) [(0.3,2.34)]) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert l: "; 
      print_list_tuple l4;
      (assert ((list_equal (Compare.ManipulateVg.remove_double l4) [(0.454,0.233);(1.563788,0.235);(0.5,0.3281)]) == true));
      Printf.printf "Done\n";
      Printf.printf "Assert l: "; 
      print_list_tuple l5;
      (assert ((list_equal (Compare.ManipulateVg.remove_double l5) (Compare.ManipulateVg.remove_double l4)) == true));
      Printf.printf "Done\n";
    end;
    Printf.printf "End of tests remove double.\n\n\n";;


(** Tests compare two list of float tuple. *)
let test_compare_list_tuples () =
  Printf.printf "Tests compare list tuples:\n\n";
  let print_list_tuple l = 
    Printf.printf "[";
    let rec aux l = match l with
      | [] -> Printf.printf "]\n"
      | (x,y)::[] -> Printf.printf "(%f,%f)]" x y; (aux [])
      | (x,y)::t -> Printf.printf "(%f,%f);" x y; (aux t)
    in (aux l)
  in
  let l = [(1.563789,0.235000);(0.3,2.34)] in
  let l1 = [] in
  let l2 = [(1.563789,0.235000);(0.3,2.34)] in
  let l3 = [(0.3,2.34);(1.563789,0.235000)] in
  let l4 = [(0.300001,2.340001);(1.563788,0.235000)] in
  let l5 = l2@l3@l4 in
    begin
      Printf.printf "Assert l1: ";
      print_list_tuple l;
      Printf.printf "Assert l2: ";
      print_list_tuple l1;
      (assert ((Compare.ManipulateVg.compare_list_tuples l l1) == false));
      Printf.printf "Done\n\n";
      
      Printf.printf "Assert l1: ";
      print_list_tuple l;
      Printf.printf "Assert l2: ";
      print_list_tuple l2;
      (assert (Compare.ManipulateVg.compare_list_tuples l l2));
      Printf.printf "Done\n\n";
      
      Printf.printf "Assert l1: ";
      print_list_tuple l;
      Printf.printf "Assert l2: ";
      print_list_tuple l3;
      (assert (Compare.ManipulateVg.compare_list_tuples l l3));
      Printf.printf "Done\n\n";
      
      Printf.printf "Assert l1: ";
      print_list_tuple l;
      Printf.printf "Assert l2: ";
      print_list_tuple l4;
      (assert (Compare.ManipulateVg.compare_list_tuples l l4));
      Printf.printf "Done\n\n";

      Printf.printf "Assert l1: ";
      print_list_tuple l;
      Printf.printf "Assert l2: ";
      print_list_tuple l5;
      (assert (Compare.ManipulateVg.compare_list_tuples l l5));
      Printf.printf "Done\n\n";
      
    end;
    Printf.printf "End of tests compare list tuples.\n\n\n";;


(** Tests for intermediate string manipulation. *)
let tests_intermediate_string_manipulation () =
  Printf.printf "Starting tests for intermediate string manipulation\n\n\n";
  test_next_space();
  test_next_left_p();
  test_next_right_p();
  Printf.printf "\nEnd of tests for intermediate string manipulation, everything's okay\n\n";;


(** Tests for tokens getter from the Vg.image as a string. *)
let tests_token_getters () =
  Printf.printf "Starting tests for intermediate functions to get tokens\n\n\n";
  test_get_tr_token();
  test_get_blend_token();
  test_get_cut_token();
  test_get_const_token();
  test_get_path_token();
  test_get_outline_token();
  Printf.printf "\nEnd of tests for intermediate functions to get tokens\n\n";;


(** Tests for intermediate operations over paths. *)
let tests_intermediate_paths_manipulation () =
  Printf.printf "Starting tests for intermediate operations over paths\n\n\n";
  test_move();
  test_rot();
  test_scale();
  Printf.printf "\nEnd of tests for intermediate operations over paths\n\n";;


(** Tests for intermediate functions to compare i_tree. *)
let tests_intermediate_i_tree_manipulation () =
  Printf.printf "Starting tests for intermediate functions to compare i_tree\n\n\n";
  test_equal_tuples();
  test_list_mem_bis();
  test_remove_double();
  test_compare_list_tuples();
  Printf.printf "\nEnd of tests for intermediate functions to compare i_tree\n\n";;


(** Tests for i_tree manipulation. *)
let tests_i_tree_manipulation () =
  Printf.printf "Starting tests for i_tree manipulation\n\n\n";
  test_create_i_tree();
  test_get_points_i_tree();
  Printf.printf "\nEnd of tests for i_tree manipulation, everything's okay\n\n";;


(** Tests for image_equal, the main function of the Compare module. *)
let test_image_equal () =
  Printf.printf "Starting tests for image equal\n\n\n";
  let i1 = "(i-blend Over
    (i-blend Over
    (i-cut anz
      (path S (0.1 0.1) L (0.2 0.1) L (0.2 0.2) L (0.1 0.2) L (0.1 0.1) Z)
      (i-const (0 0.165023 0.533493 1)))
    (i-cut
      (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.1 0.1) L (0.2 0.1) L (0.2 0.2) L (0.1 0.2) L (0.1 0.1) Z)
      (i-const (0 0.0141151 0.132952 1))))
    (i-blend Over
    (i-blend Over
      (i-cut anz
      (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
        (0.1 0.205) Z)
      (i-const (0 0.165023 0.533493 1)))
      (i-cut
      (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
        (0.1 0.205) Z)
      (i-const (0 0.0141151 0.132952 1))))
    (i-blend Over
      (i-blend Over
      (i-cut anz
        (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
        (0.205 0.1) Z)
        (i-const (0 0.165023 0.533493 1)))
      (i-cut
        (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
        (0.205 0.1) Z)
        (i-const (0 0.0141151 0.132952 1))))
      (i-blend Over
      (i-cut anz
        (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L (0.31 0.1)
        Z)
        (i-const (0 0.165023 0.533493 1)))
      (i-cut
        (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L (0.31 0.1)
        Z)
        (i-const (0 0.0141151 0.132952 1)))))))" in
  let i2 = "(i-tr (move (0.5 0))
    (i-tr (rot 1.5708)
    (i-tr (move (0.5 0))
      (i-tr (rot 1.5708)
      (i-tr (move (0.5 0))
        (i-tr (rot 1.5708)
        (i-tr (move (0.5 0))
          (i-tr (rot 1.5708)
          (i-blend Over(I.blend composant1
            (i-blend Over
            (i-cut anz
              (path S (0.1 0.1) L (0.2 0.1) L (0.2 0.2) L (0.1 0.2) L (0.1 0.1)
              Z)
              (i-const (0 0.165023 0.533493 1)))
            (i-cut
              (outline (width 0.01) (cap Butt) (join Miter)
              (miter-angle 0.200713))
              (path S (0.1 0.1) L (0.2 0.1) L (0.2 0.2) L (0.1 0.2) L (0.1 0.1)
              Z)
              (i-const (0 0.0141151 0.132952 1))))
            (i-blend Over
            (i-blend Over
              (i-cut anz
              (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
                (0.1 0.205) Z)
              (i-const (0 0.165023 0.533493 1)))
              (i-cut
              (outline (width 0.01) (cap Butt) (join Miter)
                (miter-angle 0.200713))
              (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
                (0.1 0.205) Z)
              (i-const (0 0.0141151 0.132952 1))))
            (i-blend Over
              (i-blend Over
              (i-cut anz
                (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
                (0.205 0.1) Z)
                (i-const (0 0.165023 0.533493 1)))
              (i-cut
                (outline (width 0.01) (cap Butt) (join Miter)
                (miter-angle 0.200713))
                (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
                (0.205 0.1) Z)
                (i-const (0 0.0141151 0.132952 1))))
              (i-blend Over
              (i-cut anz
                (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L
                (0.31 0.1) Z)
                (i-const (0 0.165023 0.533493 1)))
              (i-cut
                (outline (width 0.01) (cap Butt) (join Miter)
                (miter-angle 0.200713))
                (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L
                (0.31 0.1) Z)
                (i-const (0 0.0141151 0.132952 1)))))))))))))))"
  in
  begin
    let di1 = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree i1)) in
      let di2 = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree i2))
    in 
      (assert ((Compare.ManipulateVg.compare_list_tuples di1 di2) == true));
      Printf.printf "Done\n";
  end;
  Printf.printf "\nEnd of tests for for image equal\n\n";;


(** Do all the tests at once. *)
let main () =
  Printf.printf "Starting tests\n\n\n";
  tests_intermediate_string_manipulation();
  tests_token_getters();
  tests_intermediate_paths_manipulation();
  tests_intermediate_i_tree_manipulation();
  tests_i_tree_manipulation();
  test_image_equal();
  Printf.printf "\nEnd of tests, everything's okay\n\n";;


let () = main();;