Dans cet exercice, on va dessiner dans Learn-ocaml en utilisant une
*tortue* graphique inspirée par le langage
[Logo](https://fr.wikipedia.org/wiki/Logo_(langage)).

### Graphisme dans Learn-ocaml

Dans la suite, toutes les images seront de taille `1.0 x 1.0`, avec
l'origine (i.e. le point de coordonnées `(0., 0.)` en bas à gauche.
Pour afficher un dessin, il suffit de fabriquer dans le Toplevel
une valeur OCaml du type d'image fourni `Vg.image`. Nous obtiendrons ici ces
images via `Path.draw : Vg.path -> Vg.image` et les fonctions suivantes sur
les chemins `Vg.path` : 

  - `Path.empty : Vg.path` donne un chemin avec uniquement le point
    origine et aucun tracé.
  - `Path.lineto : float -> float -> Vg.path -> Vg.path` telle que 
    `(Path.lineto x y p)` prolonge un chemin `p` en traçant une ligne
    entre le dernier point de ce chemin `p` et les coordonnées `(x,y)`.
  - `Path.moveto : float -> float -> Vg.path -> Vg.path` fonctionne
    comme `Path.lineto` sauf que le déplacement final au point indiqué
    se fait sans tracé.

Par exemple une image avec un segment entre les points `(1.,0.)` et
`(0.,1.)` peut s'obtenir ainsi :

```ocaml
let img = Path.draw (Path.lineto 0. 1. (Path.moveto 1. 0. Path.empty))
(* ou encore *)
let img = Path.empty |> Path.moveto 1. 0. |> Path.lineto 0. 1. |> Path.draw
```

Note : la seconde version utilise l'opérateur `|>` pour écrire
l'enchaînement des opérations dans un ordre plus naturel. `|>` est une
application indiquant d'abord l'argument puis la fonction : `x |> f`
signifie `f x`. Et en cas d'arguments multiples, `y |> f x` signifie
donc `f x y`.

### Tortue

Une tortue est décrite ici par le type `turtle` donnant
ses coordonnées `x` et `y`, ainsi que son angle actuel et le chemin
effectué par cette tortue jusqu'ici. Afficher le cheminement d'une tortue
`t` se fait donc via `Path.draw t.path`. L'angle indique la direction prise
par la tortue quand elle avancera. Cet angle est exprimé en degré.
Un angle de `0.` indique la droite, un angle de `90.` degrés indique le haut.

**Question 1** : écrire une fonction `make_turtle : float -> float ->
turtle` initialisant une tortue à une certaine position `(x,y)`, avec
un angle `0.` et un chemin sans tracé et de dernier point `(x,y)`.

**Question 2** : écrire une fonction `forward : float -> bool -> turtle ->
turtle` telle que `(forward dist trace t)` représente l'état de la tortue
`t` après une avancée d'une distance `dist` selon l'angle courant
de la tortue, le booléen `trace` indiquant si cette avancée se fait en
traçant le trait correspondant ou non.

Le type `command` décrit une action possible d'une tortue : avancer
d'une certaine distance (avec tracé ou non), tourner d'un certain
angle (c'est-à-dire ajouter une quantité à l'angle courant, toujours
en degré), ou bien répéter un certain nombre de fois un groupe de
commandes.

**Question 3** : écrire une fonction `run : commands -> turtle ->
turtle` qui implémente l'effet d'une succession de commandes sur une
tortue.

### Dessinons

**Question 4** : écrire une fonction `triangle : float -> commands`
telle que `(triangle size)` donne des commandes dessinant un triangle
équilatéral de côté `size`. Utiliser le point et l'angle courant
comme départ et arrivée et tourner dans le sens trigonométrique
direct. Utiliser le constructeur `Repeat` pour abréger les commandes
produites.

**Question 5** : même question pour `square : float -> commands`
produisant un carré d'un certain côté, puis `polygon : int
-> float -> commands` telle que `(polygon n size)` produit un polygone
régulier à `n` côtés de taille `size`. Vérifier qu'on peut dessiner un
cercle via un polygone régulier à beaucoup de côtés.

**Question 6** : écrire une fonction `spiral` telle que
`(spiral size factor angle n)` donne `[Line d1; Turn angle; ...; Line dn; Turn angle]` avec les distances `di` obtenues en partant de `size` puis en multipliant
par `factor` à chaque fois. Ici le constructeur `Repeat` ne pourra pas être utilisé. Expérimenter pour trouver de jolies spirales
(par exemple `spiral 0.1 0.95 10. 100`).

