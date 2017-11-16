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

Go a un certain nombre de fonctions incluses, comme `println`, qui peuvent être utilisées sans références. Nous ne pouvons pas aller très loin sans utiliser la librairie standard de Go et éventuellement des librairies tierces. En Go, le mot-clé `import` est utilisé pour déclarer un paquet qui est utilisé dans le code du fichier source.

Modifions notre programme :

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

Que vous pouvez exécuter via :

```
go run main.go 9000
```
Nous utilisons deux des paquets standards de Go : `fmt` et `os`. Nous avons également introduit l'utilisation d'une autre fonction stadard `len`. `len` retourne la taille d'une `string` ou le nombre de valeur dans un dictionnaire ou, comme nous le voyons ici, le nombre d'élément d'un tableau. Si vous vous demandez pourquoi nous attendons deux arguments, c'est parce le premier arguement (à l'index 0) est toujours le chemin courant où s'exécute le programme. (Modifiez le programme pour qu'il l'affiche et que vous le voyez par vous même).

Vous avez probablement noté que nous préfixons le nom de la fonction avec son paquet, c'est à dire `fmt.Println`. Ceci est différent de la plupart des autres langages ; nous en apprendrons plus sur les paquets dans les chapitres suivants. Pour l'instant, savoir comment importer et utiliser un paquet est un bon début.

Go est strict quant à l'importation des paquets. Il ne compilera pas si vous importez un paquet que vous n'utilisez pas. Essayez d'exécuter le code suivant :

```go
package main

import (
  "fmt"
  "os"
)

func main() {
}
```

Vous devriez avoir deux erreurs à propos de `fmt` et `os` qui sont importés mais non utilisés. Est-ce ennuyant ? Absolument. Vous vous y habituerez (ca va quand même être ennuyeux). Go est strict sur ce point car des imports non utilisés peuvent ralentir la compilation ; à un point que nous n'imaginons pas à ce niveau.

Une autre chose à savoir est que la librairie standard de Go est très bien documentée. Vous pouvez jetez un coup d'oeil à <https://golang.org/pkg/fmt/#Println> pour en apprendre plus sur la fonction `Println` qui est utilisée. Vous pouvez cliquer sur l'entête de la section pour voir le code source. De plus, défilez vers le haut pour en apprendre plus sur les possibilités de formatage de Go.

Si vous avez des soucis d'acccès à Internet, vous pouvez consulter localement la documentation via :

```
godoc -http=:6060
```

et aller avec votre navigateur sur `http://localhost:6060`

## Variables et déclarations

Ca serait bien si on pouvait faire le tour de la question des déclarations de variable en disant *on déclare et assigne une variable en faisant x = 4*. Malheureusement, ce n'est pas aussi simple. Nous allons débuter avec des exemples simples. Puis, au prochain chapitre, nous approfondirons avec la création et l'utilisation des structures. Néanmoins, il vous faudra certainement un peu de temps pour vous sentir vraiment à l'aise avec ça.

Vous pouvez être en train de vous dire *Woah ! C'est si compliqué que ça ?* Regardons quelques exemples.

La manière la plus explicite de traiter de la déclaration et de l'assignement des variables en Go est également la plus verbeuse :

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

Ici, nous déclarons une variable `power` de type `int`. Par défaut, Go assigne une valeur nulle au variable. Les entiers reçoivent `0`, les booléens `false`, les chaînes de caractères `""` et d'autre. Ensuite, nous assignons `9000` à notre variable `power`. Nous pouvons fusionner les deux première lignes :

```go
var power int = 9000
```

Il reste toujours le typage. Go à un opérateur plus pratique qui est capable de déduire le type déclaré :

```go
power := 9000
```

C'est pratique et cela fonctionne également avec les fonctions :

```go
func main() {
  power := getPower()
}

func getPower() int {
  return 9001
}
```

Il est important que vous vous souveniez que `:=` est utilisé pour déclarer tout en assignant une valeur à une variable. Pourquoi ? Parce qu'une variable ne peut être déclarée deux fois (tout du moins pas dans le même périmétre). Si vous essayez d'exécutez le code suivant, vous obtiendrez une erreur :

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

Le compilateur va lever une erreur *no new variables on left side of :=*. Ceci veut dire que lors de la première déclaration de variable, nous utilisons `:=` mais pour assignber une nouvelle valeur, nous utiliserons l'opérateur `=`. cela fait sens mais il peut être difficile de se souvenir quand utiliser l'un ou l'autre.

Si vous regardez de près le message d'erreur, vous noterez que *variables* est au pluriel. Ceci est dû au fait que Go vous permet d'assigner plusieurs variables sur la même ligne (aussi bien avec `=` qu'avec `:=`) :

```go
func main() {
  name, power := "Goku", 9000
  fmt.Printf("%s's power is over %d\n", name, power)
}
```

Si au moins l'une des variables est nouvelle, vous devez utiliser `:=` :

```go
func main() {
  power := 1000
  fmt.Printf("default power is %d\n", power)

  name, power := "Goku", 9000
  fmt.Printf("%s's power is over %d\n", name, power)
}
```

Bien que `power` est déjà utilisé deux fois avec `:=`, le compilateur ne lèvera pas d'erreur, il verra que `name` est une nouvelle variable et permet donc l'utilisation de `:=`. Néanmoins, vous ne pouvez pas changer le type de `power`, il est déclaré implicitement comme un entier et peut donc se voir assigné uniquement des entiers.

Pour le moment, la dernière chose à savoir, comme les imports, Go ne vous autorise pas de na pas utiliser des variables déclarées. Par exemple :

```go
func main() {
  name, power := "Goku", 1000
  fmt.Printf("default power is %d\n", power)
}
```

ne compilera pas car `name` est déclaré mais non utilisé. Tout comme les import non utilisés peuvent causer de la frustration, je pense que ceci nous aide à gerder un code propre et lisible.

Il y en a encore à apprendre sur les déclarations et les assignations mais pour le moment, souvenez-vous que l'on utilise `var NAME TYPE` quand on déclare une variable à sa valeur nulle, `NAME := VALUE` quand on déclare et assigne une valeur et `NAME = VALUE` lorsque l'on assigne une nouvelle valeur à une variable précédemment déclarée.

## Déclarations de fonctions

C'est le moment de préciser que les fonctions peuvent retourner de multiples valeurs. Regardez ces trois fonctions : une sans retour de valeur, une avec une valeur de retour et une qui retourne deux valeurs :

```go
func log(message string) {
}

func add(a int, b int) int {
}

func power(name string) (int, bool) {
}
```

Nous utilisons la dernière de cette façon :

```go
value, exists := power("goku")
if exists == false {
  // handle this error case
}
```

Parfois, seule l'une des valeurs vous intéresse. Dans ce cas, vous assignez `_` à l'autre valeur :

```go
_, exists := power("goku")
if exists == false {
  // handle this error case
}
```

Ceci est plus qu'une convention. `_`, l'identifiant vide (*blank identifier*) est spécial dans le sens où la valeur de retour n'est en fait pas assigné. Ceci vous permet d'utiliser `_` sans se préoccuper du type retourné par la fonction.

Pour finir, il y a quelque chose que vous devez encore savoir sur la déclaration de fonction : si des paramétres partage le même type, vous pouvez utiliser une syntaxe plus courte : 

```go
func add(a, b int) int {

}
```
Pouvoir retourner plusieurs valeurs est quelque chose que vous utiliserez souvent. Vous utiliserez fréquemment `_` pour ignorer une valeur. Les valeurs de retour nommées et les déclarations de paramètres raccourcies ne sont pas si habituel. Néanmoins vous devez les rencontrerez souvent et il est important de les connaitres.

## Avant de continuer

Nous avons regarder plusieurs point qui peuvent sembler n'avoir aucun rapport les uns avec les autres. Nous allons doucement construire des exemples plus important et j'espère que ces points vont commencer à s'emboîter ensemble.

Si vous venez d'un langage dynamique, la complexité autour du typage et des déclarations peuvent sembler comme un pas en arrière. Je vous l'accorde. Pour certain système, les langages dynamiques sont catégoriquement plus productif.

Si vous venez d'un langage typé statiquement, vous vous semblez probablement à l'aise avec Go. La déduction du typage et le retour de multiples valeurs sont appréciables (ce n'est pas exclusif au Go). Au fur et à mesure que vous en apprendrez plus sur le langage, vous en apprécierez la syntaxe propre et fluide.
