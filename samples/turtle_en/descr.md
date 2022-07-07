# Beforehead

This exercise is a modification of the exercise 7.1.tortue provided by the informatic department of Sorbonne University.

Modifications made for this version were made to let students use Vg module without using a personalized one.

# The exercise

In this exercise, we'll draw in Learn-ocaml using a graphic *turtle* inspired by the [Logo](https://fr.wikipedia.org/wiki/Logo_(langage)) lamguage.

### Graphisme in Learn-ocaml

In the following parts, all images will be of size `1.0 x 1.0`, with the origin (i.e. point of coordinate `(0., 0.)`) at the bottom left. To show a draw, you need to build in a the Toplevel an Ocaml value of type [`Vg.image`](https://erratique.ch/software/vg/doc/Vg/index.html).

We'll use here the following `Vg.path` functions :

  - `Gg.P2.v : float -> float -> Gg.p2` create a point from floats

  - `Vg.P.empty : Vg.path` give a path with only the origin

  - `Vg.P.line : ?⁠rel:bool -> Gg.p2 -> path -> path` 
      `(Vg.P.line g p)` continue the path `p` drawing a line from the last point on the path `p` to the point of coordinates `(x,y)`.

  - `Vg.P.sub : ?⁠rel:bool -> Gg.p2 -> path -> path` works like `Vg.P.line` but wihout drawing.

For example an image with a segment between points `(1.,0.)` and `(0.,1.)` can be obtained by doing :

```ocaml
let img = 
  let p = (Vg.P.line (Gg.P2.v 0. 1.) (Vg.P.sub (Gg.P2.v 1. 0.) Vg.P.empty)) in
    let area = `O { Vg.P.o with Vg.P.width = 0.002 } in
      Vg.I.const Gg.Color.black |> Vg.I.cut ~area p
(* or aswell *)
let img = 
  let p =  Vg.P.empty |> Vg.P.sub (Gg.P2.v 1. 0.) |> Vg.P.line (Gg.P2.v 0. 1.) in
  let area = `O { Vg.P.o with Vg.P.width = 0.002 } in
      I.const Gg.Color.black |> I.cut ~area p
```

Hint : the `|>` operator represents the reverse application function; we first have the argument and then the function `x |> f` means : `f x`. With multiple arguments `y |> f x` therefore means `f x y`.

To make the code liter, you can use the given function `draw : Vg.path -> Vg.image` which let you draw an image when given a path.

### Turtle

A trutle is described here with the type `turtle` giving it its coordinates `x` and `y`, as well as its curent angle and the path followed by this turtle so far. Drawing the turtle `t` path can be done by `draw t.path`. The angle indicates the direction taken by the turtle when she'll go forward. It's measured in degrees. An angle of `0.` indicates the right, an angle of `90.` degrees indicates the top.

**Question 1** : write a function `make_turtle : float -> float -> turtle` initializing a turtle at a given position `(x,y)`, with an angle of `0.` degrees and a path without draw of end point `(x,y)`.

**Question 2** : write a function `forward : float -> bool -> turtle -> turtle` such as `(forward dist trace t)` represents the turtle `t`'s state after a step forward of a length `dist` following the current angle. The boolean `trace` indicates if this step is made by drawing or not.

The `command` type describes a possible turtle`s action : step forward by a certain length (with drawing or not), turn of a certain angle (add a float to the current angle), or repeat a certain amount of time a group of commands.

**Question 3** : write a function `run : commands -> turtle -> turtle` which implements the effect of a command succession on a given turtle.

### Let's draw

**Question 4** : write a function `triangle : float -> commands` such as `(triangle size)` return commands drawing an equilateral triangle of length `size`. Use the current point and the current angle as a starting and ending point, and turn in the counter-clockwise direction. Use the `Repeat` constructor to make the commands liter.

**Question 5** : same question for the function `square : float -> commands` producing a square of a given length, then for the function `polygon : int -> float -> commands` such as `(polygon n size)` returns a regular polygon of `n` sides of size `size`. Check that we can draw a circle by using a polygon with many sides.

**Question 6** : write a function `spiral` such as `(spiral size factor angle n)` returns `[Line d1; Turn angle; ...; Line dn; Turn angle]` with distances `di` obtained starting from `size` and multiplying by `factor` each times. Here, you won't be able to use the `Repeat` constructor.Try to find pretty spirals ^^ (for example `spiral 0.1 0.95 10. 100`).