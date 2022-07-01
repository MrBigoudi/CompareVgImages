# Tutoriel Vg

[Vg](https://erratique.ch/software/vg/doc/Vg/index.html) est un module d'OCaml permettant de faire du graphisme à l'aide de vecteurs 2D.
Voici un tutoriel simplifié

# Couleurs

Apprenons tout d'abord à représenter une couleur.
Une couleur est une combinaison de 3 valeurs comprises entre 0. et 1. (plus une valeure optionnelle pour la transparence):
  - r -> la quantité de rouge (r pour red)
  - g -> la quantité de vert (g pour green)
  - b -> la quantité de bleu (b pour blue)
  - a -> la transparence de l'image (a pour alpha)

Vg est basé sur le module [Gg](https://erratique.ch/software/gg/doc/Gg/index.html). Le module Gg a un module [Color](https://erratique.ch/software/gg/doc/Gg/Color/index.html) représentant une couleur et pouvant être initialisé de la maniere suivante :

```OCaml
  val v_srgb : float -> float -> float -> ?a:float -> color

  let red = Color.v_srgb 1.0 0.0 0.0
```

La valeur alpha est optionnelle (d'où le <em>?a</em> dans la signature). 
Pour passer un argument optionnel à une fonction, il faut rajouter un <strong>~</strong> avant cet argument.
<em>Exemple</em>, 

```OCaml
  let somme ?(a=1) b = a+b;;
  
  val somme : ?a:int -> int -> int = <fun>

  let a = 2 in
    (somme ~a 1);;
  
  - : int = 3

  (somme 1);;

  - : int = 2
```

---

---


**Question 1** : Rédiger une fonction create_color appelant la fonction Color.v_srgb et qui rend l'argument alpha obligatoire

  ```create_color : float -> float -> float -> float -> color```



# Premiers tracés

Nous allons essayer de tracer des formes simple en utilisant Vg.

Tout d'abord, en OCaml, l'opérateur <strong>|></strong> correspond à l'opérateur d'application inverse, ainsi, on a par exemple :

```OCaml
x |> f |> g == (g (f x))
```

Dans Vg, un chemin (path) est une liste de sous-chemin (subpath). Un sous-chemin est une liste de segments (courbés ou non) connectés.

Pour définir un chemin, on part d'un chemin vide <em>P.empty</em> que l'on passe à des sous chemins <em>P.sub</em>.
Ces sous chemins sont crées à l'aide d'un vecteur 2D initialisé avec <em>P2.v</em>. 

Par exemple: pour afficher deux points rouges de rayon 0.01 aux coordonnées (0.1,0.5) et (0.1,0.1) par rapport à l'origine de l'image, on peut faire

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

L'option <em>~rel</em> mis à vrai, permet de definir les coordonnées de P.circle à partir des coordonnées du point précédent (ici (0.1,0.5)). Si cet argument n'est pas présent, chaque coordonnées sera décrite en fonction de l'origine (0.,0.).

Comme son nom l'indique, la fonction 

```OCaml
val circle : ?⁠rel:bool -> Gg.p2 -> float -> path -> path
circle ~rel c r p
```

Permet de rajouter au chemin p un cercle de centre c et de rayon r.

La fonction

```OCaml
val close : path -> path
close p
```

Permet de fermer p avec une ligne droite allant du dernier point de p au point de départ du sous-chemin courant. Cela ferme le sous-chemin.

La fonction 

```OCaml
val const : Gg.color -> image
I.const (create_color 1.0 0.0 0.0 1.0);;
```

Crée une image de couleur rouge.

La fonction 

```OCaml
val cut : ?⁠area:P.area -> path -> image -> image
I.cut a p i;;
```

Représente l'image i en enlevant l'espace en dehors de [a, p]. Si a n'est pas spécifié, on affiche juste l'image i.

---

---


**Question 2** : Rédiger une fonction create_circle permettant de creer un chemin représentant un rond à partir de ses coordonnées, sa couleur et son rayon.

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


**Question 3** : Rédiger une fonction create_dot_square permettant de créer une unique image représentant les quatre coins d'un carré sous forme de ronds de rayon fixe. Cette fonction prend en entrée la position du coin inférieur gauche du carré, la longeur d'un côté, la couleur des ronds et leur rayon.

  ```create_dot_square : float -> float -> float -> color -> float -> image```

Le carré doit être de la forme :
<div>
  <img src="/icons/images/exercices/vgTutorial/square_dot.png" 
    alt="square with four angles as dots" 
    width="128" 
    height="128"
  />
</div>

On remarque que, pour chaque points crées avec cette fonction, une nouvelle image apparait. Pour eviter cela on peut utiliser la fonction <em>blend</em> du module <strong>I</strong>.

```Ocaml
val blend : image -> image -> image
blend src dst
```

C'est le mélange de src sur dst en utilisant les composants alpha.

En plus de circle, il existe d'autres primitives pour créer des sous-chemin ([cf subpaths and segments](https://erratique.ch/software/vg/doc/Vg/P/index.html#subs)).

---

---


Nous allons maintenant rajouter des contours à nos formes.

Un chemin et une valeur de type P.area definissent un champ fini de l'espace euclidien 2D. 
Si on considère un champ <strong>a</strong>, un chemin <strong>p</strong> et un point <strong>pt</strong>, la fonction sémantique :

```OCaml
[]: P.area -> path -> Gg.p2 -> bool
```

les maps sur une valeure booléene (écris <strong>[a, p]pt</strong>) qui indique si le point <strong>pt</strong> appartient ou non au champ a.

Prenons un exemple :

```OCaml
let circle_outline =
  let black = create_color 0. 0. 0. 1. ;;
  let circle = P.empty |> P.circle (P2.v 0.5 0.5) 0.4 in
  let area = `O { P.o with P.width = 0.04 } in
  I.cut ~area circle black
```

Cela crée un cercle de centre (0.5 0.5), de rayon 0.4 et d'épaisseur 0.04.

<div>
  <img src="/icons/images/exercices/vgTutorial/doc_circle_outline.png" 
    alt="circle outline" 
    width="128" 
    height="128"
  />
</div>

**Question 4** : Rédiger une fonction create_square_with_outline permettant de créer une unique image représentant un carré avec un contour. Cette fonction prend en entrée la position du coin inférieur gauche du carré, la longeur d'un côté, la couleur du carre et l'épaisseur du contour.
Les composants r,g,b du contour doivent-être ceux du carré multiplié par 3/4.

<div>
  <img src="/icons/images/exercices/vgTutorial/square_with_outline.png" 
    alt="square with outline" 
    width="896" 
    height="512"
  />
</div>

  ```create_square_with_outline : float -> float -> float -> color -> float -> image```

Il est possible de récupérer les valeurs r,g,b et a d'une couleur avec les fonctions

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

du module Color


<em>
Aide: 
  - vous pouvez commencer par créer des fonctions 
</em>
  
  ```OCaml
  val create_shade : Gg.color -> Gg.color = <fun>
  val create_square_path : float -> float -> float -> Vg.path = <fun>
  val create_square : float -> float -> float -> Gg.color -> Vg.image = <fun>
  val create_square_outline : float -> float -> float -> Gg.color -> float -> Vg.image = <fun>
  ```

<em>
  - vous pouvez utiliser certaines primitives présentées ici [subpaths and segments](https://erratique.ch/software/vg/doc/Vg/P/index.html#subs), et notemment la primitive:
</em>

```OCaml
  val line : ?⁠rel:bool -> Gg.p2 -> path -> path
```

<em>
du module P
</em>

---

---


# Blocs de Tetris

A vous de jouer maintenant ! 

Voici les blocs du célèbre jeu Tetris. 

<div>
  <img src="/icons/images/exercices/vgTutorial/tetris_block.jpg" 
    alt="tetris blocks" 
    width="896" 
    height="512"
  />
</div>

On a, dans l'ordre, les blocs :

  J -> couleur rgb : (0., 0.443, 0.757)

  L -> couleur rgb : (1., 0.753, 0.)

  O -> couleur rgb : (1., 1., 0.004)
  
  S -> couleur rgb : (0.573, 0.82, 0.31)
  
  T -> couleur rgb : (0.439, 0.188, 0.627)
  
  Z -> couleur rgb : (1., 0., 0.)
  
  I -> couleur rgb : (0.004, 0.690, 0.945) 


On appellera <em>composant</em> les carrés qui, mis bout à bout, forment un des blocs de Tetris.

**Question 5** : Rédiger les fonctions: 

  ```OCaml
  create_block_j : float -> float -> float -> image
  create_block_l : float -> float -> float -> image
  create_block_o : float -> float -> float -> image
  create_block_s : float -> float -> float -> image
  create_block_t : float -> float -> float -> image
  create_block_z : float -> float -> float -> image
  create_block_i : float -> float -> float -> image
  ```

Qui, étant donné l'abscisse du composant le plus à gauche et l'ordonnée du composant le plus en bas du bloc ainsi qu'étant donné la longeur d'un composant, créent les différents blocs du Tetris.

<em>
  On considèrera que l'épaisseur des bords d'un bloc est 1/10 de la longeur d'un composant.
  La couleur des bords d'un bloc est obtenu en multipliant par (3/4) les composants r,g et b du bloc.
</em>

---

---


Les blocs de Tetris peuvent se tourner dans 4 positions différentes. Le module I de Vg propose une méthode 

```Ocaml
val rot : float -> image -> image
rot a i is i rotated by a
```

pour faire pivoter des images d'un angle de theta radian. Cependant, apres rotation, l'image sera decalée. Pour régler ce problème et repositionner l'image, on peut utiliser la fonction 

```OCaml
val move : Gg.v2 -> image -> image
move v i is i translated by v
```

pour translater l'image et la repositionner.

**Question 6** : En utilisant les valeurs <em>pi</em> et <em>centre</em> fournies, rédiger une fonction rotate_45_deg

```OCaml
val rotate_45_deg : image -> int -> image
rotate_45_deg piece nb_rotation
```

qui, étant donne un block de Tetris et un nombre de rotation, tourne n fois le block de 45 degrés.

<em>Attention, pour des raisons d'efficacite, la fonction <strong>rotate_45_deg</strong> ne doit appeler la méthode <strong>I.rot</strong> que 4 fois au maximum !</em>

On obtient par exemple, pour le bloc j, les blocs suivants :

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