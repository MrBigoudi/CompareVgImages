# Graphs

In these exercices we'll try to plot different types of graphs for functions using the Vg module. That's why you'll need a bit of Vg knowledge before trying these questions. For that, you can (must) do the tutorial available in the list of exercices.

## First function

**Question 1** : write the function

```OCaml
  val draw_basis : unit -> Vg.image
```

Which creates an image representing the basis of our graphs (to transform this path into an image, you can use the given function `draw_config p`).
The arrows must be of size `arrow_length`.

You can later use the function 

```OCaml
  val Vg.I.blend : Vg.image -> Vg.image -> Vg.image
```

to place your function's graph on top of this basis.

<div>
  <img src="/icons/images/exercices/graphs/basis.png" 
    alt="graphs' basis" 
    width="768" 
    height="512"
  />
</div>

**Question 2** : We'll start by writing a function `graph_f_int` to plot graphs of funtion from integers to integers.

```OCaml
  val graph_f_int : (int -> int) -> (int*int) -> (float*float) -> Vg.path
```

Which, given a function, a tuple of integers that represents the bounds of the values we'll test and a tuple of floating values that represent the abscissa and ordinate scalings to make the graphs fit in the canvas, returns a path representing the function.

For example :

```OCaml
  let f n = n;;
  let bounds = (-10,10);;
  let scale = (0.1,0.1);;
  let i = I.const (Color.red) |> I.cut (graph_f_int f bounds scale) 
            in (I.blend i (draw_basis()));;
```

<div>
  <img src="/icons/images/exercices/graphs/graph_f_int.png" 
    alt="test graph_f_int" 
    width="768" 
    height="512"
  />
</div>

To make things easier, you can use the given funtion

```OCaml
  val dot : float -> float -> Vg.path -> Vg.path
```

which add a small dot at position (x,y) in an existing path.

**Question 3** : We'll try now to implement a function `graph_f_int_hist` to plot an histogram. 

```OCaml
  val graph_f_int_hist : (int -> int) -> (int*int) -> (float*float) -> float -> Vg.path
```

Which given the same arguments as the previous function plus a float representing the width of the segments returns a path representing the histogram.

```OCaml
  let f n = n;;
  let bounds = (-10,10);;
  let scale = (0.1,0.1);;
  let width = 0.05;;
  let i1 = (I.const Color.black) |> (I.cut (graph_f_int f bounds scale)) in
  let i2 = (I.const Color.red) |> (I.cut (graph_f_int_hist f bounds scale width)) in
    (I.blend i2 (I.blend i1 (draw_basis())));;
```

<div>
  <img src="/icons/images/exercices/graphs/graph_f_int_hist.png" 
    alt="test graph_f_int_hist" 
    width="768" 
    height="512"
  />
</div>

<em> Hint: try to first implement a function that returns the path of a rectangle knowing width and the position of it's top-left coordinates.

**Question 4** : We'll now try to modify the previous functions to take floats number into accounts.

Write a function 

```OCaml
  val graph_f_float : (float -> float) -> (float*float) -> (float*float) -> float -> Vg.path
```

Which, given a function, a tuple of floats representing the bound of the maximum value we'll test, another tuple of of floating values representing the abscissa and ordinate scalings to make the graphs fit in the canvas and a float representing the space between two points, returns a path representing the function.
If a point is undefind it should not be ploted.

```OCaml
  let f x = sqrt x;;
  let bounds = (-10.,10.);;
  let scale = (0.1,0.1);;
  let space = 0.001;;
  let i = I.const (Color.red) |> I.cut (graph_f_float f bounds scale space) 
            in (I.blend i (draw_basis()));;
```

<div>
  <img src="/icons/images/exercices/graphs/graph_f_float.png" 
    alt="test graph_f_int_hist" 
    width="768" 
    height="512"
  />
</div>


**Question 5** : Write a function returning the path to plot a function's integral given the same arguments as for the previous question plus a float representing the width of the segments.

```OCaml
  val graph_integral : (float -> float) -> (float*float) -> (float*float) -> float -> float -> Vg.path
```

```OCaml
  let f x = sqrt x;;
  let bounds = (-10.,10.);;
  let scale = (0.1,0.1);;
  let space = 0.001;;
  let width = 0.05;;
  let i = I.const (Color.red) |> I.cut (graph_integral f bounds scale space) 
            in (I.blend i (draw_basis()));;
```

<div>
  <img src="/icons/images/exercices/graphs/graph_integral.png" 
    alt="test graph_f_int_hist" 
    width="768" 
    height="512"
  />
</div>