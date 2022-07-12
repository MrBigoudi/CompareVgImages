# Graphes

Pour ces exercices, nous allons essayer d'afficher différents types de graphes pour des fonctions en utilisant le module Vg. On aura donc besoin de certaines connaissances sur le module Vg. Il est donc nécessaire d'avoir vu le tutoriel Vg disponible dans la liste des exercices.

**Question 1** : écrivez la fonction

```OCaml
  val draw_basis : unit -> Vg.image
```

Qui crée une image représentant le repère de notre graphe (pour transformer ce chemin en image, vous pouvez utiliser la fonction `draw_config p`).
Les flèches du repère doivent être de taille `arrow_length`.

Vous pouvez ensuite utiliser la fonction

```OCaml
  val Vg.I.blend : Vg.image -> Vg.image -> Vg.image
```

pour placer le graphe de votre fonction au dessus du repère.

<div>
  <img src="/icons/images/exercices/graphs/basis.png" 
    alt="graphs' basis" 
    width="768" 
    height="512"
  />
</div>

**Question 2** : On va commencer par écrire une fonction `graph_f_int` pour représenter le graphe d'une fonction d'entiers vers des entiers.

```OCaml
  val graph_f_int : (int -> int) -> (int*int) -> (float*float) -> Vg.path
```

Qui, étant donnée une fonction, un tuple d'entiers qui représente les limittes des valeurs que l'on test et un tuple de floattants qui représente la redimension des abscisse et ordonnées pour faire rentrer le graphe dans l'image, retourne un chemin qui représente la fonction. 

Par exemple :

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

Pour rendre les choses plus simple, vous pouvez utiliser la fonction

```OCaml
  val dot : float -> float -> Vg.path -> Vg.path
```

Qui ajoute un point aux coordonnées (x,y) sur une chemin existant.

**Question 3** : Nous allons maintenant essayer d'implémenter une fonction `graph_f_int_hist` pour afficher un histogramme. 

```OCaml
  val graph_f_int_hist : (int -> int) -> (int*int) -> (float*float) -> float -> Vg.path
```

Qui, étant donné les même arguments que pour la fonction précédente et un floattant représentant la largeur d'un segment, retourne le chemin représentant l'histogramme d'une fonction.

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

<em> Aide: essayer d'abord d'implémenter une fonction qui retourne le chemin d'un rectangle connaissant sa largeur et la position de son coin haut-gauche.

**Question 4** : Nous allons maintenant essayer de modifier la fonction précédente pour prendre les floattants en considération.

écrivez la fonction :

```OCaml
  val graph_f_float : (float -> float) -> (float*float) -> (float*float) -> float -> Vg.path
```

Qui, étant donné une fonction, un tuple de floattants représentant les limittes des abscisses à tester, un autre tuple représentant la redimension des abscisse et ordonnées pour faire rentrer le graphe dans l'image et un floattant représentant l'espace entre 2 abscisse à calculer, renvoie le chemin représentant la fonction.

Si un point n'est pas défini ou si son image est supérieure à ```OCaml infinity``` ou inférieure à ```OCaml (-1.*.infinity)```, il ne devra pas être affiché.

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
    alt="test graph_f_float" 
    width="768" 
    height="512"
  />
</div>


**Question 5** : écrivez une fonction renvoyant le chemin pour afficher l'intégral d'une fonction en prenant en argument les même paramètre que la fonction précédente et un flottant représentant la largeur des segments.

```OCaml
  val graph_integral : (float -> float) -> (float*float) -> (float*float) -> float -> float -> Vg.path
```

```OCaml
  let f x = sqrt x;;
  let bounds = (-10.,10.);;
  let scale = (0.1,0.1);;
  let space = 0.001;;
  let width = 0.001;;
  let i1 = I.const (Color.red) |> I.cut (graph_integral f bounds scale space width) in
  let i2 = I.const (Color.black) |> I.cut (graph_f_float f bounds scale space) in
    (I.blend i2 (I.blend i1 (draw_basis())));;
```

<div>
  <img src="/icons/images/exercices/graphs/graph_integral.png" 
    alt="test graph_integral" 
    width="768" 
    height="512"
  />
</div>

**Question 6** : écrivez une fonctioon `graph_multiple` prenant en argument une liste de fonctions (de floattants vers floattants) et une liste de couleurs, retournant une image représentant le graphe avec toutes ces fonctions.

Toutes ces fonctions seront affichés avec :
  - bounds = (-10.,10.)
  - scale = (0.1,0.1)
  - space = 0.001

Le repère devra être dessiné en noir.

Si la liste de couleur est plus petite que la liste des fonctions, une exception devra être levée.

```OCaml
  val graph_multiple : (float -> float) list -> Gg.color list -> Vg.image
```

```OCaml
  let f_list = [(fun x -> sqrt x);(fun x -> 1./.x);(fun x -> x)];;
  let colors = [Color.red; Color.green; Color.blue];;
  let i = (graph_multiple f_list colors);;
```

<div>
  <img src="/icons/images/exercices/graphs/graph_multiple.png" 
    alt="test graph_multiple" 
    width="768" 
    height="512"
  />
</div>
