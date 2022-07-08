(* Question 1 *)
let x_axis p = 
  let line a = Vg.P.line (Gg.P2.v x_max y_origin) (Vg.P.sub (Gg.P2.v x_origin y_origin) a) in
  let arrow1 a = Vg.P.line (Gg.P2.v x_max y_origin) (Vg.P.sub (Gg.P2.v (x_max-.arrow_length) (y_origin-.arrow_length)) a) in
  let arrow2 a = Vg.P.line (Gg.P2.v x_max y_origin) (Vg.P.sub (Gg.P2.v (x_max-.arrow_length) (y_origin+.arrow_length)) a) in
  p |> line |> arrow1 |> arrow2;;

let y_axis p = 
  let line a = Vg.P.line (Gg.P2.v x_origin y_max) (Vg.P.sub (Gg.P2.v x_origin y_origin) a) in
  let arrow1 a = Vg.P.line (Gg.P2.v x_origin y_max) (Vg.P.sub (Gg.P2.v (x_origin-.arrow_length) (y_max-.arrow_length)) a) in
  let arrow2 a = Vg.P.line (Gg.P2.v x_origin y_max) (Vg.P.sub (Gg.P2.v (x_origin+.arrow_length) (y_max-.arrow_length)) a) in
  p |> line |> arrow1 |> arrow2;;

let draw_basis () =
  let p1 a = x_axis a in
  let p2 a = y_axis a in
  let p = Vg.P.empty |> p1 |> p2 in
  draw_config p;;


(* Question 2 *)
let graph_f_int f n x_scale y_scale = 
  let rec create_path cpt p = match cpt with
    | -1 -> p
    | _ -> let y = y_origin+.y_scale*.(float_of_int (f cpt)) in
        let x = x_origin+.x_scale*.(float_of_int cpt) in
        let new_p = (dot x y p) in
        (create_path (cpt-1) new_p)
  in P.empty |> (create_path (n-1));;


(* Question 3 *)
let rectangle x y w p =
  let rel = true in
    p |>
    P.sub (P2.v x y) |>
    P.line ~rel (P2.v w 0.) |>
    P.line ~rel (P2.v 0. (y_origin-.y)) |>
    P.line ~rel (P2.v (-.w) 0.) |>
    P.close;;

let graph_f_int_hist f n x_scale y_scale w =
  let rec create_path cpt p = match cpt with
    | -1 -> p
    | _ -> let y = y_origin+.y_scale*.(float_of_int (f cpt)) in
        let x = x_origin+.x_scale*.(float_of_int cpt) in
        let new_p = (rectangle (x-.(w/.2.)) y w p) in
        (create_path (cpt-1) new_p)
  in P.empty |> (create_path (n-1));;


let f n = n;;
let i1 = (I.const Color.black) |> (I.cut (graph_f_int f 10 0.1 0.1)) in
let i2 = (I.const Color.red) |> (I.cut (graph_f_int_hist f 10 0.1 0.1 0.05)) in
(I.blend i2 (I.blend i1 (draw_basis())));;



