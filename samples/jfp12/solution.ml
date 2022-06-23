let print_matrice m =
  let l = Array.length m in
  let c = Array.length m.(0) in
  let rec print_line line cpt = match cpt with
    | a when a==c -> Printf.printf "\n"
    | _ -> (if (line.(cpt)==0) then Printf.printf "." 
            else Printf.printf "%d" (line.(cpt))); (print_line line (cpt+1))
  in 
  let rec aux cpt = match cpt with
    | a when a==l -> Printf.printf "\n"
    | _ -> (print_line (m.(cpt)) 0); (aux (cpt+1))
  in (aux 0);;

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
  let rec aux i j acc =
    match (i,j) with
    | (a,b) when (l+a-up)>=(l_matrix) || (c+b-left)>=(c_matrix) -> m
    | (a,_) when a>down -> acc
    | (_,b) when b>right -> (aux (i+1) left acc)
    | (a,b) when (piece.(a)).(b)<=0 -> (aux i (j+1) acc)
    | (a,b) when (piece.(a)).(b)>0 && (m.(a+l-up)).(b+c-left)>0-> m
    | _ -> let cur = (piece.(i)).(j) in
        (Array.set (acc.(i+l-up)) (j+c-left) cur); 
        (aux i (j+1) acc)
  in (aux up left (copy_matrix m));;


let init_matrix l c =
  (Array.make_matrix l c 0);;


let gen_matrice l =
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

let create_square_path x y l = 
  let p = 
    let rel = true in
    P.empty |>
    P.sub (P2.v x y) |>
    P.line ~rel (P2.v l 0.) |>
    P.line ~rel (P2.v 0. l) |>
    P.line ~rel (P2.v (-1.*.l) 0.) |>
    P.line ~rel (P2.v 0. (-1.*.l)) |>
    P.close
  in p;;

let create_square x y l color = 
  let p = create_square_path x y l
  in I.const color |> I.cut p;;

let create_square_outline x y l color w = 
  let p = create_square_path x y l
  in let area = `O { P.o with P.width = w } in
  I.const color |> I.cut ~area p;;

let create_square_with_outline x y l color w = 
  let shade = create_shade color in
  let square = create_square x y l color in
  let outline = create_square_outline x y l shade w in
  (I.blend square outline);;

let i_couleur = create_color 0.004 0.690 0.945;;
let j_couleur = create_color 0. 0.443 0.757;;
let l_couleur = create_color 1. 0.753 0.;;
let s_couleur = create_color 0.573 0.82 0.31;;
let z_couleur = create_color 1. 0. 0.;;
let t_couleur = create_color 0.439 0.188 0.627;;
let o_couleur = create_color 1. 1. 0.004;;


let create_block n x y l w = 
  match n with
  | 1 -> create_square_with_outline x y l i_couleur w 
  | 2 -> create_square_with_outline x y l j_couleur w
  | 3 -> create_square_with_outline x y l l_couleur w 
  | 4 -> create_square_with_outline x y l s_couleur w
  | 5 -> create_square_with_outline x y l z_couleur w 
  | 6 -> create_square_with_outline x y l t_couleur w
  | 7 -> create_square_with_outline x y l o_couleur w 
  | _ -> failwith "unknown block";;


let draw_grid
  

let draw_tetris m =
  let l = Array.length m in
  let c = Array.length (m.(0)) in
  let len = 0.04 in
  let w = (len/.10.) in
  let rec aux i j acc =
    match i,j with
    | (i,_) when i>=l -> acc
    | (_,j) when j>=c -> (aux (i+1) 0 acc)
    | _ -> let n = (m.(i)).(j) in
        let x = (float_of_int (c/2+j+1))*.(len+.(w/.2.)) in
        let y = (float_of_int (l-i+1))*.(len+.(w/.2.)) in
        (aux i (j+1) (I.blend (create_block n x y len w) acc))
  in (aux 0 0 (I.const Color.white));;


let l = [(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)];;
let m = (gen_matrice l);;

(print_matrice m);;
(draw_tetris m);;









