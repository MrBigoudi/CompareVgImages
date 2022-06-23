# HowTo 

## Setup and Installations

Before you can use CompareVgImages you'll need to follow several steps.

### Install dependencies

Only <strong>opam</strong> is necessary to build and use learn-Ocaml, easy-check and CompareVgImages. 

```sh
    ## Linux
    # for Arch based distro
    pacman -S opam
    # for Debian based distro
    apt-get install opam

    ## MacOS
    # Homebrew
    brew install opam
    # MacPort
    port install opam
```

### Create a new folder to concentrate your environment

Since you'll need diferent github folder to use learn-Ocaml, easy-check and CompareVgImages properly it might be a good (<em>but not necessary</em>) option to concentrate all these folders in one environment.

```sh
    mkdir learn-ocaml-env
    cd learn-ocaml-env
```

### Install learnOCaml

```sh
    git clone https://github.com/ocaml-sf/learn-ocaml.git
    cd learn-ocaml
    opam switch create for-learn-ocaml ocaml-base-compiler.4.12.0
    opam install opam-installer
    eval $(opam env)
    opam install . --deps-only
    make && make opaminstall

    # test if everything's ok
    make testrun
    $BROWSER localhost:8080
```

### Install easy-check

```sh
    cd ..
    git clone https://github.com/lsylvestre/easy-check.git

    # test if everything's ok
    cd easy-check/demo
    make
    $BROWSER localhost:8080
    # ^C
    make clean
```

### Install CompareVgImages

Since CompareVgImages will only be used to correct easy-check exercices, it might be better to place the git folder inside the <strong>easy-check/demo/exercices</strong> folder.

```sh
    cd exercices
    git clone https://github.com/MrBigoudi/CompareVgImages.git

    ## test if everything's ok
    cd CompareVgImages
    # try samples
    cp samples/index.json ../.
    cd ../../easy-check/demo
    # need to do a first make to add images for the exercice description
    make
    # ^C
    cp -r exercises/CompareVgImages/samples/vgTutorial/images/ www/icons/.
    cp -r exercises/CompareVgImages/samples/jfp12/images/ www/icons/.
    # the real test this time
    make
    $BROWSER localhost:8080
    # ^C
```


## How to use CompareVgImages

You can write all your exercices in the <strong>easy-check/demo/exercices</strong> folder. Everytime you add an exercice you''ll have to change the <strong>easy-check/demo/exercices/index.json</strong> file accordingly (<em>as an example you can compare the index.json from the initial clone of easy-check and the one in the sample given in CompareVgImages</em>).

To learn how to write an exercice for learn-ocaml, I invite you to read the [learn-ocaml documentation](https://github.com/ocaml-sf/learn-ocaml/tree/master/docs).

To learn how to correct an exercice using easy-check, I invite you to read the article <strong>Expérimentations pédagogiques en Learn-OCaml <em>(by Loïc Sylvestre and Emmanuel Chailloux)</em></strong> in the paper <strong>[proceedings-jfla-2020](https://hal.inria.fr/hal-02427360)</strong> <em>(only available in French)</em>.

To test a function producing Vg.image you can use CompareVgImages. 

In your <strong>test.ml</strong> file, you'll have to add <strong>~equal: Compare.image_equal</strong> as an optional parameter of the Check.name function.

For example :

```Ocaml
(*solution.ml*)
let create_circle x y color r = 
  let p = 
    let rel = true in
    P.empty |>
    P.sub (P2.v x y) |>
    P.circle ~rel (P2.v 0. 0.) r |>
    P.close
  in I.const color |> I.cut p;;
```

```OCaml
(*test.ml*)
let red = Color.red;;
let green = Color.green;;
let blue = Color.blue;;

let q () = 
  Assume.compatible "create_circle" [%ty : float -> float -> color -> float -> image];
  Check.name4 "create_circle" [%ty : float -> float -> color -> float -> image]
    ~equal: Compare.image_equal
    ~testers: [ Autotest.(tester (tuple4 (float 0 1) (float 0 1) (oneof [red; green; blue]) (float 0 1)))]
    [];;

let () =
  Result.set (Result.questions [q])
```

You'll also have to change <strong>depend.txt</strong> files to add CompareVgImages as a dependency.

```sh 
  echo -e "\n\n## vg compare\n" >> depend.txt
  echo -e "../CompareVgImages/src/compare.ml" >> depend.txt
  echo -e "../CompareVgImages/src/compare.mli" >> depend.txt

  # check if evertything is ok
  cat depend.txt
```