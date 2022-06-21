open Gg;;
open Vg;;

(*Question 1*)
let create_color r g b a = Color.v_srgb r g b ~a;;

(*Question 2*)
let create_circle x y color r = 
  let p = 
    let rel = true in
    P.empty |>
    P.sub (P2.v x y) |>
    P.circle ~rel (P2.v 0. 0.) r |>
    P.close
  in I.const color |> I.cut p;;

(*Question 3*)
let create_dot_square x y l color r = 
  let cercle1 = create_circle x y color r in
  let cercle2 = create_circle (x+.l) y color r in
  let cercle3 = create_circle x (y+.l) color r in
  let cercle4 = create_circle (x+.l) (y+.l) color r in
  (I.blend cercle1 (I.blend cercle2 (I.blend cercle3 cercle4)));;
    
(*Question 4*)
let create_shade color = 
  let quart = 3. /. 4. in
  let (r,g,b,a) = (Color.r color, Color.g color, Color.b color, Color.a color) in
  create_color (r*.quart) (g*.quart) (b*.quart) a;;

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


(*Question 5*)
let j_couleur = create_color 0. 0.443 0.757 1.;;
let l_couleur = create_color 1. 0.753 0. 1.;;
let o_couleur = create_color 1. 1. 0.004 1.;;
let s_couleur = create_color 0.573 0.82 0.31 1.;;
let t_couleur = create_color 0.439 0.188 0.627 1.;;
let z_couleur = create_color 1. 0. 0. 1.;;
let i_couleur = create_color 0.004 0.690 0.945 1.;;

let create_block_j x y l = 
  let w = (l/.10.) in
  let composant1 = create_square_with_outline x y l j_couleur w in
  let composant2 = create_square_with_outline x (y+.l+.(w/.2.)) l j_couleur w in
  let composant3 = create_square_with_outline (x+.l+.(w/.2.)) y l j_couleur w in
  let composant4 = create_square_with_outline (x+.(2.*.(l+.(w/.2.)))) y l j_couleur w in
  (I.blend composant1 (I.blend composant2 (I.blend composant3 composant4)));;


let create_block_l x y l = 
  let w = (l/.10.) in
  let composant1 = create_square_with_outline x y l l_couleur w in
  let composant2 = create_square_with_outline (x+.l+.(w/.2.)) y l l_couleur w in
  let composant3 = create_square_with_outline (x+.(2.*.(l+.(w/.2.)))) y l l_couleur w in
  let composant4 = create_square_with_outline (x+.(2.*.(l+.(w/.2.)))) (y+.l+.(w/.2.)) l l_couleur w in
  (I.blend composant1 (I.blend composant2 (I.blend composant3 composant4)));;


let create_block_o x y l = 
  let w = (l/.10.) in
  let composant1 = create_square_with_outline x y l o_couleur w in
  let composant2 = create_square_with_outline (x+.l+.(w/.2.)) y l o_couleur w in
  let composant3 = create_square_with_outline x (y+.l+.(w/.2.)) l o_couleur w in
  let composant4 = create_square_with_outline (x+.l+.(w/.2.)) (y+.l+.(w/.2.)) l o_couleur w in
  (I.blend composant1 (I.blend composant2 (I.blend composant3 composant4)));;

let create_block_s x y l = 
  let w = (l/.10.) in
  let composant1 = create_square_with_outline x y l s_couleur w in
  let composant2 = create_square_with_outline (x+.l+.(w/.2.)) y l s_couleur w in
  let composant3 = create_square_with_outline (x+.l+.(w/.2.)) (y+.l+.(w/.2.)) l s_couleur w in
  let composant4 = create_square_with_outline (x+.(2.*.(l+.(w/.2.)))) (y+.l+.(w/.2.)) l s_couleur w in
  (I.blend composant1 (I.blend composant2 (I.blend composant3 composant4)));;

let create_block_t x y l = 
  let w = (l/.10.) in
  let composant1 = create_square_with_outline x y l t_couleur w in
  let composant2 = create_square_with_outline (x+.l+.(w/.2.)) y l t_couleur w in
  let composant3 = create_square_with_outline (x+.l+.(w/.2.)) (y+.l+.(w/.2.)) l t_couleur w in
  let composant4 = create_square_with_outline (x+.(2.*.(l+.(w/.2.)))) y l t_couleur w in
  (I.blend composant1 (I.blend composant2 (I.blend composant3 composant4)));;

let create_block_z x y l = 
  let w = (l/.10.) in
  let composant1 = create_square_with_outline x (y+.l+.(w/.2.)) l z_couleur w in
  let composant2 = create_square_with_outline (x+.l+.(w/.2.)) y l z_couleur w in
  let composant3 = create_square_with_outline (x+.l+.(w/.2.)) (y+.l+.(w/.2.)) l z_couleur w in
  let composant4 = create_square_with_outline (x+.(2.*.(l+.(w/.2.)))) y l z_couleur w in
  (I.blend composant1 (I.blend composant2 (I.blend composant3 composant4)));;

let create_block_i x y l = 
  let w = (l/.10.) in
  let composant1 = create_square_with_outline x y l i_couleur w in
  let composant2 = create_square_with_outline (x+.l+.(w/.2.)) y l i_couleur w in
  let composant3 = create_square_with_outline (x+.(2.*.(l+.(w/.2.)))) y l i_couleur w in
  let composant4 = create_square_with_outline (x+.(3.*.(l+.(w/.2.)))) y l i_couleur w in
  (I.blend composant1 (I.blend composant2 (I.blend composant3 composant4)));;


(*Question 6*)
let pi = Float.pi;;
let centre = (P2.v 0.5 0.);;

let rotate_45_deg piece nb_rotation = 
  let n = nb_rotation mod 4 in
  let rec aux image cpt = match cpt with
    | 0 -> image
    | _ -> (I.move centre (I.rot (pi/.2.) (aux image (cpt-1))))
  in (aux piece n);;







