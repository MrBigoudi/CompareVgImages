(*Question 1*)
let get_n_termes_T s n =
  let get_val x = x lsr 13 in
  let power_16 =
    let rec aux cpt acc = match cpt with
      | 0 -> acc
      | _ -> (aux (cpt-1) (2*acc)) 
    in (aux 16 1) 
  in
  let get_next x = (6807*x-1) mod power_16 in
  let rec aux cpt acc un = match cpt with
    | 0 -> acc
    | _ -> let new_val = (get_next un) in
        let shifted = (get_val un) in
        if (shifted==0) then (aux cpt acc new_val)
        else (aux (cpt-1) (acc@[shifted]) new_val)
  in (aux n [] s);;

(*Question 2*)
let check_quadruplet p l c l_max c_max= 
  if p<1 || p>7 then false
  else if l<0 || l>=l_max then false
  else if c<0 || c>=c_max then false
  else true;;

let copy_matrix m = 
  let l = Array.length m in
  let c = Array.length (m.(0)) in
  let rec aux cpt acc = match cpt with
    | 0 -> acc
    | _ -> acc.(cpt) <- (Array.copy (m.(cpt))); (aux (cpt-1) acc)
  in (aux (l-1) (Array.make_matrix l c 0));;

let transpose m =
  let l = Array.length m in
  let c = Array.length (m.(0)) in
  let rec aux i j acc = match (i,j) with
    | (a,_) when (a>=l) -> acc
    | (_,b) when (b>=c) -> (aux (i+1) 0 acc)
    | _ -> begin (acc.(j)).(i) <- (m.(i)).(j); (aux i (j+1) acc) end
  in (aux 0 0 (copy_matrix m));;

let reverseRows m =
  let len = Array.length m in
  let rec aux i k acc = match (i,k) with
    | (a,b) when a>=b -> acc
    | _ -> let tmp = (Array.copy (m.(i))) in
        acc.(i) <- (Array.copy (acc.(k)));
        acc.(k) <- tmp;
        (aux (i+1) (k-1) acc)
  in (aux 0 (len-1) (copy_matrix m));;

let reverseCols m =
  let line = Array.length m in
  let col = Array.length (m.(0)) in
  let rec aux i j k acc = match (i,j,k) with
    | (a,b,c) when (a>=(line-1) && b>=c) -> acc
    | (_,b,c) when b>=c -> (aux (i+1) 0 (col-1) acc)
    | _ -> let tmp = (acc.(i)).(j) in
        (acc.(i)).(j) <- (acc.(i)).(k);
        (acc.(i)).(k) <- tmp;
        (aux i (j+1) (k-1) acc)
  in (aux 0 0 (col-1) (copy_matrix m));;

let rotate_90_cw m = (transpose (reverseRows m));;
let rotate_90_ccw m = (reverseRows (transpose m));;
let rotate_180 m = (reverseRows (reverseCols m));;

let rotate_matrix m r =
  let r = r mod 4 in
  match r with
  | 0 -> m
  | 1 -> rotate_90_cw m
  | 2 -> rotate_180 m
  | _ -> rotate_90_ccw m
;;

let piece_i =  [|
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|1;1;1;1|]|];;

let piece_j = [|
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|2;2;2;0|];
  [|0;0;2;0|]|];;


let piece_l = [|
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|3;3;3;0|];
  [|3;0;0;0|]|];;

let piece_s = [|
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|0;4;4;0|];
  [|4;4;0;0|]|];;

let piece_z = [|
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|5;5;0;0|];
  [|0;5;5;0|]|];;

let piece_t = [|
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|6;6;6;0|];
  [|0;6;0;0|]|];;

let piece_o = [|
  [|0;0;0;0|];
  [|0;0;0;0|];
  [|7;7;0;0|];
  [|7;7;0;0|]|];;

let get_piece_r n r =
  match n with
  | 1 -> (rotate_matrix piece_i r)
  | 2 -> (rotate_matrix piece_j r)
  | 3 -> (rotate_matrix piece_l r)
  | 4 -> (rotate_matrix piece_s r)
  | 5 -> (rotate_matrix piece_z r)
  | 6 -> (rotate_matrix piece_t r)
  | 7 -> (rotate_matrix piece_o r)
  | _ -> failwith "Unknown piece";;

let get_pos piece =
  let l = Array.length piece in
  let c = Array.length (piece.(0)) in
  let rec aux i j left right up down =
    match (i,j) with
    | (i,_) when i>=l -> (left,right,up,down)
    | (_,j) when j>=c -> (aux (i+1) 0 left right up down)
    | _ -> if (piece.(i)).(j) <= 0 then (aux i (j+1) left right up down)
        else if j<left then (aux i j j right up down)
        else if j>right then (aux i j left j up down)
        else if i<up then (aux i j left right i down)
        else if i>down then (aux i j left right up i)
        else (aux i (j+1) left right up down)
  in (aux 0 0 (c-1) 0 (l-1) 0);;

let place_piece piece m l c =
  let l_matrix = Array.length m in
  let c_matrix = Array.length (m.(0)) in
  let (left,right,up,down) = (get_pos piece) in
  let rec aux i j acc =match (i,j) with
    | (i,_) when i>down -> acc
    | (_,j) when j>right -> (aux (i+1) left acc)
    | (i,j) when (l+i-up)>=(l_matrix) || (c+j-left)>=(c_matrix) -> m 
    | (i,j) when (piece.(i)).(j)<=0 -> (aux i (j+1) acc)
    | (i,j) when (piece.(i)).(j)>0 && (m.(i+l-up)).(c+j-left)>0-> m
    | _ -> let cur = (piece.(i)).(j) in
        (Array.set (acc.(i+l-up)) (j+c-left) cur); 
        (aux i (j+1) acc)
  in (aux up left (copy_matrix m));;


let init_matrix l c =
  (Array.make_matrix l c 0);;


let gen_matrix l =
  let l_max = 24 in
  let c_max = 12 in
  let m = (init_matrix l_max c_max) in 
  let rec aux l acc = match l with
    | [] -> acc
    | (p,l,c,r)::t -> if (check_quadruplet p l c l_max c_max) then
          let piece = (get_piece_r p r) in 
          let m = (place_piece piece acc l c) in
          (aux t m)
        else (aux t acc)
  in (aux l (copy_matrix m));;


(*Question 2.5*)
let create_color r g b = Color.v_srgb r g b;;

let create_shade color = 
  let quart = 3. /. 4. in
  let (r,g,b) = (Color.r color, Color.g color, Color.b color) in
  create_color (r*.quart) (g*.quart) (b*.quart);;

let i_couleur = create_color 0.004 0.690 0.945;;
let j_couleur = create_color 0. 0.443 0.757;;
let l_couleur = create_color 1. 0.753 0.;;
let s_couleur = create_color 0.573 0.82 0.31;;
let z_couleur = create_color 1. 0. 0.;;
let t_couleur = create_color 0.439 0.188 0.627;;
let o_couleur = create_color 1. 1. 0.004;;

let grid_couleur = Color.black;;

let line_subpath init_p xi yi xf yf =
  let p = 
    init_p |>
    P.sub (P2.v xi yi) |>
    P.line (P2.v xf yf) |>
    P.close
  in p;;

let lines_path n len space x y =
  let xf = x+.len in
  let rec aux n y acc = match n with
    | 0 -> acc 
    | _ -> (aux (n-1) (y+.space) (line_subpath acc x y xf y))
  in (aux n y P.empty);;

let cols_path n len space x y =
  let yf = y+.len in
  let rec aux n x acc = match n with
    | 0 -> acc 
    | _ -> (aux (n-1) (x+.space) (line_subpath acc x y x yf))
  in (aux n x P.empty);;

let grid_path line col len x y =
  let l_path = (lines_path (line+1) ((float_of_int col)*.len) len x y) in
  let c_path = (cols_path (col+1) ((float_of_int line)*.len) len x y) in
  (l_path,c_path);;

let draw_grid line col len w x y color =
  let area = `O { P.o with P.width = w } in
  let (l_path,c_path) = grid_path line col len x y in
  let draw_l = (I.const color |> I.cut ~area l_path) in
  let draw_c = (I.const color |> I.cut ~area c_path) in
  (I.blend draw_l draw_c);;

let create_square_path init_p x y l = 
  let p = 
    let rel = true in
    init_p |>
    P.sub (P2.v x y) |>
    P.line ~rel (P2.v l 0.) |>
    P.line ~rel (P2.v 0. l) |>
    P.line ~rel (P2.v (-1.*.l) 0.) |>
    P.line ~rel (P2.v 0. (-1.*.l)) |>
    P.close
  in p;;

let block_path_n block_number m len w =
  let l = Array.length m in
  let c = Array.length (m.(0)) in
  let next_x j = (float_of_int (c/2+j-1))*.(len+.(w/.2.)) in
  let next_y i = (float_of_int (l-i-1))*.(len+.(w/.2.)) in
  let rec aux acc i j = match (i,j) with
    | (i,_) when i>=l -> acc
    | (_,j) when j>=c -> (aux acc (i+1) 0)
    | _ -> let n = (m.(i)).(j) in
        if n<>block_number then (aux acc i (j+1))
        else
          let x = next_x j in
          let y = next_y i in
          (aux (create_square_path acc x y len) i (j+1))
  in (aux P.empty 0 0);;

let draw_tetris m =
  let l = Array.length m in
  let c = Array.length (m.(0)) in
  let len = 0.04 in
  let w = (len/.10.) in
  let next_x j = (float_of_int (c/2+j-1))*.(len+.(w/.2.)) in
  let next_y i = (float_of_int (l-i-1))*.(len+.(w/.2.)) in
  let x0 = (next_x 0) in
  let y0 = (next_y (l-1)) in
  let grille = (draw_grid l c (len+.(w/.2.)) w x0 y0 grid_couleur) in
  let rec aux n acc =
    match n with
    | 1 -> let new_image = (I.cut (block_path_n 1 m len w) (I.const i_couleur)) in
            (aux (n+1) (I.blend new_image acc)) 
    | 2 -> let new_image = (I.cut (block_path_n 2 m len w) (I.const j_couleur)) in
            (aux (n+1) (I.blend new_image acc))
    | 3 -> let new_image = (I.cut (block_path_n 3 m len w) (I.const l_couleur)) in
            (aux (n+1) (I.blend new_image acc)) 
    | 4 -> let new_image = (I.cut (block_path_n 4 m len w) (I.const s_couleur)) in
            (aux (n+1) (I.blend new_image acc))
    | 5 -> let new_image = (I.cut (block_path_n 5 m len w) (I.const z_couleur)) in
            (aux (n+1) (I.blend new_image acc)) 
    | 6 -> let new_image = (I.cut (block_path_n 6 m len w) (I.const t_couleur)) in
            (aux (n+1) (I.blend new_image acc))
    | 7 -> let new_image = (I.cut (block_path_n 7 m len w) (I.const o_couleur)) in
            (aux (n+1) (I.blend new_image acc)) 
    | _ -> acc
  in 
  let pieces = (aux 1 (I.const Color.void)) in
    (I.blend grille pieces);;

(*Question 3*)
let matrix_equals m1 m2 =
  let l1 = Array.length m1 in
  let l2 = Array.length m2 in
  let c1 = Array.length (m1.(0)) in
  let c2 = Array.length (m2.(0)) in
  if (c1<>c2 || l1<>l2) then false
  else
    let rec aux i j = match (i,j) with
      | (i,_) when i>=l1 -> true
      | (_,j) when j>=c1 -> (aux (i+1) 0)
      | _ -> if (m1.(i)).(j)<>(m2.(i)).(j) then false
          else (aux i (j+1))
    in (aux 0 0);;

let gen_matrix_gravity l =
  let l_max = 24 in
  let c_max = 12 in
  let m = (init_matrix l_max c_max) in 
  let rec aux list cur_l last_m acc = match list with
    | [] -> acc
    | (p,c,r)::t -> if cur_l>=l_max then (aux t 4 last_m last_m)
        else
          begin
            if (check_quadruplet p cur_l c l_max c_max) then
              begin 
                let piece = (get_piece_r p r) in 
                let m = (place_piece piece acc cur_l c) in
                if (matrix_equals m acc) then (aux t 4 last_m last_m)
                else (aux ((p,c,r)::t) (cur_l+1) m acc)
              end
            else begin Printf.printf "wrong quad\n"; (aux t 4 acc acc) end
          end
  in (aux l 4 (copy_matrix m) (copy_matrix m));;


(*Question 4*)
let not_empty_lines m i_min i_max =
  let c_max = Array.length m.(0) in
  let rec aux i j = match (i,j) with
    | (i,_) when i>=i_max -> false
    | (_,j) when j>=c_max -> (aux (i+1) 0)
    | (i,j) -> if (m.(i)).(j) <> 0 then true
              else (aux i (j+1))
  in (aux i_min 0);;

let delete_line n m =
  let c_max = Array.length (m.(0)) in 
  let rec aux i j acc = 
    (* Printf.printf "i:%d, j:%d\n" i j; *)
    match (i,j) with
    | ((-1),_) -> acc
    | (_,j) when j>=c_max -> (aux (i-1) 0 acc)
    | (0,_) -> (acc.(i)).(j) <- 0; (aux i (j+1) acc);
    | _ -> (acc.(i)).(j) <- (acc.(i-1)).(j); 
            (aux i (j+1) acc)
  in (aux n 0 (copy_matrix m));;

let line_complete n m = 
  let c_max = Array.length (m.(0)) in 
  let rec aux j = match j with
    | j when j>=c_max -> true
    | _ -> if (m.(n)).(j) == 0 then false
            else (aux (j+1))
  in (aux 0);;

let update_completed_lines m cur_score =
  let l_max = Array.length m in 
  let rec aux i acc cpt score = 
    match i with
    | i when i>=l_max -> 
      if cpt>=4 then (acc,(score+800))
      else (acc,(cpt*100+score))
    | _ -> if (line_complete i m) 
            then
              begin
                (* Printf.printf "delete line\n"; *)
                let acc = (delete_line i acc) in 
                (* Printf.printf "done delete\n"; *)
                if cpt>=4 then (aux (i+1) acc 0 (score+800))
                  else (aux (i+1) acc (cpt+1) score);
              end
            else
              (aux (i+1) acc 0 (cpt*100+score))
  in (aux 0 (copy_matrix m) 0 cur_score);;
    (* let rec while_complete_lines m1 m2 score =
      let (m_after,score1) = (aux 0 m2 0 score) in
        if matrice_equals m_after m1 then (m1,score)
          else (while_complete_lines m_after m_after score1)
    in (while_complete_lines (copy_matrix m) (copy_matrix m) cur_score);; *)

let calcul_score s l = 
  let l_max = 24 in
  let c_max = 12 in
  let m = (init_matrix l_max c_max) in
  let t_sequence = (get_n_termes_T s (List.length l)) in
  let score = 0 in
  let rec aux t_seq list cur_l last_m acc score = 
    (*if 4 first lines aren't empty*)
    (* Printf.printf "not empty\n"; *)
    if (not_empty_lines acc 0 4) then (acc,score)
    else
      begin
        (* Printf.printf "aux\n"; *)
        match (list,t_seq) with
          | ([],_) -> (acc,score)
          | (_,[]) -> failwith "Error calcul_score : t_sequence too short"
          | ((p,c,r)::t, real_p::t2) -> 
            (*wrong piece*)
            if p<>real_p 
            then 
              begin
                (* Printf.printf "(p,c,r): (%d,%d,%d), real_p: %d\n" p c r real_p; *)
                (acc,score)
              end
            else
              if cur_l>=l_max then 
                begin
                  (* Printf.printf "update_completed1\n"; *)
                  let (acc,score) = (update_completed_lines last_m score) in
                    (* Printf.printf "update_completed1\n"; *)
                    (aux t2 t 4 acc acc score)
                end
              else
                begin
                  (* Printf.printf "check_quad\n"; *)
                  if (check_quadruplet p cur_l c l_max c_max) then
                    begin 
                      (* Printf.printf "check_quad\n"; *)
                      (* Printf.printf "get_piece\n"; *)
                      let piece = (get_piece_r p r) in 
                      (* Printf.printf "get_piece\n"; *)
                      (* Printf.printf "place_piece: %d, c: %d\n" cur_l c; *)
                      (* print_matrice piece; *)
                      (* print_matrice acc; *)
                      let m = (place_piece piece acc cur_l c) in
                      (* Printf.printf "place_piece\n"; *)
                      if (matrix_equals m acc) 
                        then 
                          begin
                            (* Printf.printf "update_completed2\n"; *)
                            let (acc,score) = (update_completed_lines last_m score) in
                              (* Printf.printf "update_completed2\n"; *)
                              (aux t2 t 4 acc acc score)
                          end
                      else (aux (real_p::t2) ((p,c,r)::t) (cur_l+1) m acc score)
                    end
                  else begin Printf.printf "wrong quad\n"; (aux t2 t 4 acc acc score) end
                end
        end
  in (aux t_sequence l 4 (copy_matrix m) (copy_matrix m) score);;

(*Question 5*)
(* get the value of a piece if placed on a certain column *)
let get_column_value_r m1 piece p c =
  let (left,right,up,down) = (get_pos piece) in
  let l_max = Array.length m1 in
  let c_max = Array.length (m1.(0)) in
  let rec create_mat cur_l last_m last_l acc =
    if cur_l>=l_max then (last_m,last_l)
    else
      begin
        if (check_quadruplet p cur_l c l_max c_max) then
          begin 
            (* Printf.printf "quad ok\n"; *)
            let m = (place_piece piece acc cur_l c) in
              if (matrix_equals m acc) then (last_m,last_l)
              else (create_mat (cur_l+1) m cur_l acc)
          end
        else 
          (last_m,last_l)
      end
  in 
  let (m,index) = (create_mat 4 (copy_matrix m1) 4 (copy_matrix m1))
  in
  if (index==(-1)) then (-1,-1,m1)
  else
  (* else
    (* get the number of pieces that touche vertically a new placed piece *)
    let rec get_nb_contact_vert i j acc =
      (* Printf.printf "contact_vert : (i,j)=(%d,%d)\n" i j;  *)
      match (i,j) with
      | (_,j) when j>=c_max || j>=c+(right-left) -> acc
      | (i,j) when i<0 || i<=index-(up-down) -> (get_nb_contact_vert index (j+(right-left)) acc)
      | _ -> if (m.(i)).(j) == p then 
                if j>=1 then
                  if (m.(i)).(j-1)<>0 then (get_nb_contact_vert (i-1) j (acc+1))
                  else (get_nb_contact_vert (i-1) j acc)
                else (get_nb_contact_vert index (j+(right-left)) acc)
              else (get_nb_contact_vert (i-1) (j+(right-left)) acc)
    in
    (* get the number of pieces that touche horizontally a new placed piece *)
    let rec get_nb_contact_horiz j acc =
      (* Printf.printf "contact_horiz : j=%d\n" j;  *)
      match j with
      | j when j>=c_max || j>=c+(right-left) -> acc
      | _ -> if (m.(index)).(j) == p then
                if (m.(index+1)).(j)<>0 then (get_nb_contact_horiz (j+1) (acc+1))
                else (get_nb_contact_horiz (j+1) acc)
              else (get_nb_contact_horiz (j+1) acc)
    in  *)
      (* if index<l_max-1 then 
        ((get_nb_contact_vert index c 0)+(get_nb_contact_horiz c 0)+index-(up-down),index,m)
      else
        ((get_nb_contact_vert index c 0)+index+(right-left)-(up-down),index,m);; *)
    (index-(up-down),index,m);;


(* get the value of a piece if placed on a certain column *)
let get_column_value m p c =
  let rec best_rotation r max_i max res cur_m = 
    (* Printf.printf "best_rotation : r=%d\n" r; *)
    let piece = get_piece_r p r in 
      match r with
        | 4 -> (max,res,max_i,cur_m)
        | _ -> let (new_value,index,new_m) = (get_column_value_r m piece p c) in
                if index>max_i then (best_rotation (r+1) index new_value r new_m)
                (* else if (index==max_i && new_value>max) then 
                  (best_rotation (r+1) index new_value r new_m) *)
                else (best_rotation (r+1) max_i max res cur_m)
  in (best_rotation 0 (-1) 0 (-1) m);;

let best_column m p =
  let c_max = Array.length (m.(0)) in
    let rec best_c cur_c max res_c res_r res_i res_m = 
      (* Printf.printf "best_c : cur_c=%d\n" cur_c; *)
      match cur_c with
      | c when c>=c_max -> (res_c,res_r,res_i,res_m)
      | c -> let (new_value,new_r,new_i,new_m) = (get_column_value m p c) in
              if new_value>max then (best_c (c+1) new_value c new_r new_i new_m)
              else (best_c (c+1) max res_c res_r res_i res_m)
  in (best_c 0 (-1) 0 0 (-1) m);;


let gen_list s = 
  let t_list = get_n_termes_T s 100 in
  let l_max = 24 in
  let c_max = 12 in
  let m = (init_matrix l_max c_max) in 
  let rec aux t cur_m acc = match t with
    | [] -> acc
    | p::tl -> let (c,r,i,new_m) = (best_column cur_m p) in
                if (i==(-1)) then (aux tl cur_m ([(p,c,r)]@acc))
                else (aux tl new_m (acc@[(p,c,r)]))
  in (aux t_list m []);;