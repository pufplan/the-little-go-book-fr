# Chapitre 2 - Structures

Go n'est pas un langage orienté objet tel que le C++, Java, Ruby ou C#. Il n'a pas de notions d'héritage, ni de concepts d'association comme le polymorphisme et la surchage.

Go utilise des structures qui peuvent être associées avec des méthodes. Go supporte également une forme de composition simple mais efficace. Quoiqu'il en soit, il en résulte un code plus simple mais dans certaines occasions, il peut manquer des facilités de la programmation orientée objet. Il vaut la peine d'être souligné que la *composition sur l'héritage* est un vieux début auxquel Go adopte une position ferme.

Bien que Go n'ai pas les concepts orientés objets dont vous avez l'habitude, vous noterez qu'il y a beaucoup de similitudes entre une structure et une classe. Un simple exemple avec la structure `Saiyan` suivante :

```go
type Saiyan struct {
  Name string
  Power int
}
```

Nous allons plus tard comment ajouter une méthode à cette structure, un peu comme si vous aviez une méthode d'une classe. Avant de voir cela, nous devons appronfondir les déclarations.

## Déclarations et initialisations

Quand nous avons regardé les variables et les déclarations, nous nous sommes intéressé seulement aux types par défaut comme les entiers et les chaînes de caractères. Maintenant que nous parlons des structures, nous avons besoin d'en savoir plus sur les pointeurs.

La manière la plus simple d'assigner des valeurs à notre structure est :

```go
goku := Saiyan{
  Name: "Goku",
  Power: 9000,
}
```

*Note:* La virgule `,` au sein de la structure ci-dessus est obligatoire. Sans celle-ci, le compilateur renvoi une erreur. Vous apprécierez cette obligation, particulièrement si vous avez utilisé un langage ou un format qui vous force à faire le contraire.

Nous ne sommes pas obligé de donner une valeur pour chaque champs. Les deux déclarations ci-dessous sont valides :

```go
goku := Saiyan{}

// ou

goku := Saiyan{Name: "Goku"}
goku.Power = 9000
```

Les champs qui ne reçoivent pas de valeur sont initialisé avec la valeur par défaut, de la même manière que les variables non-assignée.

En outre, vous pouvez omettre le nom du champs et donner des valeurs selon l'ordre de la déclaration des champs (mais pour des questions de clarté, vous ne devriez le faire que pour des structures avec peu de champs)

```go
goku := Saiyan{"Goku", 9000}
```

L'exemple ci-dessus déclare une variable `goku` et lui assigne des valeurs.

Many times though, we don't want a variable that is directly associated with our value but rather a variable that has a pointer to our value. A pointer is a memory address; it's the location of where to find the actual value. It's a level of indirection. Loosely, it's the difference between being at a house and having directions to the house.

Why do we want a pointer to the value, rather than the actual value? It comes down to the way Go passes arguments to a function: as copies. Knowing this, what does the following print?

```go
func main() {
  goku := Saiyan{"Goku", 9000}
  Super(goku)
  fmt.Println(goku.Power)
}

func Super(s Saiyan) {
  s.Power += 10000
}
```

The answer is 9000, not 19000. Why? Because `Super` made changes to a copy of our original `goku` value and thus, changes made in `Super` weren't reflected in the caller. To make this work as you probably expect, we need to pass a pointer to our value:

```go
func main() {
  goku := &Saiyan{"Goku", 9000}
  Super(goku)
  fmt.Println(goku.Power)
}

func Super(s *Saiyan) {
  s.Power += 10000
}
```

We made two changes. The first is the use of the `&` operator to get the address of our value (it's called the *address of* operator). Next, we changed the type of parameter `Super` expects. It used to expect a value of type `Saiyan` but now expects an address of type `*Saiyan`, where `*X` means *pointer to value of type X*. There's obviously some relation between the types `Saiyan` and `*Saiyan`, but they are two distinct types.

Note that we're still passing a copy of `goku's` value to `Super` it just so happens that `goku's` value has become an address. That copy is the same address as the original, which is what that indirection buys us. Think of it as copying the directions to a restaurant. What you have is a copy, but it still points to the same restaurant as the original.

We can prove that it's a copy by trying to change where it points to (not something you'd likely want to actually do):

```go
func main() {
  goku := &Saiyan{"Goku", 9000}
  Super(goku)
  fmt.Println(goku.Power)
}

func Super(s *Saiyan) {
  s = &Saiyan{"Gohan", 1000}
}
```

The above, once again, prints 9000. This is how many languages behave, including Ruby, Python, Java and C#. Go, and to some degree C#, simply make the fact visible.

It should also be obvious that copying a pointer is going to be cheaper than copying a complex structure. On a 64-bit machine, a pointer is 64 bits large. If we have a structure with many fields, creating copies can be expensive. The real value of pointers though is that they let you share values. Do we want `Super` to alter a copy of `goku` or alter the shared `goku` value itself?

All this isn't to say that you'll always want a pointer. At the end of this chapter, after we've seen a bit more of what we can do with structures, we'll re-examine the pointer-versus-value question.

## Functions on Structures

We can associate a method with a structure:

```go
type Saiyan struct {
  Name string
  Power int
}

func (s *Saiyan) Super() {
  s.Power += 10000
}
```

In the above code, we say that the type `*Saiyan` is the **receiver** of the `Super` method. We call `Super` like so:

```go
goku := &Saiyan{"Goku", 9001}
goku.Super()
fmt.Println(goku.Power) // will print 19001
```

## Constructors

Structures don't have constructors. Instead, you create a function that returns an instance of the desired type (like a factory):

```go
func NewSaiyan(name string, power int) *Saiyan {
  return &Saiyan{
    Name: name,
    Power: power,
  }
}
```

This pattern rubs a lot of developers the wrong way. On the one hand, it's a pretty slight syntactical change; on the other, it does feel a little less compartmentalized.

Our factory doesn't have to return a pointer; this is absolutely valid:

```go
func NewSaiyan(name string, power int) Saiyan {
  return Saiyan{
    Name: name,
    Power: power,
  }
}
```

## New

Despite the lack of constructors, Go does have a built-in `new` function which is used to allocate the memory required by a type. The result of `new(X)` is the same as `&X{}`:

```go
goku := new(Saiyan)
// same as
goku := &Saiyan{}
```

Which you use is up to you, but you'll find that most people prefer the latter whenever they have fields to initialize, since it tends to be easier to read:

```go
goku := new(Saiyan)
goku.name = "goku"
goku.power = 9001

//vs

goku := &Saiyan {
  name: "goku",
  power: 9000,
}
```

Whichever approach you choose, if you follow the factory pattern above, you can shield the rest of your code from knowing and worrying about any of the allocation details.

## Fields of a Structure

In the example that we've seen so far, `Saiyan` has two fields `Name` and `Power` of types `string` and `int`, respectively. Fields can be of any type -- including other structures and types that we haven't explored yet such as arrays, maps, interfaces and functions.

For example, we could expand our definition of `Saiyan`:

```go
type Saiyan struct {
  Name string
  Power int
  Father *Saiyan
}
```

which we'd initialize via:

```go
gohan := &Saiyan{
  Name: "Gohan",
  Power: 1000,
  Father: &Saiyan {
    Name: "Goku",
    Power: 9001,
    Father: nil,
  },
}
```

## Composition

Go supports composition, which is the act of including one structure into another. In some languages, this is called a trait or a mixin. Languages that don't have an explicit composition mechanism can always do it the long way. In Java, there's the possibility to extend structures with *inheritance* but, in a scenario where this is not an option, a mixin would be written like this:

```java
public class Person {
  private String name;

  public String getName() {
    return this.name;
  }
}

public class Saiyan {
  // Saiyan is said to have a person
  private Person person;

  // we forward the call to person
  public String getName() {
    return this.person.getName();
  }
  ...
}
```

This can get pretty tedious. Every method of `Person` needs to be duplicated in `Saiyan`. Go avoids this tediousness:

```go
type Person struct {
  Name string
}

func (p *Person) Introduce() {
  fmt.Printf("Hi, I'm %s\n", p.Name)
}

type Saiyan struct {
  *Person
  Power int
}

// and to use it:
goku := &Saiyan{
  Person: &Person{"Goku"},
  Power: 9001,
}
goku.Introduce()
```

The `Saiyan` structure has a field of type `*Person`. Because we didn't give it an explicit field name, we can implicitly access the fields and functions of the composed type. However, the Go compiler *did* give it a field name, consider the perfectly valid:

```go
goku := &Saiyan{
  Person: &Person{"Goku"},
}
fmt.Println(goku.Name)
fmt.Println(goku.Person.Name)
```

Both of the above will print "Goku".

Is composition better than inheritance? Many people think that it's a more robust way to share code. When using inheritance, your class is tightly coupled to your superclass and you end up focusing on hierarchy rather than behavior.

### Overloading

While overloading isn't specific to structures, it's worth addressing. Simply, Go doesn't support overloading. For this reason, you'll see (and write) a lot of functions that look like `Load`, `LoadById`, `LoadByName` and so on.

However, because implicit composition is really just a compiler trick, we can "overwrite" the functions of a composed type. For example, our `Saiyan` structure can have its own `Introduce` function:

```go
func (s *Saiyan) Introduce() {
  fmt.Printf("Hi, I'm %s. Ya!\n", s.Name)
}
```

The composed version is always available via `s.Person.Introduce()`.

## Pointers versus Values

As you write Go code, it's natural to ask yourself *should this be a value, or a pointer to a value?* There are two pieces of good news. First, the answer is the same regardless of which of the following we're talking about:

* A local variable assignment
* Field in a structure
* Return value from a function
* Parameters to a function
* The receiver of a method

Secondly, if you aren't sure, use a pointer.

As we already saw, passing values is a great way to make data immutable (changes that a function makes to it won't be reflected in the calling code). Sometimes, this is the behavior that you'll want but more often, it won't be.

Even if you don't intend to change the data, consider the cost of creating a copy of large structures. Conversely, you might have small structures, say:

```go
type Point struct {
  X int
  Y int
}
```

In such cases, the cost of copying the structure is probably offset by being able to access `X` and `Y` directly, without any indirection.

Again, these are all pretty subtle cases. Unless you're iterating over thousands or possibly tens of thousands of such points, you wouldn't notice a difference.

## Before You Continue

From a practical point of view, this chapter introduced structures, how to make an instance of a structure a receiver of a function, and added pointers to our existing knowledge of Go's type system. The following chapters will build on what we know about structures as well as the inner workings that we've explored.