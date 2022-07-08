exception Undefined

open Vg;;
open Gg;;

let dot x y p =
  let rel = true in
    p |>
    P.sub (P2.v x y) |>
    P.circle ~rel (P2.v 0. 0.) 0.01 |>
    P.close;;

let __ = (fun _ -> raise Undefined)