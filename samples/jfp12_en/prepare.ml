open Vg;;
open Gg;;

let print_matrix m =
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

exception Undefined
let __ = (fun _ -> raise Undefined)