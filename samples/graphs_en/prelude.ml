let x_origin = 0.01;;
let y_origin = 0.01;;
let x_max = 1.;;
let y_max = 1.;;
let arrow_length = 0.01;;
let dot_width_int = 0.004;;
let dot_width_float = 0.002;;
let draw_config p =
  let area = `O { Vg.P.o with Vg.P.width = 0.004 } in
    Vg.I.const Gg.Color.black |> Vg.I.cut ~area p;;