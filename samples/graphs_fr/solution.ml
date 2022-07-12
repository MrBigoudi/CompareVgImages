(* Question 1 *)
let x_axis p = 
  let line a = Vg.P.line (Gg.P2.v x_max y_origin) (Vg.P.sub (Gg.P2.v x_min y_origin) a) in
  let arrow1 a = Vg.P.line (Gg.P2.v x_max y_origin) (Vg.P.sub (Gg.P2.v (x_max-.arrow_length) (y_origin-.arrow_length)) a) in
  let arrow2 a = Vg.P.line (Gg.P2.v x_max y_origin) (Vg.P.sub (Gg.P2.v (x_max-.arrow_length) (y_origin+.arrow_length)) a) in
  p |> line |> arrow1 |> arrow2;;

let y_axis p = 
  let line a = Vg.P.line (Gg.P2.v x_origin y_max) (Vg.P.sub (Gg.P2.v x_origin y_min) a) in
  let arrow1 a = Vg.P.line (Gg.P2.v x_origin y_max) (Vg.P.sub (Gg.P2.v (x_origin-.arrow_length) (y_max-.arrow_length)) a) in
  let arrow2 a = Vg.P.line (Gg.P2.v x_origin y_max) (Vg.P.sub (Gg.P2.v (x_origin+.arrow_length) (y_max-.arrow_length)) a) in
  p |> line |> arrow1 |> arrow2;;

let draw_basis () =
  let p1 a = x_axis a in
  let p2 a = y_axis a in
  let p = Vg.P.empty |> p1 |> p2 in
  draw_config p;;


(* Question 2 *)
let graph_f_int f bounds scale = 
  let (min,max) = bounds in
  let (x_scale,y_scale) = scale in
  if min>max then failwith "Invalid bounds exception"
  else
    let rec create_path cpt p = match cpt with
      | cpt when cpt>max -> p
      | _ -> let y = y_origin+.y_scale*.(float_of_int (f cpt)) in
          let x = x_origin+.x_scale*.(float_of_int cpt) in
          let new_p = (dot x y p dot_width_int) in
          (create_path (cpt+1) new_p)
    in P.empty |> (create_path min);;


(* Question 3 *)
let rectangle x y w p =
  let rel = true in
  p |>
  P.sub (P2.v x y) |>
  P.line ~rel (P2.v w 0.) |>
  P.line ~rel (P2.v 0. (y_origin-.y)) |>
  P.line ~rel (P2.v (-.w) 0.) |>
  P.close;;

let graph_f_int_hist f bounds scale width =
  let (min,max) = bounds in
  let (x_scale,y_scale) = scale in
  if min>max then failwith "Invalid bounds exception"
  else
    let rec create_path cpt p = match cpt with
      | cpt when cpt>max -> p
      | _ -> let y = y_origin+.y_scale*.(float_of_int (f cpt)) in
          let x = x_origin+.x_scale*.(float_of_int cpt) in
          let new_p = (rectangle (x-.(width/.2.)) y width p) in
          (create_path (cpt+1) new_p)
    in P.empty |> (create_path min);;


(* Question 4 *) 
let wrong_number = 0.4242424242;;
let epsilon = 1e-10;;

let wrong y =
  let equal x = (y>(x-.epsilon))&&(y<(x+.epsilon)) in
  if (equal wrong_number) then true
  else if (y>infinity) then true
  else if (y<(-1.*.infinity)) then true
  else
    let new_y = classify_float y in 
    match new_y with
    | FP_infinite -> true
    | FP_nan -> true
    | _ -> false;;

let graph_f_float f bounds scale space = 
  let (min,max) = bounds in
  let (x_scale,y_scale) = scale in
  if min>max then failwith "Invalid bounds exception"
  else
    let rec create_path cur p = 
      match cur with
      | cur when cur > max -> p
      | _ -> 
          let y = (try (f cur) with _ -> wrong_number) in 
          if (wrong y) then 
            begin
              (*Printf.printf "wn: cur:%f, y:%f\n" cur y;*)
              (create_path (cur+.space) p);
            end
          else
            begin
              (*Printf.printf "cur:%f, y:%f\n" cur y;*)
              let y = y_origin+.y_scale*.y in
              let x = x_origin+.x_scale*.cur in
              let new_p = (dot x y p dot_width_float) in
              (create_path (cur+.space) new_p)
            end
    in P.empty |> (create_path min);;


(* Question 5*)
let graph_integral f bounds scale space width =
  let (min,max) = bounds in
  let (x_scale,y_scale) = scale in
  if min>max then failwith "Invalid bounds exception"
  else
    let rec create_path cur p = 
      match cur with
      | cur when cur > max -> p
      | _ -> 
          let y = (try y_origin+.y_scale*.(f cur) with _ -> wrong_number) in 
          if (wrong y) then (create_path (cur+.space) p)
          else 
            let x = x_origin+.x_scale*.cur in
            let new_p = (rectangle (x-.(width/.2.)) y width p) in
            (create_path (cur+.space) new_p)
    in P.empty |> (create_path min);;
    

(* Question 6 *)
let bounds = (-10.,10.);;
let scale = (0.1,0.1);;
let space = 0.001;;

let graph_multiple f_list colors = 
  let rec aux fs cs acc = match (fs,cs) with
    | ([],_) -> acc
    | (_,[]) -> failwith "Not enough colors"
    | (f::fs,c::cs) -> 
                let new_i = I.const c |> I.cut (graph_f_float f bounds scale space) in
                  (aux fs cs (I.blend new_i acc))
  in (aux f_list colors (draw_basis()));;