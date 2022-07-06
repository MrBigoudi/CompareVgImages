exception Undefined
let __ = (fun _ -> raise Undefined)

module Path : sig
  val empty : Vg.path
  val lineto : float -> float -> Vg.path -> Vg.path
  val moveto : float -> float -> Vg.path -> Vg.path
  val draw : Vg.path -> Vg.image
end = struct
  let empty = Vg.P.empty
  let lineto x y p = Vg.P.line (Gg.P2.v x y) p
  let moveto x y p = Vg.P.sub (Gg.P2.v x y) p
  let draw p =
    let open Vg in
    let area = `O { P.o with P.width = 0.002 } in
    I.const Gg.Color.black |> I.cut ~area p
end
