# Avant-Propos

Cet exercice est une modification de l'exercice 7.1.tortue proposé aux étudiants par la licence d'informatique de Sorbonne Université.

Les modifications aportées à cet exercice ont pour but de faire utiliser aux étudiant le module Vg sans passer par un module intermédiaire.

# L'exercice

Dans cet exercice, on va dessiner dans Learn-ocaml en utilisant une *tortue* graphique inspirée par le langage [Logo](https://fr.wikipedia.org/wiki/Logo_(langage)).

### Graphisme dans Learn-ocaml

Dans la suite, toutes les images seront de taille `1.0 x 1.0`, avec l'origine (i.e. le point de coordonnées `(0., 0.)`) en bas à gauche. Pour afficher un dessin, il suffit de fabriquer dans le Toplevel une valeur OCaml du type [`Vg.image`](https://erratique.ch/software/vg/doc/Vg/index.html). 

Nous obtiendrons ici ces images via les fonctions suivantes sur les chemins `Vg.path` : 

  - `Gg.P2.v : float -> float -> Gg.p2` crée un point à partir de float

  - `Vg.P.empty : Vg.path` donne un chemin avec uniquement le point origine et aucun tracé.

  - `Vg.P.line : ?⁠rel:bool -> Gg.p2 -> path -> path` telle que `(Vg.P.line g p)` prolonge un chemin `p` en traçant une ligne entre le dernier point de ce chemin `p` et les coordonnées `(x,y)`.

  - `Vg.P.sub : ?⁠rel:bool -> Gg.p2 -> path -> path` fonctionne comme `Vg.P.line` sauf que le déplacement final au point indiqué se fait sans tracé.

Par exemple une image avec un segment entre les points `(1.,0.)` et `(0.,1.)` peut s'obtenir ainsi :

```ocaml
let img = 
  let p = (Vg.P.line (Gg.P2.v 0. 1.) (Vg.P.sub (Gg.P2.v 1. 0.) Vg.P.empty)) in
    let area = `O { Vg.P.o with Vg.P.width = 0.002 } in
      Vg.I.const Gg.Color.black |> Vg.I.cut ~area p
(* ou encore *)
let img = 
  let p =  Vg.P.empty |> Vg.P.sub (Gg.P2.v 1. 0.) |> Vg.P.line (Gg.P2.v 0. 1.) in
  let area = `O { Vg.P.o with Vg.P.width = 0.002 } in
      I.const Gg.Color.black |> I.cut ~area p
```

Note : on utilise l'opérateur `|>` pour écrire l'enchaînement des opérations dans un ordre plus naturel. `|>` est une application indiquant d'abord l'argument puis la fonction : `x |> f`
signifie `f x`. Et en cas d'arguments multiples, `y |> f x` signifie donc `f x y`.

Pour aléger les écritures, on fournit une fonction `draw : Vg.path -> Vg.image` qui permet d'afficher une image à partir d'un chemin.

### Tortue

Une tortue est décrite ici par le type `turtle` donnant ses coordonnées `x` et `y`, ainsi que son angle actuel et le chemin effectué par cette tortue jusqu'ici. Afficher le cheminement d'une tortue
`t` se fait donc via `draw t.path`. L'angle indique la direction prise par la tortue quand elle avancera. Cet angle est exprimé en degré. Un angle de `0.` indique la droite, un angle de `90.` degrés indique le haut.

**Question 1** : écrire une fonction `make_turtle : float -> float -> turtle` initialisant une tortue à une certaine position `(x,y)`, avec un angle `0.` et un chemin sans tracé et de dernier point `(x,y)`.

**Question 2** : écrire une fonction `forward : float -> bool -> turtle -> turtle` telle que `(forward dist trace t)` représente l'état de la tortue `t` après une avancée d'une distance `dist` selon l'angle courant de la tortue, le booléen `trace` indiquant si cette avancée se fait en traçant le trait correspondant ou non.

Le type `command` décrit une action possible d'une tortue : avancer d'une certaine distance (avec tracé ou non), tourner d'un certain angle (c'est-à-dire ajouter une quantité à l'angle courant, toujours en degré), ou bien répéter un certain nombre de fois un groupe de commandes.

**Question 3** : écrire une fonction `run : commands -> turtle -> turtle` qui implémente l'effet d'une succession de commandes sur une tortue.

### Dessinons

**Question 4** : écrire une fonction `triangle : float -> commands` telle que `(triangle size)` donne des commandes dessinant un triangle équilatéral de côté `size`. Utiliser le point et l'angle courant comme départ et arrivée et tourner dans le sens trigonométrique direct. Utiliser le constructeur `Repeat` pour abréger les commandes produites.

**Question 5** : même question pour `square : float -> commands` produisant un carré d'un certain côté, puis `polygon : int -> float -> commands` telle que `(polygon n size)` produit un polygone régulier à `n` côtés de taille `size`. Vérifier qu'on peut dessiner un cercle via un polygone régulier à beaucoup de côtés.

**Question 6** : écrire une fonction `spiral` telle que `(spiral size factor angle n)` donne `[Line d1; Turn angle; ...; Line dn; Turn angle]` avec les distances `di` obtenues en partant de `size` puis en multipliant par `factor` à chaque fois. Ici le constructeur `Repeat` ne pourra pas être utilisé. Expérimenter pour trouver de jolies spirales (par exemple `spiral 0.1 0.95 10. 100`).