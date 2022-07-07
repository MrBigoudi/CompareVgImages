module Path : sig
  val empty : Vg.path
  val lineto : float -> float -> Vg.path -> Vg.path
  val moveto : float -> float -> Vg.path -> Vg.path
end = struct
  let empty = Vg.P.empty
  let lineto x y p = Vg.P.line (Gg.P2.v x y) p
  let moveto x y p = Vg.P.sub (Gg.P2.v x y) p
end

let make_turtle x y = { x; y; angle = 0.; path = Path.empty |> Path.moveto x y }

let forward dist trace t =
  let angle' = t.angle *. Float.pi /. 180. in
  let x' = t.x +. dist *. cos angle' in
  let y' = t.y +. dist *. sin angle' in
  let deplace = if trace then Path.lineto else Path.moveto in
  { x = x'; y = y'; angle = t.angle; path = t.path |> deplace x' y' }

let rec run_one com t = match com with
  | Line d -> forward d true t
  | Move d -> forward d false t
  | Turn a -> {t with angle = t.angle +. a}
  | Repeat (n,coms) ->
      if n = 0 then t
      else t |> run coms |> run_one (Repeat (n-1,coms))
and run coms t = match coms with
  | [] -> t
  | com::coms -> t |> run_one com |> run coms

let draw_turtle turtle = draw turtle.path

let draw_cmds x y coms = make_turtle x y |> run coms |> draw_turtle

let triangle size = [Repeat (3,[Line size; Turn 120.])]

let square size = [Repeat (4,[Line size; Turn 90.])]

let polygon n size = [Repeat (n,[Line size; Turn (360./.Float.of_int n)])]

let tri = draw_cmds 0.1 0.1 (triangle 0.5)
let squ = draw_cmds 0.1 0.1 (square 0.5)
let sept = draw_cmds 0.3 0.1 (polygon 7 0.2)

let rec spiral size factor angle n =
  if n = 0 then []
  else Line size :: Turn angle :: spiral (size *. factor) factor angle (n-1)

let spi = draw_cmds 0. 0. (spiral 1. 0.95 10. 100)

let rec sierp size n =
  if n = 0 then []
  else
    let coms = sierp (size/.2.) (n-1) in
    [Repeat (3,coms@[Line size; Turn 120.])]

let rec koch_line size n =
  if n = 0 then [Line size]
  else
    let coms = koch_line (size/.3.) (n-1) in
    coms @ [Turn (-60.)] @ coms @ [Turn 120.] @ coms @ [Turn (-60.)] @ coms

let koch size n =
  let coms = koch_line size n in
  [Repeat (3,coms@[Turn 120.])]

let koch3 = draw_cmds 0.2 0.2 (koch 0.5 3)
