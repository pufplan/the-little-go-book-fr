# Chapitre 1 : les bases

Go est un langage compilé, typé statiquement avec une syntaxe similaire au C et avec un ramasse-miette. Qu'est ce que cela signifie ?

## Compilation

La compilation est le processus qui transforme le code source (que vous avez écrit) en un langage bas niveau (comme de l'assembleur pour le cas de Go) ou en un langage intermédiaire (comme en Java et C#).

Il est parfois désagréable de travailler avec des langages compilés car cette compilation peut être longue. Il devient difficile d'intégrer régulièrement des modifications si vous devez attendre de longues minutes (voir des heures) que votre code compile. Cette vitesse de compilation est l'un des buts principaux de Go. Ce qui est une bonne nouvelle pour les personnes qui travaillent sur de large projets, tout autant pour ceux qui ont l'habitude des langages interprétés où il est facile de prendre en compte de nouvelles modifications.

Les langages compilés ont tendance à s'exécuter plus rapidement et sans dépendances supplémentaires (tout du moins, c'est vrai pour des langages comme le C, le C++ et le Go qui compile en assembleur).

## Typage statique

Etre typé statiquement signifie que les variables doivent être d'un type précis (int, string, bool, []byte, etc.). Ce typage est spécifié lors de la déclaration de la variable, ou dans de nombreux cas, le compilateur déduit directement ce type (nous allons voir un exemple rapidement).

Beaucoup de chose peuvent être dite sur le typage statique mais je crois qu'il est plus facile de la comprendre en regardant le code. Si vous utilisez un langage à typage dynamique, vous pourriez trouver cela encombrant. Vous n'avez pas tord, mais il y a des avantages, particulièrement lorsque vous associez le typage statique avec la compilation. Les deux sont souvent confus. Il est vrai que lorsque vous en avez un, vous avez normalement l'autre mais ce n'est pas forcément toujours le cas. Avec un système de typage rigide, le compilateur est capable de détecter des problèmes au-delà de simples erreurs syntaxiques et également d'autres optimisations. 

## Syntaxe proche du C

Dire que ce langage a une syntaxe proche du C siginifie que si vous utilisez un autre langage également proche du C (C, C++, Java, JavaScript et C#), vous allez trouver Go familier, superficiellement du moins. Par example, cela signifie que `&&` est utilisé comme booléen AND, `==` est utilisé pour tester l'égalité, `{` et `}` débutent et terminent un bloc et les tableaux débutent à l'indice 0.

La syntaxe proche du C à également tendance à signifier que les point-virgule terminent les lignes et qu'il y a des parenthèses autour des conditions. Go n'applique pas ces principes bien que les parenthèses soient utilisées pour controler la priorité. Par exemple, une boucle `if` ressemble à :


```go
if name == "Leto" {
  print("the spice must flow")
}
```

Et dans des cas cas plus compliqués, les parenthèses sont utiles :

```go
if (name == "Goku" && power > 9000) || (name == "gohan" && power < 4000)  {
  print("super Saiyan")
}
```

Au-delà de ça, Go est plus proche du C que C# ou Java, pas seulement en terme de syntaxe, mais en terme d'objectif. Cela se reflète dans la finesse et la simplicité du langage ce qui, nous l'espérons, commencera à devenir évident à mesure que vous l'apprendrez.

## Ramasse-miettes

Certaines variables, quand elles sont crées, ont un cycle de vie facile à déterminer. Une variable locale à une fonction par exemple disparait à la fin de l'appel. Dans d'autres cas, ce n'est pas si évident, tout du moins pour le compilateur. Par exemple, la durée de vie d'une variable retournée par une fonction ou référencée par d'autres variables ou objets peut être difficile à déterminer. Sans un ramasse-miettes, c'est au développeur de libérer la mémoire lorsque la variable n'est plus utile. Comment ? En C, vous libérez littéralement la variable avec `free(str);`.

Les langages avec un ramasse-miettes (c-à-d Ruby, Python, Java, JavaScript, C#, Go) sont capables de tracer l'utilisation des variables et de libérer lorsqu'elles ne sont plus utilisées. Le ramasse-miettes ajoute une surcouche mais élimine également un certain nombre de bug dévastateurs.

## Exécuter du code Go

Débutons notre périple par la création d'un simple programme et apprenons comment le compiler puis l'exécuter. Ouvrez votre éditeur de texte favoris et écrivez le code suivant :

```go
package main

func main() {
  println("it's over 9000!")
}
```
Sauvegardez le fichier sous `main.go`. Pour l'instant, vous pouvez sauvegarder n'importe où ; nous n'avons pas besoin d'un espace de travail spécifique pour les exemples triviaux.

Puis, ouvrez une ligne de commande et placez-vous dans le répertoire où vous avez sauvegardé le fichier. Pour moi, cela donne `cd ~/code`.

Enfin, exécutez le programme en tapant :

```
go run main.go
```

Si tout fonctionne correctement, vous devriez voir *it's over 9000!*.

Mais attendez, qu'en est-il de l'étape de compilation ? `go run` est une commande bien pratique qui compile *et* exécute votre code. Elle utilise un répertoire temporaire pour compiler le programme, l'exécuter puis s'auto-nettoyer. Pour voir l'emplacement temporaire utilisé :

```
go run --work main.go
```

Pour compiler explicitement le code, utilisez `go build` :

```
go build main.go
```

Ceci va générer un exécutable `main` que vous pourrez lancer. Sous Linux / OSX, n'oubliez pas de précéder d'un point et d'un slash comme ceci : `./main`.

Lors du développement, vous pouvez tout autant utiliser `go run` ou `go build`. En revanche, lors du déploiement, vous devez générer un binaire via `go build` et exécuter ce dernier ainsi généré.

### Main

J'espère que le code que nous venons d'exécuter est compréhensible. Nous avons créé une function et affiché une phrase avec la fonction intégrée `println`. Un `go run` sait-il ce qu'il doit exécuter parce qu'il n'existe qu'une seule possibilité ? Pas du tout, en Go le point d'entré d'un programme est la fonction `main` inclue dans le paquet `main`.

Nous parlerons plus des paquets dans un chapitre suivant. Pour l'instant, tant que nous nous concentrons sur la compréhension des bases de Go, nous écrirons toujours notre code dans le paquet `main`.

Si vous voulez, vous pouvez modifier le code et changer le nom du paquet. Exécutez le code via `go run` et vous devriez voir une erreur. Puis revenez au nom de paquet `main` mais en utilisant un nom de fonction différent. Vous devriez voir un message d'erreur différent du précédent. Répétez ces mêmes erreurs mais en utilisant à la place `go build`. Notez que le code compile, c'est juste qu'il n'y a pas de point d'entrée, ce qui est le comportement normal attendu lorsque, par exemple, vous codez une librairie.

## Imports

Go has a number of built-in functions, such as `println`, which can be used without reference. We can't get very far though, without making use of Go's standard library and eventually using third-party libraries. In Go, the `import` keyword is used to declare the packages that are used by the code in the file.

Let's change our program:

```go
package main

import (
  "fmt"
  "os"
)

func main() {
  if len(os.Args) != 2 {
    os.Exit(1)
  }
  fmt.Println("It's over", os.Args[1])
}
```

Which you can run via:

```
go run main.go 9000
```

We're now using two of Go's standard packages: `fmt` and `os`. We've also introduced another built-in function `len`. `len` returns the size of a string, or the number of values in a dictionary, or, as we see here, the number of elements in an array. If you're wondering why we expect 2 arguments, it's because the first argument -- at index 0 -- is always the path of the currently running executable. (Change the program to print it out and see for yourself.)

You've probably noticed we prefix the function name with the package, e.g., `fmt.Println`. This is different from many other languages. We'll learn more about packages in later chapters. For now, knowing how to import and use a package is a good start.

Go is strict about importing packages. It will not compile if you import a package but don't use it. Try to run the following:

```go
package main

import (
  "fmt"
  "os"
)

func main() {
}
```

You should get two errors about `fmt` and `os` being imported and not used. Can this get annoying? Absolutely. Over time, you'll get used to it (it'll still be annoying though). Go is strict about this because unused imports can slow compilation; admittedly a problem most of us don't have to this degree.

Another thing to note is that Go's standard library is well documented. You can head over to <https://golang.org/pkg/fmt/#Println> to learn more about the `Println` function that we used. You can click on that section header and see the source code. Also, scroll to the top to learn more about Go's formatting capabilities.

If you're ever stuck without internet access, you can get the documentation running locally via:

```
godoc -http=:6060
```

and pointing your browser to `http://localhost:6060`

## Variables and Declarations

It'd be nice to begin and end our look at variables by saying *you declare and assign to a variable by doing x = 4.* Unfortunately, things are more complicated in Go. We'll begin our conversation by looking at simple examples. Then, in the next chapter, we'll expand this when we look at creating and using structures. Still, it'll probably take some time before you truly feel comfortable with it.

You might be thinking *Woah! What can be so complicated about this?* Let's start looking at some examples.

The most explicit way to deal with variable declaration and assignment in Go is also the most verbose:

```go
package main

import (
  "fmt"
)

func main() {
  var power int
  power = 9000
  fmt.Printf("It's over %d\n", power)
}
```

Here, we declare a variable `power` of type `int`. By default, Go assigns a zero value to variables. Integers are assigned `0`, booleans `false`, strings `""` and so on. Next, we assign `9000` to our `power` variable. We can merge the first two lines:

```go
var power int = 9000
```

Still, that's a lot of typing. Go has a handy short variable declaration operator, `:=`, which can infer the type:

```go
power := 9000
```

This is handy, and it works just as well with functions:

```go
func main() {
  power := getPower()
}

func getPower() int {
  return 9001
}
```

It's important that you remember that `:=` is used to declare the variable as well as assign a value to it. Why? Because a variable can't be declared twice (not in the same scope anyway). If you try to run the following, you'll get an error.

```go
func main() {
  power := 9000
  fmt.Printf("It's over %d\n", power)

  // COMPILER ERROR:
  // no new variables on left side of :=
  power := 9001
  fmt.Printf("It's also over %d\n", power)
}
```

The compiler will complain with *no new variables on left side of :=*. This means that when we first declare a variable, we use `:=` but on subsequent assignment, we use the assignment operator `=`. This makes a lot of sense, but it can be tricky for your muscle memory to remember when to switch between the two.

If you read the error message closely, you'll notice that *variables* is plural. That's because Go lets you assign multiple variables (using either `=` or `:=`):


```go
func main() {
  name, power := "Goku", 9000
  fmt.Printf("%s's power is over %d\n", name, power)
}
```

As long as one of the variables is new, `:=` can be used. Consider:

```go
func main() {
  power := 1000
  fmt.Printf("default power is %d\n", power)

  name, power := "Goku", 9000
  fmt.Printf("%s's power is over %d\n", name, power)
}
```

Although `power` is being used twice with `:=`, the compiler won't complain the second time we use it, it'll see that the other variable, `name`, is a new variable and allow `:=`. However, you can't change the type of `power`. It was declared (implicitly) as an integer and thus, can only be assigned integers.

For now, the last thing to know is that, like imports, Go won't let you have unused variables. For example,

```go
func main() {
  name, power := "Goku", 1000
  fmt.Printf("default power is %d\n", power)
}
```

won't compile because `name` is declared but not used. Like unused imports it'll cause some frustration, but overall I think it helps with code cleanliness and readability.

There's more to learn about declaration and assignments. For now, remember that you'll use `var NAME TYPE` when declaring a variable to its zero value, `NAME := VALUE` when declaring and assigning a value, and `NAME = VALUE` when assigning to a previously declared variable.

## Function Declarations

This is a good time to point out that functions can return multiple values. Let's look at three functions: one with no return value, one with one return value, and one with two return values.

```go
func log(message string) {
}

func add(a int, b int) int {
}

func power(name string) (int, bool) {
}
```

We'd use the last one like so:

```go
value, exists := power("goku")
if exists == false {
  // handle this error case
}
```

Sometimes, you only care about one of the return values. In these cases, you assign the other values to `_`:

```go
_, exists := power("goku")
if exists == false {
  // handle this error case
}
```

This is more than a convention. `_`, the blank identifier, is special in that the return value isn't actually assigned. This lets you use `_` over and over again regardless of the returned type.

Finally, there's something else that you're likely to run into with function declarations. If parameters share the same type, we can use a shorter syntax:

```go
func add(a, b int) int {

}
```

Being able to return multiple values is something you'll use often. You'll also frequently use `_` to discard a value. Named return values and the slightly less verbose parameter declaration aren't that common. Still, you'll run into all of these sooner than later so it's important to know about them.

## Before You Continue

We looked at a number of small individual pieces and it probably feels disjointed at this point. We'll slowly build larger examples and hopefully, the pieces will start to come together.

If you're coming from a dynamic language, the complexity around types and declarations might seem like a step backwards. I don't disagree with you. For some systems, dynamic languages are categorically more productive.

If you're coming from a statically typed language, you're probably feeling comfortable with Go. Inferred types and multiple return values are nice (though certainly not exclusive to Go). Hopefully as we learn more, you'll appreciate the clean and terse syntax.
