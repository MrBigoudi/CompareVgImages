type turtle = { x : float; y : float; angle : float; path : Vg.path }
type command =
  | Line of float
  | Move of float
  | Turn of float
  | Repeat of int * commands
and commands = command list

