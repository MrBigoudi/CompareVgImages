# Vg Tutorial

[Vg](https://erratique.ch/software/vg/doc/Vg/index.html) is an OCaml module that let you do graphism using 2D vectors.
Here is a simplified tutorial.

# Colors

Let's first learn how to represent a color.
A color is a combination of 3 values between 0. and 1. (plus one otional valu for transparency):
  - r -> the amount of red (r for red)
  - g -> the amount of green (g for green)
  - b -> the amount of blue (b for blue)
  - a -> the image transparency (a for alpha)

Vg is build upon the [Gg](https://erratique.ch/software/gg/doc/Gg/index.html) module. Inside this module, there is a  [Color](https://erratique.ch/software/gg/doc/Gg/Color/index.html) module representing a color and that can be uinitialized as follow :

```OCaml
  val v_srgb : float -> float -> float -> ?a:float -> color

  let red = Color.v_srgb 1.0 0.0 0.0
```

The alpha value is optional (hence the <em>?a</em> in the signature).
To pass an optional argument to a function, you have to add a <strong>~</strong> before this argument.
<em>Example</em>, 

```OCaml
  let sum ?(a=1) b = a+b;;
  
  val sum : ?a:int -> int -> int = <fun>

  let a = 2 in
    (sum ~a 1);;
  
  - : int = 3

  (sum 1);;

  - : int = 2
```

---

---


**Question 1** : Write a function create_color calling the Color.v_srgb function but making the alpha argument mandatory.

  ```create_color : float -> float -> float -> float -> color```



# First lines

We'll try to draw simple shapes using Vg.

First of all, in OCaml, the <strong>|></strong> operator represents the reverse application function; therefore, we have, for example :

```OCaml
x |> f |> g == (g (f x))
```

In Vg, a path is a list of subpath. A subpath is itself a list of connected segments (curved or not).

To define a path, we start from an empty path <em>P.empty</em> and give it to subpaths <em>P.sub</em>.
These subpaths are created with a 2D vector initialized with <em>P2.v</em>.

For example: to draw two red dots of radius 0.01 at coordinates (0.1,0.5) and (0.1,0.1) from the origin, we can do

```OCaml
let red = create_color 1.0 0. 0. 1. ;; 
let p = 
  let rel = true indoc_
  P.empty |>
  P.sub (P2.v 0.1 0.5) |>
    P.circle ~rel (P2.v 0. 0.) 0.01 |>
    P.close |>
  P.sub (P2.v 0.0 0.0) |>
    P.circle (P2.v 0.1 0.1) 0.01 |>
    P.close
in I.const red |> I.cut p;;
```

<div>
  <img src="/icons/images/exercices/vgTutorial/two_red_dots.png" 
    alt="two red dots" 
    width="768" 
    height="512"
  />
</div>

The <em>~rel</em> option set to true, allows us to define P.circle coordinates from the coordinates of the previous point (here (0.1,0.5)). If this argument is not there, each coordinates will be described from the origin (0.,0.).

As you can guess, the function

```OCaml
val circle : ?⁠rel:bool -> Gg.p2 -> float -> path -> path
circle ~rel c r p
```

Add a circle of center c and radius r to the path p.

The function

```OCaml
val close : path -> path
close p
```

Closes the path p with a straight line from the last point of p to the start point of the current subpath. It closes the subpath.

The function

```OCaml
val const : Gg.color -> image
I.const (create_color 1.0 0.0 0.0 1.0);;
```

Create a red image.

The function

```OCaml
val cut : ?⁠area:P.area -> path -> image -> image
I.cut a p i;;
```

Draw an image i removinig the space outside [a, p]. If a is not specified we just draw i.

---

---


**Question 2** : Write a function create_circle creating a path representing a circle taking its coordinates, its color and its radius.

  ```create_circle : float -> float -> color -> float -> image```

<div>
  <img src="/icons/images/exercices/vgTutorial/create_circle.png" 
    alt="create circle output" 
    width="896" 
    height="512"
  />
</div>

---

---


**Question 3** : Write a function create_dot_square creating a unique image representing the four angles of a square as circle with fixed radius. This function take the position of the bottom-left corner of the square, the length of a side, the color of the circles and their radius.

  ```create_dot_square : float -> float -> float -> color -> float -> image```

The square must look like :

<div>
  <img src="/icons/images/exercices/vgTutorial/square_dot.png" 
    alt="square with four angles as dots" 
    width="128" 
    height="128"
  />
</div>

We can see that, for each points created with this function, a new image appears in the top level. To avoid that, we can use the function <em>blend</em> from the <strong>I</strong> module.

```Ocaml
val blend : image -> image -> image
blend src dst
```

It's the blend of src over dst using alpha components.

In addition to the circle primitive, there exists others to create subpaths ([cf subpaths and segments](https://erratique.ch/software/vg/doc/Vg/P/index.html#subs)).

---

---


Now, let's try to add some outline to our shapes.

A path and a value of type P.area definea finite field from the 2d euclidian space.
If we consider a field <strong>a</strong>, a path <strong>p</strong> and a point <strong>pt</strong>, then the semantic function : 

```OCaml
[]: P.area -> path -> Gg.p2 -> bool
```

maps them on a boolean value (written <strong>[a, p]pt</strong>) which indicates if the point <strong>pt</strong> is in the field a.

As an example :

```OCaml
let circle_outline =
  let black = create_color 0. 0. 0. 1. ;;
  let circle = P.empty |> P.circle (P2.v 0.5 0.5) 0.4 in
  let area = `O { P.o with P.width = 0.04 } in
  I.cut ~area circle black
```

It creates a circle of center (0.5,0.5), of radius 0.4 and of width 0.04.

<div>
  <img src="/icons/images/exercices/vgTutorial/doc_circle_outline.png" 
    alt="circle outline" 
    width="128" 
    height="128"
  />
</div>


**Question 4** : Write a function create_square_with_outline creating a unique image representing a square with an outline. This function takes the position of the bottom-left corner of the square, the length of a side, the color of the square and the width of the outline.

r,g,b components of the outline must be them of the square multiplied by 3/4.

<div>
  <img src="/icons/images/exercices/vgTutorial/square_with_outline.png" 
    alt="square with outline" 
    width="896" 
    height="512"
  />
</div>

  ```create_square_with_outline : float -> float -> float -> color -> float -> image```

It.s possible to get the r,g,b and a values from a color using the functions

```OCaml
val r : color -> float
Color.r c is the red component of c.

val g : color -> float
Color.g c is the green component of c.

val b : color -> float
Color.b c is the blue component of c.

val a : color -> float
Color.a c is the alpha component of c.
```

inside the Color module.


<em>
Help: 
  - you can start by writting the functions 
</em>
  
  ```OCaml
  val create_shade : Gg.color -> Gg.color = <fun>
  val create_square_path : float -> float -> float -> Vg.path = <fun>
  val create_square : float -> float -> float -> Gg.color -> Vg.image = <fun>
  val create_square_outline : float -> float -> float -> Gg.color -> float -> Vg.image = <fun>
  ```

<em>
  - you can also use certain primitives from here [subpaths and segments](https://erratique.ch/software/vg/doc/Vg/P/index.html#subs), especially:
</em>

```OCaml
  val line : ?⁠rel:bool -> Gg.p2 -> path -> path
```

<em>
from the P module.
</em>

---

---


# Tetris pieces

It's your turn now !

Here are the pieces of the infamous Tetris game 

<div>
  <img src="/icons/images/exercices/vgTutorial/tetris_block.jpg" 
    alt="tetris blocks" 
    width="896" 
    height="512"
  />
</div>

In order, there are the pieces :

  J -> rgb color : (0., 0.443, 0.757)

  L -> rgb color : (1., 0.753, 0.)

  O -> rgb color : (1., 1., 0.004)
  
  S -> rgb color : (0.573, 0.82, 0.31)
  
  T -> rgb color : (0.439, 0.188, 0.627)
  
  Z -> rgb color : (1., 0., 0.)
  
  I -> rgb color : (0.004, 0.690, 0.945) 

We'll call <em>components</em> the squares which formes a Tetris piece.


**Question 5** : Write the functions: 

  ```OCaml
  create_block_j : float -> float -> float -> image
  create_block_l : float -> float -> float -> image
  create_block_o : float -> float -> float -> image
  create_block_s : float -> float -> float -> image
  create_block_t : float -> float -> float -> image
  create_block_z : float -> float -> float -> image
  create_block_i : float -> float -> float -> image
  ```

Which, given the abscissa of component the most on the left and the ordinate of the component the most on the bottom, create the different Tetris peices.

<em>
  We'll consider that the width of the outlines will be 1/10 of the side's length.
  OUtline colors will be obtained multiplying the r,g and b components by 3/4 of the piece's color.
</em>

---

---


Tetris pieces can be rotated in 4 different positions. Vg.I module gives us a method

```Ocaml
val rot : float -> image -> image
rot a i is i rotated by a
```

to rotate images from a theta (rad) angle. However, after this rotation, the image will be translated. To solve this issue and move the image back to its place, we can use the function

```OCaml
val move : Gg.v2 -> image -> image
move v i is i translated by v
```

to translate it.

**Question 6** : Using the given values <em>pi</em> and <em>centre</em> write a funtion rotate_45_deg

```OCaml
val rotate_45_deg : image -> int -> image
rotate_45_deg piece nb_rotation
```

which, given a Tetris piece and a number of rotations, turns n times the piece at a 45 (deg) angle.


<em>Warning, for efficiency reasons, the function <strong>rotate_45_deg</strong> must call <strong>I.rot</strong> a maximum of 4 times !</em>

For example, with the block_j piece, we have :

<div>
  <img src="/icons/images/exercices/vgTutorial/block_j.png" 
    alt="block J" 
    width="896" 
    height="512"
  />
  <img src="/icons/images/exercices/vgTutorial/block_j_rot_1.png" 
    alt="block j rotate once" 
    width="896" 
    height="512"
  />
  <img src="/icons/images/exercices/vgTutorial/block_j_rot_2.png" 
    alt="block j rotate twice" 
    width="896" 
    height="512"
  />
  <img src="/icons/images/exercices/vgTutorial/block_j_rot_3.png" 
    alt="block j rotate three times" 
    width="896" 
    height="512"
  />
  <img src="/icons/images/exercices/vgTutorial/block_j_rot_4.png" 
    alt="block j rotate four times" 
    width="896" 
    height="512"
  />
</div>