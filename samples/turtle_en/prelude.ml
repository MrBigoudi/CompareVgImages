let draw p = 
  let area = `O { Vg.P.o with Vg.P.width = 0.002 } in
  Vg.I.const Gg.Color.black |> Vg.I.cut ~area p;;

type turtle = { x : float; y : float; angle : float; path : Vg.path }

type command =
  | Line of float
  | Move of float
  | Turn of float
  | Repeat of int * commands
and commands = command list

