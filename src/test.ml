open Vg;;
open Gg;;

(** Module containing tests for intermediate functions to manipulate a string. *)
module Intermediate_string_manipulation = struct 
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
  

  (** Tests for intermediate string manipulation. *)
  let tests_intermediate_string_manipulation () =
    Printf.printf "Starting tests for intermediate string manipulation\n\n\n";
    test_next_space();
    test_next_left_p();
    test_next_right_p();
    Printf.printf "\nEnd of tests for intermediate string manipulation, everything's okay\n\n";;


end;;


(** Module containing tests for tokens getter from the Vg.image as a string.*)
module Token_getters = struct
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
    let s3 = "(path)" in
      begin
        Printf.printf "Assert s: '%s'\n" s1;
        let list = (Compare.ManipulateVg.get_path_token s1 1) in
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
                begin
                  Printf.printf "Done\n";
                  Printf.printf "Assert s: '%s'\n" s3;
                  let list = (Compare.ManipulateVg.get_path_token s3 1) in
                  (assert (list=[]));
                  Printf.printf "Done\n";
                end
      end;
      Printf.printf "End of tests get path-token.\n\n\n";;


  (** Tests to get an outline_token. *)
  let test_get_outline_token () =
    Printf.printf "Tests get outline-token:\n\n";
    let s1 = "(outline (width 0.5) (cap Butt) (join Miter) (miter-angle 0))" in
    let s2 = "unknown command" in
      begin
        Printf.printf "Assert s: '%s'\n" s1;
        let width = (Compare.ManipulateVg.get_outline_token s1 1) in
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

end;;


(** Module containing tests for intermediate operations over paths.*)
module Intermediate_paths_manipulation = struct
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

  (** Tests to move a path with its color. *)
  let test_move_color () =
    Printf.printf "Tests move_color:\n\n";
    let nuplet_to_string t = match t with (x,y,r,g,b,a) -> (Printf.sprintf "(%f,%f,%f,%f,%f,%f)" x y r g b a) in
    let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
    let t = (1.,1.,1.,1.,1.,1.) in
    let m1 = (1.,(-1.)) in
    let m2 = (0.,0.) in
    begin
      Printf.printf "Assert t:%s m:%s\n" (nuplet_to_string t) (tuple_to_string m1);
      let (x,y,r,g,b,a) = Compare.ManipulateVg.move_color m1 t in
        let t2_pos = (2.,0.) in
        let t2_color = (1.,1.,1.,1.) in
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
      Printf.printf "Assert t:%s m:%s\n" (nuplet_to_string t) (tuple_to_string m2);
      let (x,y,r,g,b,a) = Compare.ManipulateVg.move_color m2 t in
        let t2_pos = (1.,1.) in
        let t2_color = (1.,1.,1.,1.) in
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
    end;
    Printf.printf "End of tests move_color.\n\n\n";;


  (** Tests to rotate a path with its color. *)
  let test_rot_color () =
    Printf.printf "Tests rot_color:\n\n";
    let nuplet_to_string t = match t with (x,y,r,g,b,a) -> (Printf.sprintf "(%f,%f,%f,%f,%f,%f)" x y r g b a) in
    let t = (1.,1.,1.,1.,1.,1.) in
    let pi = Float.pi in
    let r1 = pi/.2. in
    let r2 = pi in
    let r3 = 0. in
    begin
      Printf.printf "Assert t:%s r:%f\n" (nuplet_to_string t) r1;
      let (x,y,r,g,b,a) = Compare.ManipulateVg.rot_color r1 t in
        let t2_pos = ((-1.),1.) in
        let t2_color = (1.,1.,1.,1.) in
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
      Printf.printf "Assert t:%s r:%f\n" (nuplet_to_string t) r2;
      let (x,y,r,g,b,a) = Compare.ManipulateVg.rot_color r2 t in
        let t2_pos = ((-1.),(-1.)) in
        let t2_color = (1.,1.,1.,1.) in
          (* Printf.printf "Res t:%s\n" (nuplet_to_string (x,y,r,g,b,a)); *)
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
      Printf.printf "Assert t:%s r:%f\n" (nuplet_to_string t) r3;
      let (x,y,r,g,b,a) = Compare.ManipulateVg.rot_color r3 t in
        let t2_pos = (1.,1.) in
        let t2_color = (1.,1.,1.,1.) in
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
    end;
    Printf.printf "End of tests rot_color.\n\n\n";;


  (** Tests to scale a path with its color. *)
  let test_scale_color () =
    Printf.printf "Tests scale_color:\n\n";
    let nuplet_to_string t = match t with (x,y,r,g,b,a) -> (Printf.sprintf "(%f,%f,%f,%f,%f,%f)" x y r g b a) in
    let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
    let t = (0.5,1.,1.,1.,1.,1.) in
    let s1 = (1.,(-1.)) in
    let s2 = (0.5,0.2) in
    let s3 = (0.,0.) in
    begin
      Printf.printf "Assert t:%s m:%s\n" (nuplet_to_string t) (tuple_to_string s1);
      let (x,y,r,g,b,a) = Compare.ManipulateVg.scale_color s1 t in
        let t2_pos = (0.5,(-1.)) in
        let t2_color = (1.,1.,1.,1.) in
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
      Printf.printf "Assert t:%s m:%s\n" (nuplet_to_string t) (tuple_to_string s2);
      let (x,y,r,g,b,a) = Compare.ManipulateVg.scale_color s2 t in
        let t2_pos = (0.25,0.2) in
        let t2_color = (1.,1.,1.,1.) in
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
      Printf.printf "Assert t:%s m:%s\n" (nuplet_to_string t) (tuple_to_string s3);
      let (x,y,r,g,b,a) = Compare.ManipulateVg.scale_color s3 t in
        let t2_pos = (0.,0.) in
        let t2_color = (1.,1.,1.,1.) in
          (assert (Compare.ManipulateVg.equal_float_tuple (x,y) t2_pos));
          (assert (Compare.ManipulateVg.equal_colors (r,g,b,a) t2_color));
      Printf.printf "Done\n";
    end;
    Printf.printf "End of tests scale_color.\n\n\n";;


  (** Tests for intermediate operations over paths. *)
  let tests_intermediate_paths_manipulation () =
    Printf.printf "Starting tests for intermediate operations over paths\n\n\n";
    test_move();
    test_rot();
    test_scale();
    test_move_color();
    test_rot_color();
    test_scale_color();
    Printf.printf "\nEnd of tests for intermediate operations over paths\n\n";;

end;;


(** Module containing tests for intermediate functions to compare i_tree.*)
module Intermediate_i_tree_manipulation = struct
  (** Tests for comparing tuples. *)
  let test_equal_tuples () = 
    Printf.printf "Tests equal tuples:\n\n";
    let tuple_to_string t = match t with (x,y) -> (Printf.sprintf "(%f,%f)" x y) in
      let epsilon = 0.1 in
      let t1 = (1.,2.) in
      let t2 = (2.,1.) in
      let t3 = (1.0001,2.) in
      let t4 = (1.,1.9999) in
      let t5 = (1.0000001,2.) in
      let t6 = (1.,1.999999) in
      let t7 = (1.563789,0.235) in
      let t8 = (1.563788,0.235) in
      begin
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t1) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t1 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t2) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t1 t2) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t2) (tuple_to_string t1) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t2 t1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t3) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t1 t3) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t3) (tuple_to_string t1) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t3 t1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t4) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t1 t4) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t4) (tuple_to_string t1) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t4 t1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t3) epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple ~epsilon t1 t3) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t3) (tuple_to_string t1) epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple ~epsilon t3 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t4) epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple ~epsilon t1 t4) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t4) (tuple_to_string t1) epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple ~epsilon t4 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t5) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t1 t5) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t5) (tuple_to_string t1) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t5 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t1) (tuple_to_string t6) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t1 t6) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t6) (tuple_to_string t1) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t6 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t7) (tuple_to_string t8) Compare.epsilon;
        (assert ((Compare.ManipulateVg.equal_float_tuple t7 t8) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s, epsilon: %f\n" (tuple_to_string t8) (tuple_to_string t7) Compare.epsilon;
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
    let allow_translations = true in
    let l = [(1.563789,0.235000);(0.3,2.34)] in
    let l1 = [] in
    let l2 = [(1.563789,0.235000);(0.3,2.34)] in
    let l3 = [(0.3,2.34);(1.563789,0.235000)] in
    let l4 = [(0.300001,2.340001);(1.563788,0.235000)] in
    let l5 = l2@l3@l4 in
    let l6 = [(1.563789+.0.42,0.235000+.0.69);(0.3+.0.42,2.34+.0.69)] in
    let l7 = [(1.563789+.0.42,0.235000+.0.42);(0.3+.0.42,2.34+.0.69)] in
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

        Printf.printf "Assert l1: ";
        print_list_tuple l;
        Printf.printf "Assert l2: ";
        print_list_tuple l6;
        (assert (Compare.ManipulateVg.compare_list_tuples ~allow_translations l l6));
        Printf.printf "Done\n\n";

        Printf.printf "Assert l1: ";
        print_list_tuple l;
        Printf.printf "Assert l2: ";
        print_list_tuple l7;
        (assert ((Compare.ManipulateVg.compare_list_tuples ~allow_translations l l7) == false));
        Printf.printf "Done\n\n";
        
      end;
      Printf.printf "End of tests compare list tuples.\n\n\n";;


  (** Tests for comparing colors. *)
  let test_equal_colors () = 
    Printf.printf "Tests equal_colors:\n\n";
    let nuplet_to_string t = match t with (r,g,b,a) -> (Printf.sprintf "(%f,%f,%f,%f)" r g b a) in
      let t1 = (0.5,0.3,0.4,0.2) in
      let t2 = (0.3,0.5,0.4,0.2) in
      let t3 = (0.50001,0.30001,0.40001,0.20001) in
      let t4 = (0.49999,0.29999,0.39999,0.19999) in
      let t5 = (0.5000001,0.3000001,0.4000001,0.2000001) in
      let t6 = (0.499999,0.299999,0.399999,0.199999) in
      let t7 = (0.234,0.432,0.456,0.777777) in
      let t8 = (0.234,0.432,0.456,0.777778) in
      begin
        Printf.printf "Assert %s %s\n" (nuplet_to_string t1) (nuplet_to_string t1);
        (assert ((Compare.ManipulateVg.equal_colors t1 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t1) (nuplet_to_string t2);
        (assert ((Compare.ManipulateVg.equal_colors t1 t2) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t2) (nuplet_to_string t1);
        (assert ((Compare.ManipulateVg.equal_colors t2 t1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t1) (nuplet_to_string t1);
        (assert ((Compare.ManipulateVg.equal_colors t1 t3) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t3) (nuplet_to_string t1);
        (assert ((Compare.ManipulateVg.equal_colors t3 t1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t1) (nuplet_to_string t4);
        (assert ((Compare.ManipulateVg.equal_colors t1 t4) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t4) (nuplet_to_string t1);
        (assert ((Compare.ManipulateVg.equal_colors t4 t1) == false));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t1) (nuplet_to_string t5);
        (assert ((Compare.ManipulateVg.equal_colors t1 t5) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t5) (nuplet_to_string t1);
        (assert ((Compare.ManipulateVg.equal_colors t5 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t1) (nuplet_to_string t6);
        (assert ((Compare.ManipulateVg.equal_colors t1 t6) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t6) (nuplet_to_string t1);
        (assert ((Compare.ManipulateVg.equal_colors t6 t1) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t7) (nuplet_to_string t8);
        (assert ((Compare.ManipulateVg.equal_colors t7 t8) == true));
        Printf.printf "Done\n";
        Printf.printf "Assert %s %s\n" (nuplet_to_string t8) (nuplet_to_string t7);
        (assert ((Compare.ManipulateVg.equal_colors t8 t7) == true));
        Printf.printf "Done\n";
      end;
      Printf.printf "End of tests equalcolors.\n\n\n";;


  (** Tests if an element is in a list of paths with their colors. *)
  let test_list_mem_color () =
    Printf.printf "Tests list mem color:\n\n";
    let t_to_string t = 
      match t with ((x,y),list) -> 
        let str = (Printf.sprintf "((%f,%f),[" x y) in
          let rec aux list acc = match list with 
            | [] -> acc^(Printf.sprintf "])")
            | (r,g,b,a)::[] -> let newAcc = acc^(Printf.sprintf "(%f,%f,%f,%f)" r g b a)
                                in (aux [] newAcc)
            | (r,g,b,a)::t -> let newAcc = acc^(Printf.sprintf "(%f,%f,%f,%f);" r g b a)
                                in (aux t newAcc)
          in str^(aux list "")
    in
    let print_list l =
        let rec aux l acc = match l with
          | [] -> acc^(Printf.sprintf "]\n")
          | t::[] -> let newAcc = acc^(t_to_string t)
                      in (aux [] newAcc)
          | h::t -> let newAcc = acc^(t_to_string h)^";"
                      in (aux t newAcc)
        in Printf.printf "%s" (aux l "[")
    in
      let t = ((1.563789,0.235),[(1.,0.3,0.4,0.5)]) in
      let t1 = ((1.563789,0.235),[]) in
      let t2 = ((1.563789,0.235),[(1.,0.3,0.4,0.5);(0.4,0.2,0.5,0.4)]) in
      let l1 = [] in
      let l2 = [((1.563789,0.235000),[(1.,0.3,0.4,0.5)])] in
      let l3 = [((0.3,2.34),[(1.,0.3,0.4,0.5)]);((0.5,0.3281),[(1.,0.3,0.4,0.5)])] in
      let l4 = [((0.454,0.233),[(0.,0.,0.,0.)]);((1.563788,0.235),[(1.,0.3,0.4,0.5)]);((0.5,0.3281),[(0.,0.,0.,0.)])] in
      let l5 = [((1.563789,0.235000),[(0.,0.,0.,0.)])] in
      let l6 = [((1.563789,0.235000),[(0.,0.,0.,0.);(1.,0.3,0.4,0.5)])] in
        begin
          Printf.printf "Assert t:%s,\nl: " (t_to_string t);
          print_list l1;
          (assert ((Compare.ManipulateVg.list_mem_color t l1) == false));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t); 
          print_list l2;
          (assert ((Compare.ManipulateVg.list_mem_color t l2) == true));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t); 
          print_list l3;
          (assert ((Compare.ManipulateVg.list_mem_color t l3) == false));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t); 
          print_list l4;
          (assert ((Compare.ManipulateVg.list_mem_color t l4) == true));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t); 
          print_list l5;
          (assert ((Compare.ManipulateVg.list_mem_color t l5) == false));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t); 
          print_list l6;
          (assert ((Compare.ManipulateVg.list_mem_color t l6) == true));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t1); 
          print_list l1;
        end;
          try 
            begin 
              Printf.printf "Error: %b\n" (Compare.ManipulateVg.list_mem_color t1 l1); 
              assert false;
            end
          with 
            _ -> assert true; 
            Printf.printf "Done\n";
            Printf.printf "Assert t:%s,\nl: " (t_to_string t2); 
            print_list l1;
            try 
              begin 
                Printf.printf "Error: %b\n" (Compare.ManipulateVg.list_mem_color t2 l1); 
                assert false;
              end
            with 
              _ -> assert true; 
              Printf.printf "Done\n";
              Printf.printf "End of tests list mem color.\n\n\n";;


  (** Test adding a given path with its color in a list of path with their colors (without duplicate tuple). *)
  let test_add_color () =
    Printf.printf "Tests add color:\n\n";
    let t_to_string t = 
      match t with ((x,y),list) -> 
        let str = (Printf.sprintf "((%f,%f),[" x y) in
          let rec aux list acc = match list with 
            | [] -> acc^(Printf.sprintf "])")
            | (r,g,b,a)::[] -> let newAcc = acc^(Printf.sprintf "(%f,%f,%f,%f)" r g b a)
                                in (aux [] newAcc)
            | (r,g,b,a)::t -> let newAcc = acc^(Printf.sprintf "(%f,%f,%f,%f);" r g b a)
                                in (aux t newAcc)
          in str^(aux list "")
    in
    let print_list l =
      let rec aux l acc = match l with
        | [] -> acc^(Printf.sprintf "]\n")
        | t::[] -> let newAcc = acc^(t_to_string t)
                    in (aux [] newAcc)
        | h::t -> let newAcc = acc^(t_to_string h)^";"
                    in (aux t newAcc)
      in Printf.printf "%s" (aux l "[")
    in
    let equal_list_color l1 l2 =
      let rec aux l1 l2 = match (l1,l2) with
        | ([],[]) -> true
        | (_,[]) -> false
        | ([],_) -> false
        | ((r1,g1,b1,a1)::t1,(r2,g2,b2,a2)::t2) -> 
            (Compare.ManipulateVg.equal_float_tuple (r1,g1) (r2,g2)) &&
            (Compare.ManipulateVg.equal_float_tuple (b1,a1) (b2,a2)) &&
            (aux t1 t2)
      in (aux l1 l2)
    in
    let compare_list l1 l2 =
      let rec aux l1 l2 = match (l1,l2) with
        | ([],[]) -> true
        | (_,[]) -> false
        | ([],_) -> false
        | ((t1,c1)::n1,(t2,c2)::n2) -> 
          (Compare.ManipulateVg.equal_float_tuple t1 t2) &&
          (equal_list_color c1 c2) &&
          (aux n1 n2)
      in (aux l1 l2)
    in
      let t = ((1.563789,0.235),[(1.,0.3,0.4,0.5)]) in
      let l1 = [] in
      let res_l1 = [((1.563789,0.235),[(1.,0.3,0.4,0.5)])] in
      let l2 = [((0.,0.),[(1.,0.3,0.4,0.5)])] in
      let res_l2 = [((0.,0.),[(1.,0.3,0.4,0.5)]);((1.563789,0.235000),[(1.,0.3,0.4,0.5)])] in
      let l3 = [((1.563789,0.235000),[(0.,0.,0.,0.)])] in
      let res_l3 = [((1.563789,0.235000),[(0.,0.,0.,0.);(1.,0.3,0.4,0.5)])] in
        begin
          Printf.printf "Assert t:%s,\nl: " (t_to_string t);
          print_list l1;
            let res = (Compare.ManipulateVg.add_color t l1) in
              Printf.printf "res: ";
              print_list res;
              (assert (compare_list res res_l1));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t);
          print_list l2;
            let res = (Compare.ManipulateVg.add_color t l2) in
              Printf.printf "res: ";
              print_list res;
              (assert (compare_list res res_l2));
          Printf.printf "Done\n";
          Printf.printf "Assert t:%s,\nl: " (t_to_string t);
          print_list l3;
            let res = (Compare.ManipulateVg.add_color t l3) in
              Printf.printf "res: ";
              print_list res;
              (assert (compare_list res res_l3));
          Printf.printf "Done\n";
        end;
    Printf.printf "End of tests add color.\n\n\n";;


  (** Test remove copies in a list of float 6-uplet and transfor them into a (float tuple * (float*float*float*float) list) tuple *)
  let test_remove_double_color () =
    Printf.printf "Tests remove double color:\n\n";
    let t_to_string t = 
      match t with ((x,y),list) -> 
        let str = (Printf.sprintf "((%f,%f),[" x y) in
          let rec aux list acc = match list with 
            | [] -> acc^(Printf.sprintf "])")
            | (r,g,b,a)::[] -> let newAcc = acc^(Printf.sprintf "(%f,%f,%f,%f)" r g b a)
                                in (aux [] newAcc)
            | (r,g,b,a)::t -> let newAcc = acc^(Printf.sprintf "(%f,%f,%f,%f);" r g b a)
                                in (aux t newAcc)
          in str^(aux list "")
    in
    let nuplet_to_string (x,y,r,g,b,a) = (Printf.sprintf "(%f,%f,%f,%f,%f,%f)" x y r g b a) in
    let print_list l =
      let rec aux l acc = match l with
        | [] -> acc^(Printf.sprintf "]\n")
        | t::[] -> let newAcc = acc^(t_to_string t)
                    in (aux [] newAcc)
        | h::t -> let newAcc = acc^(t_to_string h)^";"
                    in (aux t newAcc)
      in Printf.printf "%s" (aux l "[")
    in
    let print_list_nuplet l =
      let rec aux l acc = match l with
        | [] -> acc^(Printf.sprintf "]\n")
        | h::[] -> let newAcc = acc^(nuplet_to_string h)
                    in (aux [] newAcc)
        | h::t -> let newAcc = acc^(nuplet_to_string h)^";"
                    in (aux t newAcc)
      in Printf.printf "%s" (aux l "[")
    in
    let equal_list_color l1 l2 =
      let rec aux l1 l2 = match (l1,l2) with
        | ([],[]) -> true
        | (_,[]) -> false
        | ([],_) -> false
        | ((r1,g1,b1,a1)::t1,(r2,g2,b2,a2)::t2) -> 
            (Compare.ManipulateVg.equal_float_tuple (r1,g1) (r2,g2)) &&
            (Compare.ManipulateVg.equal_float_tuple (b1,a1) (b2,a2)) &&
            (aux t1 t2)
      in (aux l1 l2)
    in
    let compare_list l1 l2 =
      let rec aux l1 l2 = match (l1,l2) with
        | ([],[]) -> true
        | (_,[]) -> false
        | ([],_) -> false
        | ((t1,c1)::n1,(t2,c2)::n2) -> 
          (Compare.ManipulateVg.equal_float_tuple t1 t2) &&
          (equal_list_color c1 c2) &&
          (aux n1 n2)
      in (aux l1 l2)
    in
    let l1 = [] in
    let res_l1 = [] in
    let l2 = [(1.563789,0.235000,0.,0.,0.,0.)] in
    let res_l2 = [((1.563789,0.235000),[(0.,0.,0.,0.)])] in
    let l3 = [(0.3,2.34,0.,0.,0.,0.);(0.3,2.34,0.,0.,0.,0.)] in
    let res_l3 = [((0.3,2.34),[(0.,0.,0.,0.);(0.,0.,0.,0.)])] in
    let l4 = [(0.454,0.233,0.,0.,0.,0.);(1.563788,0.235,0.,0.,0.,0.);(0.5,0.3281,0.,0.,0.,0.);(1.563789,0.235000,1.,1.,1.,1.)] in
    let res_l4 = [((0.454,0.233),[(0.,0.,0.,0.)]);((1.563789,0.235000),[(0.,0.,0.,0.);(1.,1.,1.,1.)]);((0.5,0.3281),[(0.,0.,0.,0.)])] in
    let l5 = l4@l4 in
    let res_l5 = [((0.454,0.233),[(0.,0.,0.,0.);(0.,0.,0.,0.)]);
                  ((1.563789,0.235000),[(0.,0.,0.,0.);(1.,1.,1.,1.);(0.,0.,0.,0.);(1.,1.,1.,1.)]);
                  ((0.5,0.3281),[(0.,0.,0.,0.);(0.,0.,0.,0.)])] in
      begin
        Printf.printf "Assert l: ";
          print_list_nuplet l1;
            let res = (Compare.ManipulateVg.remove_double_color l1) in
              Printf.printf "res: ";
              print_list res;
              (assert (compare_list res res_l1));
          Printf.printf "Done\n";
        Printf.printf "Assert l: ";
        print_list_nuplet l2;
          let res = (Compare.ManipulateVg.remove_double_color l2) in
            Printf.printf "res: ";
            print_list res;
            (assert (compare_list res res_l2));
        Printf.printf "Done\n";
        Printf.printf "Assert l: ";
        print_list_nuplet l3;
          let res = (Compare.ManipulateVg.remove_double_color l3) in
            Printf.printf "res: ";
            print_list res;
            (assert (compare_list res res_l3));
        Printf.printf "Done\n";
        Printf.printf "Assert l: ";
          print_list_nuplet l4;
            let res = (Compare.ManipulateVg.remove_double_color l4) in
              Printf.printf "res: ";
              print_list res;
              (assert (compare_list res res_l4));
        Printf.printf "Done\n";
        Printf.printf "Assert l: ";
          print_list_nuplet l5;
            let res = (Compare.ManipulateVg.remove_double_color l5) in
              Printf.printf "res: ";
              print_list res;
              (assert (compare_list res res_l5));
        Printf.printf "Done\n";
      end;
      Printf.printf "End of tests remove double color.\n\n\n";;


  (** Tests compare two list of path with their colors. *)
  let test_compare_list_colors () =
    Printf.printf "Tests compare list colors:\n\n";
    let nuplet_to_string (x,y,r,g,b,a) = (Printf.sprintf "(%f,%f,%f,%f,%f,%f)" x y r g b a) in
    let print_list_nuplet l =
      let rec aux l acc = match l with
        | [] -> acc^(Printf.sprintf "]\n")
        | h::[] -> let newAcc = acc^(nuplet_to_string h)
                    in (aux [] newAcc)
        | h::t -> let newAcc = acc^(nuplet_to_string h)^";"
                    in (aux t newAcc)
      in Printf.printf "%s" (aux l "[")
    in
    let allow_translations = true in
    let l = [(1.563789,0.235000,0.,0.,0.,0.);(0.3,2.34,1.,1.,1.,1.)] in
    let l1 = [] in
    let l2 = [(1.563789,0.235000,0.,0.,0.,0.);(0.3,2.34,1.,1.,1.,1.)] in
    let l3 = [(0.3,2.34,1.,1.,1.,1.);(1.563789,0.235000,0.,0.,0.,0.)] in
    let l4 = [(0.300001,2.340001,1.,1.,1.,1.);(1.563788,0.235000,0.,0.,0.,0.)] in
    let l5 = l2@l3@l4 in
    let l6 = [(1.563789,0.235000,1.,1.,1.,1.);(1.563789,0.235000,0.,0.,0.,0.);(0.3,2.34,1.,1.,1.,1.)] in
    let l7 = [(1.563789,0.235000,1.,1.,1.,1.);(0.3,2.34,0.,0.,0.,0.)] in
    let l8 = [(1.563789+.0.42,0.235000+.0.69,0.,0.,0.,0.);(0.3+.0.42,2.34+.0.69,1.,1.,1.,1.)] in
    let l9 = [(1.563789+.0.42,0.235000+.0.42,0.,0.,0.,0.);(0.3+.0.42,2.34+.0.69,1.,1.,1.,1.)] in
      begin
        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l1;
        (assert ((Compare.ManipulateVg.compare_list_colors l l1) == false));
        Printf.printf "Done\n\n";
        
        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l2;
        (assert (Compare.ManipulateVg.compare_list_colors l l2));
        Printf.printf "Done\n\n";
        
        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l3;
        (assert (Compare.ManipulateVg.compare_list_colors l l3));
        Printf.printf "Done\n\n";
        
        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l4;
        (assert (Compare.ManipulateVg.compare_list_colors l l4));
        Printf.printf "Done\n\n";

        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l5;
        (assert (Compare.ManipulateVg.compare_list_colors l l5));
        Printf.printf "Done\n\n";

        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l6;
        (assert (Compare.ManipulateVg.compare_list_colors l l6));
        Printf.printf "Done\n\n";

        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l7;
        (assert ((Compare.ManipulateVg.compare_list_colors l l7)==false));
        Printf.printf "Done\n\n";
        
        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l8;
        (assert (Compare.ManipulateVg.compare_list_colors ~allow_translations l l8));
        Printf.printf "Done\n\n";

        Printf.printf "Assert l1: ";
        print_list_nuplet l;
        Printf.printf "Assert l2: ";
        print_list_nuplet l9;
        (assert ((Compare.ManipulateVg.compare_list_colors ~allow_translations l l9)==false));
        Printf.printf "Done\n\n";

      end;
      Printf.printf "End of tests compare list colors.\n\n\n";;

  
  (** Tests for intermediate functions to compare i_tree. *)
  let tests_intermediate_i_tree_manipulation () =
    Printf.printf "Starting tests for intermediate functions to compare i_tree\n\n\n";
    test_equal_tuples();
    test_list_mem_bis();
    test_remove_double();
    test_compare_list_tuples();
    test_equal_colors();
    test_list_mem_color();
    test_add_color();
    test_remove_double_color();
    test_compare_list_colors();
    Printf.printf "\nEnd of tests for intermediate functions to compare i_tree\n\n";;

end;;


(** Module containing tests for i_tree manipulation.*)
module I_tree_manipulation = struct
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


  (** Tests for getting the paths point of a tree. *)
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


  (** Tests for getting the paths point (with their color) of a tree. *)
  let test_get_points_color_i_tree () =
    let rec compare_list_paths_color l1 l2 = match (l1,l2) with
      | ([],[]) -> true
      | ([],_) -> false
      | (_,[]) -> false
      | ((x1,y1,r1,g1,b1,a1)::t1, (x2,y2,r2,g2,b2,a2)::t2) -> 
          if Compare.ManipulateVg.equal_float_tuple (x1,y1) (x2,y2) 
            && Compare.ManipulateVg.equal_float_tuple (r1,g1) (r2,g2)
              && Compare.ManipulateVg.equal_float_tuple (b1,a1) (b2,a2)
          then (compare_list_paths_color t1 t2)
            else false
    in

    let test_outline = "(outline (width 0) (cap Butt) (join Miter) (miter-angle 0))" in 
    let test_path = "(path S (0 1) L (0 2) L (0 3) L (0 4) Z)" in 
    let test_const = "(i-const (0 0 0 0))" in
    let test_const_bis = "(i-const (1 1 1 1))" in  

    let test_cut = "(i-cut "^test_outline^test_path^test_const^")" in
    let test_cut_bis = "(i-cut "^test_outline^test_path^test_const_bis^")" in
    let res_cut = [(0.,1.,0.,0.,0.,0.);(0.,2.,0.,0.,0.,0.);(0.,3.,0.,0.,0.,0.);(0.,4.,0.,0.,0.,0.)] in
    let res_cut_bis = [(0.,1.,1.,1.,1.,1.);(0.,2.,1.,1.,1.,1.);(0.,3.,1.,1.,1.,1.);(0.,4.,1.,1.,1.,1.)] in

    let test_tr_move = "(i-tr (move (1 0))"^test_cut^")" in
    let res_tr_move = [(1.,1.,0.,0.,0.,0.);(1.,2.,0.,0.,0.,0.);(1.,3.,0.,0.,0.,0.);(1.,4.,0.,0.,0.,0.)] in

    let pi_string = Printf.sprintf "%f" (Float.pi/.2.) in
    let test_tr_rot = "(i-tr (rot "^pi_string^")"^test_cut^")" in
    let res_tr_rot = [((-1.),0.,0.,0.,0.,0.);((-2.),0.,0.,0.,0.,0.);((-3.),0.,0.,0.,0.,0.);((-4.),0.,0.,0.,0.,0.)] in

    let test_tr_scale = "(i-tr (scale (1 2))"^test_cut^")" in 
    let res_tr_scale = [(0.,2.,0.,0.,0.,0.);(0.,4.,0.,0.,0.,0.);(0.,6.,0.,0.,0.,0.);(0.,8.,0.,0.,0.,0.)] in

    let test_blend = "(i-blend "^test_tr_move^test_cut_bis^")" in
    let res_blend = res_tr_move@res_cut_bis in

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
    let res_super_hard = [(1.100000,0.705000,1.000000,0.000000,0.000000,1.000000);
                          (1.200000,0.705000,1.000000,0.000000,0.000000,1.000000);
                          (1.200000,0.805000,1.000000,0.000000,0.000000,1.000000);
                          (1.100000,0.805000,1.000000,0.000000,0.000000,1.000000);
                          (1.100000,0.705000,1.000000,0.000000,0.000000,1.000000);
                          (-0.010524,0.227847,0.522522,0.000000,0.000000,1.000000);
                          (0.077234,0.275790,0.522522,0.000000,0.000000,1.000000);
                          (0.029292,0.363548,0.522522,0.000000,0.000000,1.000000);
                          (-0.058467,0.315605,0.522522,0.000000,0.000000,1.000000);
                          (-0.010524,0.227847,0.522522,0.000000,0.000000,1.000000);
                          (0.205000,0.100000,1.000000,0.000000,0.000000,1.000000);
                          (0.305000,0.100000,1.000000,0.000000,0.000000,1.000000);
                          (0.305000,0.200000,1.000000,0.000000,0.000000,1.000000);
                          (0.205000,0.200000,1.000000,0.000000,0.000000,1.000000);
                          (0.205000,0.100000,1.000000,0.000000,0.000000,1.000000);
                          (0.205000,0.100000,0.522522,0.000000,0.000000,1.000000);
                          (0.305000,0.100000,0.522522,0.000000,0.000000,1.000000);
                          (0.305000,0.200000,0.522522,0.000000,0.000000,1.000000);
                          (0.205000,0.200000,0.522522,0.000000,0.000000,1.000000);
                          (0.205000,0.100000,0.522522,0.000000,0.000000,1.000000);
                          (0.205000,0.205000,1.000000,0.000000,0.000000,1.000000);
                          (0.305000,0.205000,1.000000,0.000000,0.000000,1.000000);
                          (0.305000,0.305000,1.000000,0.000000,0.000000,1.000000);
                          (0.205000,0.305000,1.000000,0.000000,0.000000,1.000000);
                          (0.205000,0.205000,1.000000,0.000000,0.000000,1.000000);
                          (0.205000,0.205000,0.522522,0.000000,0.000000,1.000000);
                          (0.305000,0.205000,0.522522,0.000000,0.000000,1.000000);
                          (0.305000,0.305000,0.522522,0.000000,0.000000,1.000000);
                          (0.205000,0.305000,0.522522,0.000000,0.000000,1.000000);
                          (0.205000,0.205000,0.522522,0.000000,0.000000,1.000000);
                          (0.310000,0.100000,1.000000,0.000000,0.000000,1.000000);
                          (0.410000,0.100000,1.000000,0.000000,0.000000,1.000000);
                          (0.410000,0.200000,1.000000,0.000000,0.000000,1.000000);
                          (0.310000,0.200000,1.000000,0.000000,0.000000,1.000000);
                          (0.310000,0.100000,1.000000,0.000000,0.000000,1.000000);
                          (0.310000,0.100000,0.522522,0.000000,0.000000,1.000000);
                          (0.410000,0.100000,0.522522,0.000000,0.000000,1.000000);
                          (0.410000,0.200000,0.522522,0.000000,0.000000,1.000000);
                          (0.310000,0.200000,0.522522,0.000000,0.000000,1.000000);
                          (0.310000,0.100000,0.522522,0.000000,0.000000,1.000000)] in 

    Printf.printf "Tests get points color i-tree:\n\n\n";

    Printf.printf "Test cut input:\n%s\n\n" test_cut;
      let l = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree test_cut)) in
        Printf.printf "Test cut output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_cut));
            Printf.printf "Done\n";

    Printf.printf "Test cut-bis input:\n%s\n\n" test_cut_bis;
      let l = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree test_cut_bis)) in
        Printf.printf "Test cut-bis output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_cut_bis));
            Printf.printf "Done\n";

    Printf.printf "Test tr_move input:\n%s\n\n" test_tr_move;
      let i = (Compare.ManipulateVg.create_i_tree test_tr_move) in
        (* Printf.printf "image move:\n%s\n\n" (Compare.ManipulateVg.to_string i); *)
      let l = (Compare.ManipulateVg.get_points_color i) in
        Printf.printf "Test tr_move output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_tr_move));
            Printf.printf "Done\n";
          
    Printf.printf "Test tr_rot input:\n%s\n\n" test_tr_rot;
      let i = (Compare.ManipulateVg.create_i_tree test_tr_rot) in
        (* Printf.printf "image rot:\n%s\n\n" (Compare.ManipulateVg.to_string i); *)
      let l = (Compare.ManipulateVg.get_points_color i) in
        Printf.printf "Test tr_rot output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_tr_rot));
            Printf.printf "Done\n";
          
    Printf.printf "Test tr_scale input:\n%s\n\n" test_tr_scale;
      let l = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree test_tr_scale)) in
        Printf.printf "Test tr_scale output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_tr_scale));
            Printf.printf "Done\n";
          
    Printf.printf "Test blend input:\n%s\n\n" test_blend;
      let l = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree test_blend)) in
        Printf.printf "Test blend output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_blend));
            Printf.printf "Done\n";
          
    Printf.printf "Test hard input:\n%s\n\n" test_hard;
      let l = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree test_hard)) in
        Printf.printf "Test hard output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_hard));
            Printf.printf "Done\n";
          
    Printf.printf "Test super_hard input:\n%s\n\n" test_hard;
      let l = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree test_super_hard)) in
        Printf.printf "Test super_hard output:\n";
        Compare.ManipulateVg.print_list_paths_color l;
          (assert (compare_list_paths_color l res_super_hard));
            Printf.printf "Done\n";

    Printf.printf "End of tests get points color i-tree.\n\n\n";;



  (** Tests for i_tree manipulation. *)
  let tests_i_tree_manipulation () =
    Printf.printf "Starting tests for i_tree manipulation\n\n\n";
    test_create_i_tree();
    test_get_points_i_tree();
    test_get_points_color_i_tree();
    Printf.printf "\nEnd of tests for i_tree manipulation, everything's okay\n\n";;

end;;


(** Tests for image_equal, the main function of the Compare module. *)
let test_image_equal () =
  Printf.printf "\nStarting tests for image equal\n\n";
  let tetris_j = "(i-blend Over
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
        (i-const (0 0.0141151 0.132952 1)))))))" 
  in
  let tetris_j_rotate_4_times = "(i-tr (move (0.5 0))
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
  let tetris_z = "(i-blend Over
    (i-blend Over
    (i-cut anz
      (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
      (0.1 0.205) Z)
      (i-const (1 0 0 1)))
    (i-cut
      (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
      (0.1 0.205) Z)
      (i-const (0.522522 0 0 1))))
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
        (i-const (0.522522 0 0 1)))))))"
  in
  let tetris_z_decale = "(i-blend Over
    (i-blend Over
    (i-cut anz
      (path S (0.2 0.405) L (0.3 0.405) L (0.3 0.505) L (0.2 0.505) L
      (0.2 0.405) Z)
      (i-const (1 0 0 1)))
    (i-cut
      (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.2 0.405) L (0.3 0.405) L (0.3 0.505) L (0.2 0.505) L
      (0.2 0.405) Z)
      (i-const (0.522522 0 0 1))))
    (i-blend Over
    (i-blend Over
      (i-cut anz
      (path S (0.305 0.3) L (0.405 0.3) L (0.405 0.4) L (0.305 0.4) L
        (0.305 0.3) Z)
      (i-const (1 0 0 1)))
      (i-cut
      (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.305 0.3) L (0.405 0.3) L (0.405 0.4) L (0.305 0.4) L
        (0.305 0.3) Z)
      (i-const (0.522522 0 0 1))))
    (i-blend Over
      (i-blend Over
      (i-cut anz
        (path S (0.305 0.405) L (0.405 0.405) L (0.405 0.505) L (0.305 0.505) L
        (0.305 0.405) Z)
        (i-const (1 0 0 1)))
      (i-cut
        (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.305 0.405) L (0.405 0.405) L (0.405 0.505) L (0.305 0.505) L
        (0.305 0.405) Z)
        (i-const (0.522522 0 0 1))))
      (i-blend Over
      (i-cut anz
        (path S (0.41 0.3) L (0.51 0.3) L (0.51 0.4) L (0.41 0.4) L (0.41 0.3)
        Z)
        (i-const (1 0 0 1)))
      (i-cut
        (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.41 0.3) L (0.51 0.3) L (0.51 0.4) L (0.41 0.4) L (0.41 0.3)
        Z)
        (i-const (0.522522 0 0 1)))))))"
  in
  let tetris_z_different_color = "(i-blend Over
    (i-blend Over
    (i-cut anz
      (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
      (0.1 0.205) Z)
      (i-const (1 0.0835351 0.0835351 1)))
    (i-cut
      (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.1 0.205) L (0.2 0.205) L (0.2 0.305) L (0.1 0.305) L
      (0.1 0.205) Z)
      (i-const (0.522522 0.00517162 0.00517162 1))))
    (i-blend Over
    (i-blend Over
      (i-cut anz
      (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
        (0.205 0.1) Z)
      (i-const (1 0.0835351 0.0835351 1)))
      (i-cut
      (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.205 0.1) L (0.305 0.1) L (0.305 0.2) L (0.205 0.2) L
        (0.205 0.1) Z)
      (i-const (0.522522 0.00517162 0.00517162 1))))
    (i-blend Over
      (i-blend Over
      (i-cut anz
        (path S (0.205 0.205) L (0.305 0.205) L (0.305 0.305) L (0.205 0.305) L
        (0.205 0.205) Z)
        (i-const (1 0.0835351 0.0835351 1)))
      (i-cut
        (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.205 0.205) L (0.305 0.205) L (0.305 0.305) L (0.205 0.305) L
        (0.205 0.205) Z)
        (i-const (0.522522 0.00517162 0.00517162 1))))
      (i-blend Over
      (i-cut anz
        (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L (0.31 0.1)
        Z)
        (i-const (1 0.0835351 0.0835351 1)))
      (i-cut
        (outline (width 0.01) (cap Butt) (join Miter) (miter-angle 0.200713))
        (path S (0.31 0.1) L (0.41 0.1) L (0.41 0.2) L (0.31 0.2) L (0.31 0.1)
        Z)
        (i-const (0.522522 0.00517162 0.00517162 1)))))))"
  in
  let tetris_board = "(i-blend Over
    (i-blend Over
    (i-cut
      (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.21 0) L (0.714 0) Z S (0.21 0.042) L (0.714 0.042) Z S
      (0.21 0.084) L (0.714 0.084) Z S (0.21 0.126) L (0.714 0.126) Z S
      (0.21 0.168) L (0.714 0.168) Z S (0.21 0.21) L (0.714 0.21) Z S
      (0.21 0.252) L (0.714 0.252) Z S (0.21 0.294) L (0.714 0.294) Z S
      (0.21 0.336) L (0.714 0.336) Z S (0.21 0.378) L (0.714 0.378) Z S
      (0.21 0.42) L (0.714 0.42) Z S (0.21 0.462) L (0.714 0.462) Z S
      (0.21 0.504) L (0.714 0.504) Z S (0.21 0.546) L (0.714 0.546) Z S
      (0.21 0.588) L (0.714 0.588) Z S (0.21 0.63) L (0.714 0.63) Z S
      (0.21 0.672) L (0.714 0.672) Z S (0.21 0.714) L (0.714 0.714) Z S
      (0.21 0.756) L (0.714 0.756) Z S (0.21 0.798) L (0.714 0.798) Z S
      (0.21 0.84) L (0.714 0.84) Z S (0.21 0.882) L (0.714 0.882) Z S
      (0.21 0.924) L (0.714 0.924) Z S (0.21 0.966) L (0.714 0.966) Z S
      (0.21 1.008) L (0.714 1.008) Z)
      (i-const (0 0 0 0.5)))
    (i-cut
      (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.21 0) L (0.21 1.008) Z S (0.252 0) L (0.252 1.008) Z S
      (0.294 0) L (0.294 1.008) Z S (0.336 0) L (0.336 1.008) Z S (0.378 0) L
      (0.378 1.008) Z S (0.42 0) L (0.42 1.008) Z S (0.462 0) L (0.462 1.008) Z
      S (0.504 0) L (0.504 1.008) Z S (0.546 0) L (0.546 1.008) Z S (0.588 0) L
      (0.588 1.008) Z S (0.63 0) L (0.63 1.008) Z S (0.672 0) L (0.672 1.008) Z
      S (0.714 0) L (0.714 1.008) Z)
      (i-const (0 0 0 0.5))))
    (i-blend Over
    (i-cut anz
      (path S (0.504 0.63) L (0.544 0.63) L (0.544 0.67) L (0.504 0.67) L
      (0.504 0.63) Z S (0.546 0.63) L (0.586 0.63) L (0.586 0.67) L
      (0.546 0.67) L (0.546 0.63) Z S (0.21 0.588) L (0.25 0.588) L
      (0.25 0.628) L (0.21 0.628) L (0.21 0.588) Z S (0.252 0.588) L
      (0.292 0.588) L (0.292 0.628) L (0.252 0.628) L (0.252 0.588) Z S
      (0.504 0.588) L (0.544 0.588) L (0.544 0.628) L (0.504 0.628) L
      (0.504 0.588) Z S (0.546 0.588) L (0.586 0.588) L (0.586 0.628) L
      (0.546 0.628) L (0.546 0.588) Z S (0.21 0.546) L (0.25 0.546) L
      (0.25 0.586) L (0.21 0.586) L (0.21 0.546) Z S (0.252 0.546) L
      (0.292 0.546) L (0.292 0.586) L (0.252 0.586) L (0.252 0.546) Z S
      (0.42 0.546) L (0.46 0.546) L (0.46 0.586) L (0.42 0.586) L (0.42 0.546)
      Z S (0.462 0.546) L (0.502 0.546) L (0.502 0.586) L (0.462 0.586) L
      (0.462 0.546) Z S (0.42 0.504) L (0.46 0.504) L (0.46 0.544) L
      (0.42 0.544) L (0.42 0.504) Z S (0.462 0.504) L (0.502 0.504) L
      (0.502 0.544) L (0.462 0.544) L (0.462 0.504) Z S (0.63 0.42) L
      (0.67 0.42) L (0.67 0.46) L (0.63 0.46) L (0.63 0.42) Z S (0.672 0.42) L
      (0.712 0.42) L (0.712 0.46) L (0.672 0.46) L (0.672 0.42) Z S
      (0.21 0.378) L (0.25 0.378) L (0.25 0.418) L (0.21 0.418) L (0.21 0.378)
      Z S (0.252 0.378) L (0.292 0.378) L (0.292 0.418) L (0.252 0.418) L
      (0.252 0.378) Z S (0.21 0.336) L (0.25 0.336) L (0.25 0.376) L
      (0.21 0.376) L (0.21 0.336) Z S (0.252 0.336) L (0.292 0.336) L
      (0.292 0.376) L (0.252 0.376) L (0.252 0.336) Z S (0.546 0.294) L
      (0.586 0.294) L (0.586 0.334) L (0.546 0.334) L (0.546 0.294) Z S
      (0.588 0.294) L (0.628 0.294) L (0.628 0.334) L (0.588 0.334) L
      (0.588 0.294) Z S (0.42 0.168) L (0.46 0.168) L (0.46 0.208) L
      (0.42 0.208) L (0.42 0.168) Z S (0.462 0.168) L (0.502 0.168) L
      (0.502 0.208) L (0.462 0.208) L (0.462 0.168) Z S (0.462 0.126) L
      (0.502 0.126) L (0.502 0.166) L (0.462 0.166) L (0.462 0.126) Z S
      (0.504 0.126) L (0.544 0.126) L (0.544 0.166) L (0.504 0.166) L
      (0.504 0.126) Z)
      (i-const (1 1 0.000309598 1)))
    (i-blend Over
      (i-cut anz
      (path S (0.21 0.504) L (0.25 0.504) L (0.25 0.544) L (0.21 0.544) L
        (0.21 0.504) Z S (0.21 0.462) L (0.25 0.462) L (0.25 0.502) L
        (0.21 0.502) L (0.21 0.462) Z S (0.252 0.462) L (0.292 0.462) L
        (0.292 0.502) L (0.252 0.502) L (0.252 0.462) Z S (0.378 0.42) L
        (0.418 0.42) L (0.418 0.46) L (0.378 0.46) L (0.378 0.42) Z S
        (0.42 0.42) L (0.46 0.42) L (0.46 0.46) L (0.42 0.46) L (0.42 0.42) Z S
        (0.462 0.42) L (0.502 0.42) L (0.502 0.46) L (0.462 0.46) L (0.462 0.42)
        Z S (0.294 0.378) L (0.334 0.378) L (0.334 0.418) L (0.294 0.418) L
        (0.294 0.378) Z S (0.504 0.378) L (0.544 0.378) L (0.544 0.418) L
        (0.504 0.418) L (0.504 0.378) Z S (0.546 0.378) L (0.586 0.378) L
        (0.586 0.418) L (0.546 0.418) L (0.546 0.378) Z S (0.588 0.378) L
        (0.628 0.378) L (0.628 0.418) L (0.588 0.418) L (0.588 0.378) Z S
        (0.294 0.336) L (0.334 0.336) L (0.334 0.376) L (0.294 0.376) L
        (0.294 0.336) Z S (0.546 0.336) L (0.586 0.336) L (0.586 0.376) L
        (0.546 0.376) L (0.546 0.336) Z S (0.21 0.294) L (0.25 0.294) L
        (0.25 0.334) L (0.21 0.334) L (0.21 0.294) Z S (0.252 0.294) L
        (0.292 0.294) L (0.292 0.334) L (0.252 0.334) L (0.252 0.294) Z S
        (0.294 0.294) L (0.334 0.294) L (0.334 0.334) L (0.294 0.334) L
        (0.294 0.294) Z S (0.336 0.294) L (0.376 0.294) L (0.376 0.334) L
        (0.336 0.334) L (0.336 0.294) Z S (0.294 0.252) L (0.334 0.252) L
        (0.334 0.292) L (0.294 0.292) L (0.294 0.252) Z S (0.504 0.252) L
        (0.544 0.252) L (0.544 0.292) L (0.504 0.292) L (0.504 0.252) Z S
        (0.462 0.21) L (0.502 0.21) L (0.502 0.25) L (0.462 0.25) L (0.462 0.21)
        Z S (0.504 0.21) L (0.544 0.21) L (0.544 0.25) L (0.504 0.25) L
        (0.504 0.21) Z S (0.294 0.168) L (0.334 0.168) L (0.334 0.208) L
        (0.294 0.208) L (0.294 0.168) Z S (0.336 0.168) L (0.376 0.168) L
        (0.376 0.208) L (0.336 0.208) L (0.336 0.168) Z S (0.378 0.168) L
        (0.418 0.168) L (0.418 0.208) L (0.378 0.208) L (0.378 0.168) Z S
        (0.504 0.168) L (0.544 0.168) L (0.544 0.208) L (0.504 0.208) L
        (0.504 0.168) Z S (0.546 0.168) L (0.586 0.168) L (0.586 0.208) L
        (0.546 0.208) L (0.546 0.168) Z S (0.252 0.126) L (0.292 0.126) L
        (0.292 0.166) L (0.252 0.166) L (0.252 0.126) Z S (0.546 0.126) L
        (0.586 0.126) L (0.586 0.166) L (0.546 0.166) L (0.546 0.126) Z S
        (0.588 0.126) L (0.628 0.126) L (0.628 0.166) L (0.588 0.166) L
        (0.588 0.126) Z S (0.63 0.126) L (0.67 0.126) L (0.67 0.166) L
        (0.63 0.166) L (0.63 0.126) Z S (0.63 0.084) L (0.67 0.084) L
        (0.67 0.124) L (0.63 0.124) L (0.63 0.084) Z)
      (i-const (0.16186 0.0294883 0.350975 1)))
      (i-blend Over
      (i-cut anz
        (path S (0.588 0.588) L (0.628 0.588) L (0.628 0.628) L (0.588 0.628) L
        (0.588 0.588) Z S (0.63 0.588) L (0.67 0.588) L (0.67 0.628) L
        (0.63 0.628) L (0.63 0.588) Z S (0.294 0.546) L (0.334 0.546) L
        (0.334 0.586) L (0.294 0.586) L (0.294 0.546) Z S (0.336 0.546) L
        (0.376 0.546) L (0.376 0.586) L (0.336 0.586) L (0.336 0.546) Z S
        (0.63 0.546) L (0.67 0.546) L (0.67 0.586) L (0.63 0.586) L
        (0.63 0.546) Z S (0.672 0.546) L (0.712 0.546) L (0.712 0.586) L
        (0.672 0.586) L (0.672 0.546) Z S (0.336 0.504) L (0.376 0.504) L
        (0.376 0.544) L (0.336 0.544) L (0.336 0.504) Z S (0.378 0.504) L
        (0.418 0.504) L (0.418 0.544) L (0.378 0.544) L (0.378 0.504) Z S
        (0.336 0.336) L (0.376 0.336) L (0.376 0.376) L (0.336 0.376) L
        (0.336 0.336) Z S (0.378 0.336) L (0.418 0.336) L (0.418 0.376) L
        (0.378 0.376) L (0.378 0.336) Z S (0.378 0.294) L (0.418 0.294) L
        (0.418 0.334) L (0.378 0.334) L (0.378 0.294) Z S (0.42 0.294) L
        (0.46 0.294) L (0.46 0.334) L (0.42 0.334) L (0.42 0.294) Z S
        (0.546 0.084) L (0.586 0.084) L (0.586 0.124) L (0.546 0.124) L
        (0.546 0.084) Z S (0.588 0.084) L (0.628 0.084) L (0.628 0.124) L
        (0.588 0.124) L (0.588 0.084) Z S (0.378 0.042) L (0.418 0.042) L
        (0.418 0.082) L (0.378 0.082) L (0.378 0.042) Z S (0.42 0.042) L
        (0.46 0.042) L (0.46 0.082) L (0.42 0.082) L (0.42 0.042) Z S (0.42 0)
        L (0.46 0) L (0.46 0.04) L (0.42 0.04) L (0.42 0) Z S (0.462 0) L
        (0.502 0) L (0.502 0.04) L (0.462 0.04) L (0.462 0) Z)
        (i-const (1 0 0 1)))
      (i-blend Over
        (i-cut anz
        (path S (0.63 0.672) L (0.67 0.672) L (0.67 0.712) L (0.63 0.712) L
          (0.63 0.672) Z S (0.63 0.63) L (0.67 0.63) L (0.67 0.67) L (0.63 0.67)
          L (0.63 0.63) Z S (0.672 0.63) L (0.712 0.63) L (0.712 0.67) L
          (0.672 0.67) L (0.672 0.63) Z S (0.672 0.588) L (0.712 0.588) L
          (0.712 0.628) L (0.672 0.628) L (0.672 0.588) Z S (0.63 0.504) L
          (0.67 0.504) L (0.67 0.544) L (0.63 0.544) L (0.63 0.504) Z S
          (0.672 0.504) L (0.712 0.504) L (0.712 0.544) L (0.672 0.544) L
          (0.672 0.504) Z S (0.588 0.462) L (0.628 0.462) L (0.628 0.502) L
          (0.588 0.502) L (0.588 0.462) Z S (0.63 0.462) L (0.67 0.462) L
          (0.67 0.502) L (0.63 0.502) L (0.63 0.462) Z S (0.546 0.42) L
          (0.586 0.42) L (0.586 0.46) L (0.546 0.46) L (0.546 0.42) Z S
          (0.588 0.42) L (0.628 0.42) L (0.628 0.46) L (0.588 0.46) L
          (0.588 0.42) Z S (0.462 0.336) L (0.502 0.336) L (0.502 0.376) L
          (0.462 0.376) L (0.462 0.336) Z S (0.462 0.294) L (0.502 0.294) L
          (0.502 0.334) L (0.462 0.334) L (0.462 0.294) Z S (0.504 0.294) L
          (0.544 0.294) L (0.544 0.334) L (0.504 0.334) L (0.504 0.294) Z S
          (0.336 0.252) L (0.376 0.252) L (0.376 0.292) L (0.336 0.292) L
          (0.336 0.252) Z S (0.378 0.252) L (0.418 0.252) L (0.418 0.292) L
          (0.378 0.292) L (0.378 0.252) Z S (0.42 0.252) L (0.46 0.252) L
          (0.46 0.292) L (0.42 0.292) L (0.42 0.252) Z S (0.462 0.252) L
          (0.502 0.252) L (0.502 0.292) L (0.462 0.292) L (0.462 0.252) Z S
          (0.294 0.21) L (0.334 0.21) L (0.334 0.25) L (0.294 0.25) L
          (0.294 0.21) Z S (0.336 0.21) L (0.376 0.21) L (0.376 0.25) L
          (0.336 0.25) L (0.336 0.21) Z S (0.378 0.21) L (0.418 0.21) L
          (0.418 0.25) L (0.378 0.25) L (0.378 0.21) Z S (0.42 0.21) L
          (0.46 0.21) L (0.46 0.25) L (0.42 0.25) L (0.42 0.21) Z S (0.21 0.168)
          L (0.25 0.168) L (0.25 0.208) L (0.21 0.208) L (0.21 0.168) Z S
          (0.252 0.168) L (0.292 0.168) L (0.292 0.208) L (0.252 0.208) L
          (0.252 0.168) Z S (0.588 0.168) L (0.628 0.168) L (0.628 0.208) L
          (0.588 0.208) L (0.588 0.168) Z S (0.63 0.168) L (0.67 0.168) L
          (0.67 0.208) L (0.63 0.208) L (0.63 0.168) Z S (0.336 0.126) L
          (0.376 0.126) L (0.376 0.166) L (0.336 0.166) L (0.336 0.126) Z S
          (0.294 0.084) L (0.334 0.084) L (0.334 0.124) L (0.294 0.124) L
          (0.294 0.084) Z S (0.378 0.084) L (0.418 0.084) L (0.418 0.124) L
          (0.378 0.124) L (0.378 0.084) Z S (0.252 0.042) L (0.292 0.042) L
          (0.292 0.082) L (0.252 0.082) L (0.252 0.042) Z S (0.294 0.042) L
          (0.334 0.042) L (0.334 0.082) L (0.294 0.082) L (0.294 0.042) Z S
          (0.672 0.042) L (0.712 0.042) L (0.712 0.082) L (0.672 0.082) L
          (0.672 0.042) Z)
        (i-const (0.287937 0.638283 0.0782883 1)))
        (i-blend Over
        (i-cut anz
          (path S (0.378 0.588) L (0.418 0.588) L (0.418 0.628) L (0.378 0.628)
          L (0.378 0.588) Z S (0.42 0.588) L (0.46 0.588) L (0.46 0.628) L
          (0.42 0.628) L (0.42 0.588) Z S (0.462 0.588) L (0.502 0.588) L
          (0.502 0.628) L (0.462 0.628) L (0.462 0.588) Z S (0.378 0.546) L
          (0.418 0.546) L (0.418 0.586) L (0.378 0.586) L (0.378 0.546) Z S
          (0.462 0.462) L (0.502 0.462) L (0.502 0.502) L (0.462 0.502) L
          (0.462 0.462) Z S (0.504 0.462) L (0.544 0.462) L (0.544 0.502) L
          (0.504 0.502) L (0.504 0.462) Z S (0.546 0.462) L (0.586 0.462) L
          (0.586 0.502) L (0.546 0.502) L (0.546 0.462) Z S (0.21 0.42) L
          (0.25 0.42) L (0.25 0.46) L (0.21 0.46) L (0.21 0.42) Z S
          (0.252 0.42) L (0.292 0.42) L (0.292 0.46) L (0.252 0.46) L
          (0.252 0.42) Z S (0.294 0.42) L (0.334 0.42) L (0.334 0.46) L
          (0.294 0.46) L (0.294 0.42) Z S (0.504 0.42) L (0.544 0.42) L
          (0.544 0.46) L (0.504 0.46) L (0.504 0.42) Z S (0.21 0.126) L
          (0.25 0.126) L (0.25 0.166) L (0.21 0.166) L (0.21 0.126) Z S
          (0.42 0.126) L (0.46 0.126) L (0.46 0.166) L (0.42 0.166) L
          (0.42 0.126) Z S (0.42 0.084) L (0.46 0.084) L (0.46 0.124) L
          (0.42 0.124) L (0.42 0.084) Z S (0.462 0.084) L (0.502 0.084) L
          (0.502 0.124) L (0.462 0.124) L (0.462 0.084) Z S (0.672 0.084) L
          (0.712 0.084) L (0.712 0.124) L (0.672 0.124) L (0.672 0.084) Z S
          (0.336 0.042) L (0.376 0.042) L (0.376 0.082) L (0.336 0.082) L
          (0.336 0.042) Z S (0.462 0.042) L (0.502 0.042) L (0.502 0.082) L
          (0.462 0.082) L (0.462 0.042) Z S (0.504 0.042) L (0.544 0.042) L
          (0.544 0.082) L (0.504 0.082) L (0.504 0.042) Z S (0.546 0.042) L
          (0.586 0.042) L (0.586 0.082) L (0.546 0.082) L (0.546 0.042) Z S
          (0.588 0.042) L (0.628 0.042) L (0.628 0.082) L (0.588 0.082) L
          (0.588 0.042) Z S (0.252 0) L (0.292 0) L (0.292 0.04) L (0.252 0.04)
          L (0.252 0) Z S (0.294 0) L (0.334 0) L (0.334 0.04) L (0.294 0.04) L
          (0.294 0) Z S (0.336 0) L (0.376 0) L (0.376 0.04) L (0.336 0.04) L
          (0.336 0) Z S (0.504 0) L (0.544 0) L (0.544 0.04) L (0.504 0.04) L
          (0.504 0) Z)
          (i-const (1 0.527207 0 1)))
        (i-blend Over
          (i-cut anz
          (path S (0.504 0.546) L (0.544 0.546) L (0.544 0.586) L (0.504 0.586)
            L (0.504 0.546) Z S (0.504 0.504) L (0.544 0.504) L (0.544 0.544) L
            (0.504 0.544) L (0.504 0.504) Z S (0.546 0.504) L (0.586 0.504) L
            (0.586 0.544) L (0.546 0.544) L (0.546 0.504) Z S (0.588 0.504) L
            (0.628 0.504) L (0.628 0.544) L (0.588 0.544) L (0.588 0.504) Z S
            (0.336 0.378) L (0.376 0.378) L (0.376 0.418) L (0.336 0.418) L
            (0.336 0.378) Z S (0.378 0.378) L (0.418 0.378) L (0.418 0.418) L
            (0.378 0.418) L (0.378 0.378) Z S (0.42 0.378) L (0.46 0.378) L
            (0.46 0.418) L (0.42 0.418) L (0.42 0.378) Z S (0.462 0.378) L
            (0.502 0.378) L (0.502 0.418) L (0.462 0.418) L (0.462 0.378) Z S
            (0.672 0.378) L (0.712 0.378) L (0.712 0.418) L (0.672 0.418) L
            (0.672 0.378) Z S (0.42 0.336) L (0.46 0.336) L (0.46 0.376) L
            (0.42 0.376) L (0.42 0.336) Z S (0.588 0.336) L (0.628 0.336) L
            (0.628 0.376) L (0.588 0.376) L (0.588 0.336) Z S (0.63 0.336) L
            (0.67 0.336) L (0.67 0.376) L (0.63 0.376) L (0.63 0.336) Z S
            (0.672 0.336) L (0.712 0.336) L (0.712 0.376) L (0.672 0.376) L
            (0.672 0.336) Z S (0.672 0.294) L (0.712 0.294) L (0.712 0.334) L
            (0.672 0.334) L (0.672 0.294) Z S (0.252 0.252) L (0.292 0.252) L
            (0.292 0.292) L (0.252 0.292) L (0.252 0.252) Z S (0.588 0.252) L
            (0.628 0.252) L (0.628 0.292) L (0.588 0.292) L (0.588 0.252) Z S
            (0.63 0.252) L (0.67 0.252) L (0.67 0.292) L (0.63 0.292) L
            (0.63 0.252) Z S (0.672 0.252) L (0.712 0.252) L (0.712 0.292) L
            (0.672 0.292) L (0.672 0.252) Z S (0.252 0.21) L (0.292 0.21) L
            (0.292 0.25) L (0.252 0.25) L (0.252 0.21) Z S (0.672 0.126) L
            (0.712 0.126) L (0.712 0.166) L (0.672 0.166) L (0.672 0.126) Z S
            (0.21 0.084) L (0.25 0.084) L (0.25 0.124) L (0.21 0.124) L
            (0.21 0.084) Z S (0.252 0.084) L (0.292 0.084) L (0.292 0.124) L
            (0.252 0.124) L (0.252 0.084) Z S (0.21 0.042) L (0.25 0.042) L
            (0.25 0.082) L (0.21 0.082) L (0.21 0.042) Z S (0.21 0) L (0.25 0) L
            (0.25 0.04) L (0.21 0.04) L (0.21 0) Z)
          (i-const (0 0.165023 0.533493 1)))
          (i-blend Over
          (i-cut anz
            (path S (0.336 0.63) L (0.376 0.63) L (0.376 0.67) L (0.336 0.67) L
            (0.336 0.63) Z S (0.378 0.63) L (0.418 0.63) L (0.418 0.67) L
            (0.378 0.67) L (0.378 0.63) Z S (0.42 0.63) L (0.46 0.63) L
            (0.46 0.67) L (0.42 0.67) L (0.42 0.63) Z S (0.462 0.63) L
            (0.502 0.63) L (0.502 0.67) L (0.462 0.67) L (0.462 0.63) Z S
            (0.294 0.462) L (0.334 0.462) L (0.334 0.502) L (0.294 0.502) L
            (0.294 0.462) Z S (0.336 0.462) L (0.376 0.462) L (0.376 0.502) L
            (0.336 0.502) L (0.336 0.462) Z S (0.378 0.462) L (0.418 0.462) L
            (0.418 0.502) L (0.378 0.502) L (0.378 0.462) Z S (0.42 0.462) L
            (0.46 0.462) L (0.46 0.502) L (0.42 0.502) L (0.42 0.462) Z S
            (0.546 0.21) L (0.586 0.21) L (0.586 0.25) L (0.546 0.25) L
            (0.546 0.21) Z S (0.588 0.21) L (0.628 0.21) L (0.628 0.25) L
            (0.588 0.25) L (0.588 0.21) Z S (0.63 0.21) L (0.67 0.21) L
            (0.67 0.25) L (0.63 0.25) L (0.63 0.21) Z S (0.672 0.21) L
            (0.712 0.21) L (0.712 0.25) L (0.672 0.25) L (0.672 0.21) Z S
            (0.546 0) L (0.586 0) L (0.586 0.04) L (0.546 0.04) L (0.546 0) Z S
            (0.588 0) L (0.628 0) L (0.628 0.04) L (0.588 0.04) L (0.588 0) Z S
            (0.63 0) L (0.67 0) L (0.67 0.04) L (0.63 0.04) L (0.63 0) Z S
            (0.672 0) L (0.712 0) L (0.712 0.04) L (0.672 0.04) L (0.672 0) Z)
            (i-const (0.000309598 0.43388 0.879415 1)))
          (i-const (1 1 1 1))))))))))"
  in
  let tetris_board_easy = "(i-blend Over
    (i-blend Over
    (i-cut
      (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.21 0) L (0.714 0) Z S (0.21 0.042) L (0.714 0.042) Z S
      (0.21 0.084) L (0.714 0.084) Z S (0.21 0.126) L (0.714 0.126) Z S
      (0.21 0.168) L (0.714 0.168) Z S (0.21 0.21) L (0.714 0.21) Z S
      (0.21 0.252) L (0.714 0.252) Z S (0.21 0.294) L (0.714 0.294) Z S
      (0.21 0.336) L (0.714 0.336) Z S (0.21 0.378) L (0.714 0.378) Z S
      (0.21 0.42) L (0.714 0.42) Z S (0.21 0.462) L (0.714 0.462) Z S
      (0.21 0.504) L (0.714 0.504) Z S (0.21 0.546) L (0.714 0.546) Z S
      (0.21 0.588) L (0.714 0.588) Z S (0.21 0.63) L (0.714 0.63) Z S
      (0.21 0.672) L (0.714 0.672) Z S (0.21 0.714) L (0.714 0.714) Z S
      (0.21 0.756) L (0.714 0.756) Z S (0.21 0.798) L (0.714 0.798) Z S
      (0.21 0.84) L (0.714 0.84) Z S (0.21 0.882) L (0.714 0.882) Z S
      (0.21 0.924) L (0.714 0.924) Z S (0.21 0.966) L (0.714 0.966) Z S
      (0.21 1.008) L (0.714 1.008) Z)
      (i-const (0 0 0 0.5)))
    (i-cut
      (outline (width 0.004) (cap Butt) (join Miter) (miter-angle 0.200713))
      (path S (0.21 0) L (0.21 1.008) Z S (0.252 0) L (0.252 1.008) Z S
      (0.294 0) L (0.294 1.008) Z S (0.336 0) L (0.336 1.008) Z S (0.378 0) L
      (0.378 1.008) Z S (0.42 0) L (0.42 1.008) Z S (0.462 0) L (0.462 1.008) Z
      S (0.504 0) L (0.504 1.008) Z S (0.546 0) L (0.546 1.008) Z S (0.588 0) L
      (0.588 1.008) Z S (0.63 0) L (0.63 1.008) Z S (0.672 0) L (0.672 1.008) Z
      S (0.714 0) L (0.714 1.008) Z)
      (i-const (0 0 0 0.5))))
    (i-blend Over (i-cut anz (path) (i-const (1 1 0.000309598 1)))
    (i-blend Over (i-cut anz (path) (i-const (0.16186 0.0294883 0.350975 1)))
      (i-blend Over (i-cut anz (path) (i-const (1 0 0 1)))
      (i-blend Over
        (i-cut anz
        (path S (0.252 0.462) L (0.292 0.462) L (0.292 0.502) L (0.252 0.502) L
          (0.252 0.462) Z S (0.294 0.462) L (0.334 0.462) L (0.334 0.502) L
          (0.294 0.502) L (0.294 0.462) Z S (0.21 0.42) L (0.25 0.42) L
          (0.25 0.46) L (0.21 0.46) L (0.21 0.42) Z S (0.252 0.42) L
          (0.292 0.42) L (0.292 0.46) L (0.252 0.46) L (0.252 0.42) Z)
        (i-const (0.287937 0.638283 0.0782883 1)))
        (i-blend Over
        (i-cut anz
          (path S (0.21 0.504) L (0.25 0.504) L (0.25 0.544) L (0.21 0.544) L
          (0.21 0.504) Z S (0.252 0.504) L (0.292 0.504) L (0.292 0.544) L
          (0.252 0.544) L (0.252 0.504) Z S (0.294 0.504) L (0.334 0.504) L
          (0.334 0.544) L (0.294 0.544) L (0.294 0.504) Z S (0.21 0.462) L
          (0.25 0.462) L (0.25 0.502) L (0.21 0.502) L (0.21 0.462) Z)
          (i-const (1 0.527207 0 1)))
        (i-blend Over
          (i-cut anz
          (path S (0.21 0.672) L (0.25 0.672) L (0.25 0.712) L (0.21 0.712) L
            (0.21 0.672) Z S (0.252 0.672) L (0.292 0.672) L (0.292 0.712) L
            (0.252 0.712) L (0.252 0.672) Z S (0.294 0.672) L (0.334 0.672) L
            (0.334 0.712) L (0.294 0.712) L (0.294 0.672) Z S (0.378 0.672) L
            (0.418 0.672) L (0.418 0.712) L (0.378 0.712) L (0.378 0.672) Z S
            (0.42 0.672) L (0.46 0.672) L (0.46 0.712) L (0.42 0.712) L
            (0.42 0.672) Z S (0.462 0.672) L (0.502 0.672) L (0.502 0.712) L
            (0.462 0.712) L (0.462 0.672) Z S (0.294 0.63) L (0.334 0.63) L
            (0.334 0.67) L (0.294 0.67) L (0.294 0.63) Z S (0.462 0.63) L
            (0.502 0.63) L (0.502 0.67) L (0.462 0.67) L (0.462 0.63) Z S
            (0.21 0.588) L (0.25 0.588) L (0.25 0.628) L (0.21 0.628) L
            (0.21 0.588) Z S (0.252 0.588) L (0.292 0.588) L (0.292 0.628) L
            (0.252 0.628) L (0.252 0.588) Z S (0.294 0.588) L (0.334 0.588) L
            (0.334 0.628) L (0.294 0.628) L (0.294 0.588) Z S (0.294 0.546) L
            (0.334 0.546) L (0.334 0.586) L (0.294 0.586) L (0.294 0.546) Z)
          (i-const (0 0.165023 0.533493 1)))
          (i-blend Over
          (i-cut anz
            (path S (0.42 0.756) L (0.46 0.756) L (0.46 0.796) L (0.42 0.796) L
            (0.42 0.756) Z S (0.462 0.756) L (0.502 0.756) L (0.502 0.796) L
            (0.462 0.796) L (0.462 0.756) Z S (0.504 0.756) L (0.544 0.756) L
            (0.544 0.796) L (0.504 0.796) L (0.504 0.756) Z S (0.546 0.756) L
            (0.586 0.756) L (0.586 0.796) L (0.546 0.796) L (0.546 0.756) Z S
            (0.42 0.714) L (0.46 0.714) L (0.46 0.754) L (0.42 0.754) L
            (0.42 0.714) Z S (0.462 0.714) L (0.502 0.714) L (0.502 0.754) L
            (0.462 0.754) L (0.462 0.714) Z S (0.504 0.714) L (0.544 0.714) L
            (0.544 0.754) L (0.504 0.754) L (0.504 0.714) Z S (0.546 0.714) L
            (0.586 0.714) L (0.586 0.754) L (0.546 0.754) L (0.546 0.714) Z)
            (i-const (0.000309598 0.43388 0.879415 1)))
          (i-const (1 1 1 1))))))))))"
  in
  let image_equal ?(epsilon) ?(check_color=false) ?(allow_translations) i1 i2 =
    if check_color then
      let di1 = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree i1)) in
        let di2 = (Compare.ManipulateVg.get_points_color (Compare.ManipulateVg.create_i_tree i2)) in
          (Compare.ManipulateVg.compare_list_colors ?epsilon ?allow_translations di1 di2)
    else
      let di1 = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree i1)) in
        let di2 = (Compare.ManipulateVg.get_points (Compare.ManipulateVg.create_i_tree i2)) in 
          (Compare.ManipulateVg.compare_list_tuples ?epsilon ?allow_translations di1 di2)
  in
  let check_color = true 
  in
  begin
    (*test without colors*)
    Printf.printf "\nStarting tests without considering colors, epsilon: %f\n" Compare.epsilon;
    (assert (image_equal tetris_j tetris_j_rotate_4_times));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" Compare.epsilon;
    (assert (image_equal ~check_color tetris_j tetris_j_rotate_4_times));
    Printf.printf "Done\n";
  end;
  begin
    (*test without colors*)
    Printf.printf "\nStarting tests without considering colors, epsilon: %f\n" Compare.epsilon;
    (assert (image_equal tetris_z tetris_z_different_color));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" Compare.epsilon;
    (assert ((image_equal ~check_color tetris_z tetris_z_different_color)==false));
    Printf.printf "Done\n";
  end;
  begin
    (*test without colors*)
    Printf.printf "\nStarting tests without considering colors, epsilon: %f\n" Compare.epsilon;
    (assert ((image_equal tetris_z tetris_z_decale)==false));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" Compare.epsilon;
    (assert ((image_equal ~check_color tetris_z tetris_z_decale)==false));
    Printf.printf "Done\n";
  end;
  let allow_translations = true in
  begin
    (*test without colors*)
    Printf.printf "\nStarting tests without considering colors, epsilon: %f\n" Compare.epsilon;
    (assert (image_equal ~allow_translations tetris_z tetris_z_decale));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" Compare.epsilon;
    (assert (image_equal ~check_color ~allow_translations tetris_z tetris_z_decale));
    Printf.printf "Done\n";
  end;
  let epsilon = 1e-4 in
  begin
    (*test without colors, greater epsilon*)
    Printf.printf "\nStarting tests without considering colors, epsilon: %f\n" epsilon;
    (assert (image_equal ~epsilon tetris_j tetris_j_rotate_4_times));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors, greater epsilon*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" epsilon;
    (assert (image_equal ~check_color ~epsilon tetris_j tetris_j_rotate_4_times));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors, greater epsilon*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" epsilon;
    (assert ((image_equal ~check_color ~epsilon tetris_board_easy tetris_board)==false));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors, greater epsilon*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" epsilon;
    (assert (image_equal ~check_color ~epsilon tetris_board tetris_board));
    Printf.printf "Done\n";
  end;
  let epsilon = 1e-6 in
  begin
    (*test without colors, greater epsilon*)
    Printf.printf "\nStarting tests without considering colors, epsilon: %f\n" epsilon;
    (assert ((image_equal ~epsilon tetris_j tetris_j_rotate_4_times)==false));
    Printf.printf "Done\n";
  end;
  begin
    (*test with colors, greater epsilon*)
    Printf.printf "Starting tests considering colors, epsilon: %f\n" epsilon;
    (assert ((image_equal ~check_color ~epsilon tetris_j tetris_j_rotate_4_times)==false));
    Printf.printf "Done\n";
  end;
  Printf.printf "\nEnd of tests for for image equal\n\n";;


(** Do all the tests at once. *)
let main () =
  Printf.printf "Starting tests\n\n\n";
  Intermediate_string_manipulation.tests_intermediate_string_manipulation();
  Token_getters.tests_token_getters();
  Intermediate_paths_manipulation.tests_intermediate_paths_manipulation();
  Intermediate_i_tree_manipulation.tests_intermediate_i_tree_manipulation();
  I_tree_manipulation.tests_i_tree_manipulation();
  test_image_equal();
  Printf.printf "\nEnd of tests, everything's okay\n\n";;


let () = main();;