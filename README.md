# CompareVgImages


## The project

</br>

CompareVgImages is a tool to help you compare [Vg.image](https://erratique.ch/software/vg/doc/Vg/I/index.html) in a different way than with only the [I.equal](https://erratique.ch/software/vg/doc/Vg/I/index.html#val-equal) function.

</br>

<strong>Summary</strong>

The [Vg](https://erratique.ch/software/vg/doc/Vg/index.html) module let you use an I.equal function that checks if two images are exactly equals.

However, when you look at two images, they can look alike even if they don't have the same constructors (example the image of an 'L' and the image of a 'J' which was mirrored.
    
The [Compare](src/compare.mli) module tries to check if two images are visually equal.

</br>

<strong>How it works</strong> 

Vg.image constructors are hidden, in order to do pattern-matching with a Vg.image you need to reconstruct the constructors tree.

In order to do that we use the [Vg.I.to_string](https://erratique.ch/software/vg/doc/Vg/I/index.html#val-to_string) function to transform images to string and then, with some custom parsing, we transfom a Vg.image to a [Compare.i_tree](src/compare.mli).

Having this tree we can manipulate the Vg.image infos to try compare them. 

</br>

<strong>When to use</strong>

CompareVgImages is made to be used with [learn-OCaml](https://github.com/ocaml-sf/learn-ocaml), a platform for learning the OCaml language, featuring a Web toplevel, an exercise environment, and a directory of lessons and tutorials.

However, it's utilisation will be more user-friendly with [easy-check](https://github.com/lsylvestre/easy-check), a tool to help you correct and grade exercices for the learn-OCaml platform.

</br>

---


## Howtos

</br>

To learn how to install and use all of these plateform you can check the [HOWTO.md](https://github.com/MrBigoudi/CompareVgImages/blob/main/HOWTO.md) file.

If you follow the instructions you'll be able to try the samples given [here](https://github.com/MrBigoudi/CompareVgImages/tree/main/samples).

If you need more information about CompareVgImages, feel free to read the [documentation](https://htmlpreview.github.io/?https://github.com/MrBigoudi/CompareVgImages/blob/main/doc/index.html) or open an issue request ^^ .

</br>

---


## Author

</br>

CompareVgImages is a tiny free and open source tool.

Made by :

* Kedadry Yannis, Sorbonne University, Paris, France

Usable for 

* [Learn-OCaml](https://github.com/ocaml-sf/learn-ocaml) by Benjamin Canou, Çağdaş Bozman and Grégoire Henry

* [easy-check](https://github.com/lsylvestre/easy-check) by Loïc Sylvestre Sorbonne University, Paris, France


