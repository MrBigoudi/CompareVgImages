# JFP 12 Exercice

This is the LearnOCaml transcription of the 12th editioon of the JFP (Journée Francilienne de Programmation) which took place in May 2022.

Before trying this exercice, it is recommended (mandatory) to complete the Vg tutorial.

## Tetris Daemon

If you've ever played Tetris, have you never wished to see in the futur which pieces sequence will you get ? "If only I knew I wouldn't have a stick for so long, I wouldn't have played like that!", have you probably shouted so many times!

You dream has now come true ! Today you (well your program actually) will be the Tetris deamon: like the Laplace deamon, you'll know the past, the present and the futur. Will you be able to reach the highest score ever made by a Tetris player ?

**Question 1 :** TIME DESCTRUCTION

Let's be clear once and for all about the piece sequence.

From a unique integer S (between 0 and 1e6), we'll give us a way to calculate a T sequence of integers between 1 and 7 (one digit per Tetris piece).

This sequence is obtained by using the logic below :

1. We calcul a U sequence
  U0 = S
  Un+1~ = (6807 * Un - 1) mod (2 ^ 16)
Note that we obtain a number for which only 16 bits are meaningful.

2. Q is the sequence of integers between 0 and 7 for which the Nth term is obtained using the 3 most significant bits of the U's Nth term.

3. T is obtained by keeping only the non null Q terms.

Write the function

```OCaml
  val get_n_termes_T : int -> int -> int list
  get_n_termes_T S n
```

Which, given the value S and the number of terms to generate, return the list of the n firsts terms of T.

For example, if S = 231 and n = 20, we get :

```OCaml
  (get_n_termes_T 231 20);;
  int list = [7; 3; 4; 5; 1; 2; 4; 7; 5; 7; 6; 1; 6; 7; 2; 2; 5; 7; 7; 7]
```

**Question 2 :** BLOCS AT THEIR PLACE

A Tetris board is a matrix of blocks made of 24 lines and 12 columns. Lignes are numbered from top (0) to bottom (23). Columns are numbered from left (0) to right (11).

A blocks is represented by a digit between 0 and 7.

0 is the empty block while blocks between 1 and 7 correspond to blocks included in a Tetris piece of same number.

Indeed, pieces are numbered like below :

```
i piece       1111


j piece       222
                2

l piece       333
              3

s piece        44
              44

z piece       55
               55

t piece       666
               6

o piece       77
              77
```

We say that we 'rotate a piece once' if we make it do a quarter of turn clockwise.
For example, here is how the j-piece rotate :

```
Once :
              2
              2
             22

Twice :
              2
              222

Three times :
              22
              2
              2

Four times :
              222
                2

```

To place a piece rotated R times in the board at the Lth line and Cth column, we must rotate it R times before placing it such as it's highest block is in the Lth line and is block the most on the left is in the Cth column.

A piece can be place in the board only if all its blocks can. A block can be placed in the board only if the space is free in the board (ie their is an empty block in the matrix) and if the space is not outside of the board.

Using the Ocaml [Array](https://v2.ocaml.org/api/Array.html) module write the function 

```OCaml
  val gen_matrix : (int*int*int*int) list -> int array array
  gen_matrix l
```

Which, given a list of 4-tuples return a matrix. 4-tuples are made of 4 integers. 

First is the piece number P (between 1 and 7). 

Second is the line number L (between 0 and 23).

Third is the column number C (between 0 and 11).

Last but not least is the number of rotations R applied to the piece (between 0 and 3).

We start from a board (a matrix of integers <strong>int array array</strong>) containing only empty blocks. For each 4-tuples, if we can place the piece P at line L, column C after rotating it R times, then we place it on the board (ie we place it in the matrix) else we check the next piece.

For example, 

```OCaml
  let l = [(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)];;

  (gen_matrix l);; 

  int array array =
    [|
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 1; 1; 1; 1; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 1; 1; 1; 1; 0; 0; 0|];
      [|2; 2; 2; 0; 2; 2; 2; 0; 0; 0; 0; 0|];
      [|0; 0; 2; 0; 0; 0; 2; 0; 0; 0; 0; 0|];
      [|2; 2; 2; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 2; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|3; 3; 3; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|3; 4; 4; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|4; 4; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|];
      [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0|]; |]
```

If you want to have a better view of your matrix (before doing the upcoming questions), you can use the function

```OCaml
  val print_matrix : (int array array) -> unit
  print_matrix m
```

Which prints a matrix in the TopLevel.

```OCaml
  (print_matrix (gen_matrice l));;

  - : unit = ()

  ............
  ............
  ............
  ............
  ............
  .....1111...
  .....1111...
  222.222.....
  ..2...2.....
  222.........
  ..2.........
  333.........
  344.........
  44..........
  ............
  ............
  ............
  ............
  ............
  ............
  ............
  ............
  ............
  ............

```

**Question 2.5 :** ASCII IS FUN BUT VG IS FUNNIER

We'll now try to draw the Tetris board on screen instead of just representing it using ASCII.

For that purpose, we'll use the Vg module; it's recommended (to not say mandatory -_-) to have completed the Vg tutorial available in learnOCaml.

The matrix initially empty will be represented by a grid with black borders of width 0.01

Blocks colors will be as follow :

  J -> rgb color : (0., 0.443, 0.757)

  L -> rgb color : (1., 0.753, 0.)

  O -> rgb color : (1., 1., 0.004)
  
  S -> rgb color : (0.573, 0.82, 0.31)
  
  T -> rgb color : (0.439, 0.188, 0.627)
  
  Z -> rgb color : (1., 0., 0.)
  
  I -> rgb color : (0.004, 0.690, 0.945)

The grid will be black

Each block will have a length of 0.04 and we'll consider that outline width of a block will be 1/10 of the block length. 

Write the function

```OCaml
  val draw_tetris : int array array -> image
  draw_tetris m
```

Which, given a matrix representing the Tetris board, creates a Vg image which represents the current state of the game.

<div>
  <img src="/icons/images/exercices/jfp12/tetris_1.png" 
    alt="tetris" 
    width="768" 
    height="512"
  />
</div>

<em>The buffer used to print an image in learnOCaml being limited, your image must be space efficient in term of memory space</em>

**Question 3 :** GRAVITY IS AN UNIVERSAL LAW

We'll suppose here that the fourth first lines of the board will always be empty. We say that a R-times rotated piece is 'droped' on the board at the C column if we place it on the first line of the board and then move it to the bottom one line at a time until it's not possible anymore. (A movement is "possible" if the piece can be placed using question 2 restrictions)

Write the function

```OCaml
  val gen_matrix_gravity : (int*int*int) list -> int array array
  gen_matrix_gravity l
```

Which, given a list of triple of numbers return a matrix. Triple of numbers are made of 3 integers.

First is the piece number P.

Second is the column number C.

Third is the number of rotations R applied to the piece.

We suppose that we can always put the piece P at the first line and column C after rotating it R times.

(It exists invalid tuples (C,R) but we won't use them in this question. In other words, we suppose that we can always put the pieces on the first fourth lines before making them move to the bottom).

For example 

```Ocaml
  let l = [(1,0,0);(2,1,0);(3,2,0);(4,3,0);(5,4,0);(6,5,0);(7,6,0);(1,7,0);(2,8,0);(3,9,0)]

  let board = (gen_matrice_gravity l);;

  (draw_tetris board);;
```

<div>
  <img src="/icons/images/exercices/jfp12/tetris_2.png" 
    alt="tetris" 
    width="768" 
    height="512"
  />
</div>


**Question 4 :** CALCUL THE SCORE

We have now all the things needed to pllay Tetris. Knowing an integer S: the sequence T (from question 1) determined by S gives us the sequence of pieces presented to the player. The player must decide on which column and how many times we should turn the piece for each pieces of the sequence. 

Before playing each piece, we check that each of the four first lines are empty : otherwise the game ends.
The piece is then dropped on the column chosen by the player. If we can't drop it, the game ends.

Then, there's the Tetris magic : if a line of the board is fill with non empty blocks then this line vanishes and all the blocks from above drop by a line. If four contiguous lines vanishe at the same time, the player get 800 points : it's a Tetris ! Otherwise, each line gives 100 points to the player.

Write the function 

```Ocaml
  val calcul_score int -> (int*int*int) list -> (int array array)*int
  calcul_score s l
```

Which, knowing the integer S and a list of triple of numbers (like the one from the last question) return a tuple of the final board and the final score.

The first integer P of a triple of numbers represents the piece number : it must be equal to the nth term of the T sequence initialized by S. Otherwise, the game ends.

The second integer C represents the column where the player decided to drop the piece.

The third R represents the numberof rotations for the piece.

If we can't drop the piece on the board (because the tuple (C,R) makes it go out of the board) then the game ends. Otherwise, we drop the piece on the board and update the score as explained above.

We check the next triple of numbers.

If there aren't any, the game ends.

For example

```OCaml
  let s = 231;;

  let l = [(7,0,2);(3,2,2);(4,2,0);(5,0,0);(1,8,0);(2,5,2);(4,5,3);(7,10,3);
         (5,1,0);(7,8,3);(6,3,0);(1,7,1);(6,0,3);(7,10,0);(2,6,3);(2,8,1);
         (5,1,0);(7,4,0);(7,10,0);(7,10,1);(3,7,1);(2,1,0);(1,0,1);(2,4,0);
         (3,1,3);(7,10,3);(1,3,2);(2,7,0);(7,2,1);(4,0,0);(3,7,2);(4,7,0);
         (6,6,3);(7,4,3);(7,10,1);(1,0,1);(3,7,2);(7,10,2);(1,3,0);(4,7,0);
         (3,5,0);(7,3,2);(3,1,1);(2,3,2);(1,0,1);(7,1,2);(3,7,2);(3,6,2);
         (4,4,2);(7,10,2);(3,9,0);(4,6,1);(2,1,0);(2,9,2);(2,4,3);(1,8,3);
         (5,9,0);(4,6,1);(2,1,2);(1,2,0);(4,10,1);(3,7,0);(4,4,1);(2,0,2);
         (4,10,1);(7,5,1);(3,1,2);(1,9,1);(6,0,3);(3,4,0);(2,7,1);(5,1,0);
         (3,10,1);(1,0,1);(4,6,1);(6,2,1);(2,1,3);(2,7,1);(3,3,1);(1,5,3);
         (1,1,2);(6,0,3);(2,7,2);(7,5,3);(5,3,3);(6,9,2);(7,0,3);(3,4,0);
         (7,7,3);(1,3,2);(4,10,3)];;

  let (board,score) = (calcul_score s l);;

  score;;

  int = 1900

  (draw_tetris board);;
```

<div>
  <img src="/icons/images/exercices/jfp12/tetris_3.png" 
    alt="tetris" 
    width="768" 
    height="512"
  />
</div>

**Question 5 :** IT'S YOUR TURN!

Now your moment of gloray has arrived : if we give you the S integer, you know the pieces sequence given by the Tetris. It's the moment to apply your evil strategy to get the best score!

Write the function 

```Ocaml
  val gen_list int -> (int*int*int) list
  gen_list s
```

which given an integer s, return a list of number triple (the list's size must be less or equal than 100) which, given to the function calcul_score, let you get a great score. 

For this question, we'll compare the score obtained with the list you've generated and the one obtained by our own gen_list function.