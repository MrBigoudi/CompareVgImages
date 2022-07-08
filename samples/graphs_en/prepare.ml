exception Undefined

open Vg;;
open Gg;;

let dot x y p s =
  let rel = true in
    p |>
    P.sub (P2.v x y) |>
    P.circle ~rel (P2.v 0. 0.) s |>
    P.close;;

let __ = (fun _ -> raise Undefined)