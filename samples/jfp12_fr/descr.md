# Exercice JFP 12

Ceci est la transcription en LearnOCaml du sujet de la 12eme itération de la Journée Francilienne de Programmation ayant eu lieu en Mai 2022.

Avant de suivre cet exercice, il est conseillé (obligatoire) d'avoir fait le tutoriel Vg.

## Le démon de Tetris

Si vous avez déjà joué à Tetris, n’avez-vous jamais rêvé de voir dans le futur quelle séquence de pièces vous réserve ce logiciel démoniaque? “Ah si seulement j’avais su qu’il ne me donnerait pas de
barre pendant si longtemps, je n’aurais pas joué de cette façon!”, avez-vous certainement hurlé maintes fois!

Votre rêve est maintenant exaucé ! Aujourd’hui, vous (ou plutôt votre programme) serez le démon de Tetris: tel le démon de Laplace, vous aurez connaissance du passé, du présent et du futur pour prendre vos décisions. Serez-vous alors capables d’atteindre les plus hauts scores jamais réalisés par un joueur de Tetris?

**Question 1 :** LA DESTRUCTION DU TEMPS

Commençons par nous entendre une fois pour toute sur la fameuse séquence de pièces. 

À partir d’un unique nombre entier S (compris en 0 et 1000000), nous allons nous donner un moyen de calculer une séquence T de nombres entiers compris entre 1 et 7 (un nombre par pièces de Tetris).

Cette séquence est obtenue en utilisant la logique suivante :

1. On calcule la séquence U
  U0 = S
  Un+1~ = (6807 * Un - 1) mod (2 ^ 16)
Notez que l’on obtient alors un nombre dont seuls 16 bits sont significatifs.

2. Q est la séquence de nombres entiers compris entre 0 et 7 dont le terme de rang N est obtenu à l’aide des 3 bits de poids les plus forts du terme de rang N de U.

3. T est obtenue en ne gardant que les termes non nuls de Q.

Réaliser la fonction 

```OCaml
  val get_n_termes_T : int -> int -> int list
  get_n_termes_T S n
```

Qui étant donné la valeure de S et le nombre de termes a récupérer, renvoie la liste des n premiers termes de la suite T.

Par exemple, pour S = 231 et n = 20, on a :

```OCaml
  (get_n_termes_T 231 20);;
  int list = [7; 3; 4; 5; 1; 2; 4; 7; 5; 7; 6; 1; 6; 7; 2; 2; 5; 7; 7; 7]
```

**Question 2 :** DES BLOCS À LEUR PLACE

Un plateau de jeu Tetris est une matrice de blocs composée de 24 lignes et de 12 colonnes. Les lignes sont numérotées du haut vers le bas de 0 à 23. Les colonnes sont numérotées de gauche à droite de 0 à 11.

Un bloc est représenté par un entier de 0 à 7.
0 est le bloc vide tandis que les blocs entre 1 et 7 correspondent à des blocs inclus dans des pièces de Tetris du même numéro.

En effet, les pièces sont numérotées comme l’indique le schéma suivant:

```
Pièce i       1111


Pièce j       222
                2

Pièce l       333
              3

Pièce s        44
              44

Pièce z       55
               55

Pièce t       666
               6

Pièce o       77
              77
```

On dit que l’on “tourne une fois” une pièce si on lui fait faire un quart de tour dans le sens horaire. Ainsi, voici comment tourne la pièce j :

```
Une fois :
              2
              2
             22

Deux fois :
              2
              222

Trois fois :
              22
              2
              2

Quatre fois :
              222
                2

```

Pour placer une pièce tournée R fois sur le plateau à la ligne L et à la colonne C, il faut l’avoir
préalablement tournée R fois puis placer ses blocs de façon à ce que son bloc le plus haut se trouve sur la ligne L et que son bloc le plus à gauche se trouve sur la colonne C.

Une pièce peut être posée sur le plateau seulement si tous ses blocs le peuvent. Un bloc peut être posé sur le plateau seulement si l’emplacement du plateau est un bloc vide et si le bloc n’est pas situé à l’extérieur du plateau.

En utilisant le module [Array](https://v2.ocaml.org/api/Array.html) de OCaml, réaliser la fonction 

```OCaml
  val gen_matrice : (int*int*int*int) list -> int array array
  gen_matrice l
```

Qui étant donné une liste de quadruplet renvoie une matrice. Les quadruplets dont constitués de 4 entiers naturels. 

Le premier entier est le numéro P de la pièce (compris entre 1 et 7). 

Le second entier est le numéro L de la ligne (compris entre 0 et 23). 

Le troisième entier est le numéro C de la colonne (compris entre 0 et 11). 

Le quatrième entier est le nombre de tours R appliqués à la pièce (compris entre 0 et 3). 

On part du plateau (une matrice d'entiers <strong>int array array</strong>) ne contenant que des blocs vides (donc des valeurs mis à 0). Pour chaque quadruplet, si on peut poser la pièce P en ligne L et colonne C après l’avoir fait tourner R fois alors on la place sur le plateau (ie on l'insère dans la matrice) sinon on passe à la pièce suivante.

Par exemple, 

```OCaml
  let l = [(1,5,5,0);(1,5,5,0);(1,6,5,0);(1,6,8,0);(2,7,0,0);(2,7,4,0);(2,8,0,0);(2,9,0,0);(3,11,0,0);(4,12,0,0)];;

  (gen_matrice l);; 

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

Pour mieux visualiser une matrice en attendant les questions suivantes, vous pouvez utiliser la fonction

```OCaml
  val print_matrice : (int array array) -> unit
  print_matrice m
```

Qui affiche de maniere lisible une matrice dans le Toplevel.

```OCaml
  (print_matrice (gen_matrice l));;

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

**Question 2.5 :** L'ASCII C'EST RIGOLO MAIS BON VG C'EST MIEUX

Nous allons maintenant essayer de dessiner le Tetris à l'écran plutôt que de le représenter en caractères ASCII.

Pour ce faire nous allons utiliser le module Vg; il est donc recommandé (pour ne pas dire nécessaire -_- ) d'avoir fait le tutoriel Vg disponible dans learnOCaml.

La matrice initialement vide sera représentée par une grille dont les bords sont de couleur noir et d'épaisseur 0.01

Les couleurs des blocs sont les suivantes :

  J -> couleur rgb (0., 0.443, 0.757)

  L -> couleur rgb (1., 0.753, 0.)

  O -> couleur rgb (1., 1., 0.004)
  
  S -> couleur rgb (0.573, 0.82, 0.31)
  
  T -> couleur rgb (0.439, 0.188, 0.627)
  
  Z -> couleur rgb (1., 0., 0.)
  
  I -> couleur rgb (0.004, 0.690, 0.945) 

La grille, elle, sera noire.

Chaques blocs a une longueur de 0.04 et on considèrera que l'épaisseur des bords d'un bloc est 1/10 de la longeur d'un composant.

Realiser la fonction 

```OCaml
  val draw_tetris : int array array -> image
  draw_tetris m
```

Qui, étant donné la matrice représentant le plateau de Tetris, crée une image au sens de Vg qui représente le Tetris.

<div>
  <img src="/icons/images/exercices/jfp12/tetris_1.png" 
    alt="tetris" 
    width="768" 
    height="512"
  />
</div>

<em>Le buffer permettant d'afficher une image sur learnOCaml n'est pas illimité, votre image devra donc être efficace en terme d'espace mémoire</em>

**Question 3 :** LA GRAVITÉ EST UNE LOI UNIVERSELLE

On suppose dans cette question que les quatre premières lignes du plateau sont toujours vides. On dit qu’“une pièce tournée R fois est lâchée sur le plateau à la colonne C” si on la pose sur la première ligne et qu’on la déplace d’une ligne vers le bas tant que c’est possible. (Ici, un déplacement est “possible” si on peut poser la pièce au sens de la question 2)

Réaliser la fonction 

```OCaml
  val gen_matrice_gravity : (int*int*int) list -> int array array
  gen_matrice_gravity l
```

Qui étant donné une liste de triplets renvoie une matrice. Les triplets dont constitués de 3 entiers naturels. 

Le premier entier P est un numéro de pièce. 

Le second entier C est un numéro de colonne. 

Le troisième entier R est le nombre de fois où la pièce a été tournée. 

On peut supposer que l’on peut toujours poser la pièce P sur la première ligne et la colonne C en l’ayant fait tourner préalablement R fois. 

(Il existe des couples (C, R) invalides mais nous ne les utilisons pas dans cette question. En d’autres termes, on suppose dans cette question que l’on peut toujours placer les pièces sur les quatre premières lignes avant de les faire descendre).

Par exemple 

```Ocaml
  let l = [(1,0,0);(2,1,0);(3,2,0);(4,3,0);(5,4,0);(6,5,0);(7,6,0);(1,7,0);(2,8,0);(3,9,0)]

  let plateau = (gen_matrice_gravity l);;

  (draw_tetris plateau);;
```

<div>
  <img src="/icons/images/exercices/jfp12/tetris_2.png" 
    alt="tetris" 
    width="768" 
    height="512"
  />
</div>


**Question 4 :** CALCUL DU SCORE

Nous avons maintenant tous les ingrédients pour jouer à Tetris. Supposons donné un nombre S: la séquence T (de la question 1) déterminée par ce nombre S nous donne la séquence de pièces présentées au joueur. Le joueur doit décider sur quelle colonne et combien de fois tourner chaque pièce de cette séquence.

Avant de jouer chaque pièce, on vérifie que les quatre premières lignes sont bien vides : dans le cas
contraire, la partie est terminée. 
La pièce est alors lâchée où l’a décidé le joueur. Si on ne peut pas lâcher la pièce, alors la partie est terminée.

Ensuite, il se passe la magie de Tetris : si une ligne du plateau est remplie de blocs non vides alors elle est éliminée du plateau et toutes les pièces au-dessus descendent d’une ligne. Si quatre lignes
contiguës sont éliminées, le joueur gagne 800 points : c’est un Tetris! Sinon, chaque ligne remporte 100.

Réaliser la fonction 

```Ocaml
  val calcul_score int -> (int*int*int) list -> (int array array)*int
  calcul_score s l
```

Qui, étant donné le nombre S et une liste de triplets (identique à celle de la question précédente)
renvoie un tuple contenant la matrice représentant le plateau et le score final.

Le premier entier P d'un triplet est le numéro de la pièce : il doit correspondre au terme de rang N de la suite T (de la question 1) initialisée par S. Sinon, la partie est terminée.

Le second entier C est la colonne où le joueur a décidé de lâcher sa pièce. 

Le troisième entier R est le nombre de fois où la pièce est tournée.

Si on ne peut pas lâcher la pièce sur le plateau (parce que le couple (C, R) fourni la fait sortir du
plateau) alors la partie est terminée. Sinon, on lâche la pièce sur le plateau et on met à jour le score comme indiqué plus haut.

On passe au triplet suivant. 

S’il n’y a plus de ligne, alors la partie est terminée.

Par exemple

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


**Question 5 :** À VOUS DE JOUER!

Voilà, votre moment de gloire arrivé : si on vous donne l’entier S, vous connaissez la séquence des
pièces présentées par Tetris. C’est le moment d’appliquer votre stratégie démoniaque pour obtenir le meilleur score!

Réaliser la fonction 

```Ocaml
  val gen_list int -> (int*int*int) list
  gen_list s
```

qui étant donné un entier s construit une liste de triplet (de taille inférieure à 100) qui, mise en paramètre de la fonction calcul_score permet d'obtenir un score le plus élevé possible.

Pour cet question, on comparera le score obtenue avec la liste que vous avez généré et celui d'une fonction gen_list crée pour l'occasion.