# Chapter 4 - Code Organization and Interfaces

It's now time to look at how to organize our code.

## Packages

To keep more complicated libraries and systems organized, we need to learn about packages. In Go, package names follow the directory structure of your Go workspace. If we were building a shopping system, we'd probably start with a package name "shopping" and put our source files in `$GOPATH/src/shopping/`.

We don't want to put everything inside this folder though. For example, maybe we want to isolate some database logic inside its own folder. To achieve this, we create a subfolder at `$GOPATH/src/shopping/db`. The package name of the files within this subfolder is simply `db`, but to access it from another package, including the `shopping` package, we need to import `shopping/db`.

In other words, when you name a package, via the `package` keyword, you provide a single value, not a complete hierarchy (e.g., "shopping" or "db"). When you import a package, you specify the complete path.

Let's try it. Inside your Go workspace's `src` folder (which we set up in Getting Started of the Introduction), create a new folder called `shopping` and a subfolder within it called `db`.

Inside of `shopping/db`, create a file called `db.go` and add the following code:

```go
package db

type Item struct {
  Price float64
}

func LoadItem(id int) *Item {
  return &Item{
    Price: 9.001,
  }
}
```

Notice that the name of the package is the same as the name of the folder. Also, obviously, we aren't actually accessing the database. We're just using this as an example to show how to organize code.

Now, create a file called `pricecheck.go` inside of the main `shopping` folder. Its content is:

```go
package shopping

import (
  "shopping/db"
)

func PriceCheck(itemId int) (float64, bool) {
  item := db.LoadItem(itemId)
  if item == nil {
    return 0, false
  }
  return item.Price, true
}
```

It's tempting to think that importing `shopping/db` is somehow special because we're inside the `shopping` package/folder already. In reality, you're importing `$GOPATH/src/shopping/db`, which means you could just as easily import `test/db` so long as you had a package named `db` inside of your workspace's `src/test` folder.

If you're building a package, you don't need anything more than what we've seen. To build an executable, you still need a `main`. The way I prefer to do this is to create a subfolder called `main` inside of `shopping` with a file called `main.go` and the following content:

```go
package main

import (
  "shopping"
  "fmt"
)

func main() {
  fmt.Println(shopping.PriceCheck(4343))
}
```

You can now run your code by going into your `shopping` project and typing:

```
go run main/main.go
```

### Cyclical Imports

As you start writing more complex systems, you're bound to run into cyclical imports. This happens when package A imports package B but package B imports package A (either directly or indirectly through another package). This is something the compiler won't allow.

Let's change our shopping structure to cause the error.

Move the `Item` definition from `shopping/db/db.go` into `shopping/pricecheck.go`. Your `pricecheck.go` file should now look like:

```go
package shopping

import (
  "shopping/db"
)

type Item struct {
  Price float64
}

func PriceCheck(itemId int) (float64, bool) {
  item := db.LoadItem(itemId)
  if item == nil {
    return 0, false
  }
  return item.Price, true
}
```

If you try to run the code, you'll get a couple of errors from `db/db.go` about `Item` being undefined. This makes sense. `Item` no longer exists in the `db` package; it's been moved to the shopping package. We need to change `shopping/db/db.go` to:

```go
package db

import (
  "shopping"
)

func LoadItem(id int) *shopping.Item {
  return &shopping.Item{
    Price: 9.001,
  }
}
```

Now when you try to run the code, you'll get a dreaded *import cycle not allowed* error. We solve this by introducing another package which contains shared structures. Your directory structure should look like:

```
$GOPATH/src
  - shopping
    pricecheck.go
    - db
      db.go
    - models
      item.go
    - main
      main.go
```

`pricecheck.go` will still import `shopping/db`, but `db.go` will now import `shopping/models` instead of `shopping`, thus breaking the cycle. Since we moved the shared `Item` structure to `shopping/models/item.go`, we need to change `shopping/db/db.go` to reference the `Item` structure from `models` package:

```go
package db

import (
  "shopping/models"
)

func LoadItem(id int) *models.Item {
  return &models.Item{
    Price: 9.001,
  }
}
```

You'll often need to share more than just `models`, so you might have other similar folder named `utilities` and such. The important rule about these shared packages is that they shouldn't import anything from the `shopping` package or any sub-packages. In a few sections, we'll look at interfaces which can help us untangle these types of dependencies.

### Visibility

Go uses a simple rule to define what types and functions are visible outside of a package. If the name of the type or function starts with an uppercase letter, it's visible. If it starts with a lowercase letter, it isn't.

This also applies to structure fields. If a structure field name starts with a lowercase letter, only code within the same package will be able to access them.

For example, if our `items.go` file had a function that looked like:

```go
func NewItem() *Item {
  // ...
}
```

it could be called via `models.NewItem()`. But if the function was named `newItem`, we wouldn't be able to access it from a different package.

Go ahead and change the name of the various functions, types and fields from the `shopping` code. For example, if you rename the `Item's` `Price` field to `price`, you should get an error.

### Package Management

The `go` command we've been using to `run` and `build` has a `get` subcommand which is used to fetch third-party libraries. `go get` supports various protocols but for this example, we'll be getting a library from Github, meaning, you'll need `git` installed on your computer.

Assuming you already have git installed, from a shell/command prompt, enter:

```
go get github.com/mattn/go-sqlite3
```

`go get` fetches the remote files and stores them in your workspace. Go ahead and check your `$GOPATH/src`. In addition to the `shopping` project that we created, you'll now see a `github.com` folder. Within, you'll see a `mattn` folder which contains a `go-sqlite3` folder.

We just talked about how to import packages that live in our workspace. To use our newly gotten `go-sqlite3` package, we'd import it like so:

```go
import (
  "github.com/mattn/go-sqlite3"
)
```

I know this looks like a URL but in reality, it'll simply import the `go-sqlite3` package which it expects to find in `$GOPATH/src/github.com/mattn/go-sqlite3`.

### Dependency Management

`go get` has a couple of other tricks up its sleeve. If we `go get` within a project, it'll scan all the files, looking for `imports` to third-party libraries and will download them. In a way, our own source code becomes a `Gemfile` or `package.json`.

If you call `go get -u` it'll update the packages (or you can update a specific package via `go get -u FULL_PACKAGE_NAME`).

Eventually, you might find `go get` inadequate. For one thing, there's no way to specify a revision, it always points to the master/head/trunk/default. This is an even larger problem if you have two projects needing different versions of the same library.

To solve this, you can use a third-party dependency management tool. They are still young, but two promising ones are [goop](https://github.com/nitrous-io/goop) and [godep](https://github.com/tools/godep). A more complete list is available at the [go-wiki](https://code.google.com/p/go-wiki/wiki/PackageManagementTools).

## Interfaces

Interfaces are types that define a contract but not an implementation. Here's an example:

```go
type Logger interface {
  Log(message string)
}
```

You might be wondering what purpose this could possibly serve. Interfaces help decouple your code from specific implementations. For example, we might have various types of loggers:

```go
type SqlLogger struct { ... }
type ConsoleLogger struct { ... }
type FileLogger struct { ... }
```

Yet by programming against the interface, rather than these concrete implementations, we can easily change (and test) which we use without any impact to our code.

How would you use one? Just like any other type, it could be a structure's field:

```go
type Server struct {
  logger Logger
}
```

or a function parameter (or return value):

```go
func process(logger Logger) {
  logger.Log("hello!")
}
```

In a language like C# or Java, we have to be explicit when a class implements an interface:

```go
public class ConsoleLogger : Logger {
  public void Logger(message string) {
    Console.WriteLine(message)
  }
}
```

In Go, this happens implicitly. If your structure has a function name `Log` with a `string` parameter and no return value, then it can be used as a `Logger`. This cuts down on the verboseness of using interfaces:

```go
type ConsoleLogger struct {}
func (l ConsoleLogger) Log(message string) {
  fmt.Println(message)
}
```

It also tends to promote small and focused interfaces. The standard library is full of interfaces. The `io` package has a handful of popular ones such as `io.Reader`, `io.Writer`, and `io.Closer`. If you write a function that expects a parameter that you'll only be calling `Close()` on, you absolutely should accept an `io.Closer` rather than whatever concrete type you're using.

Interfaces can also participate in composition. And, interfaces themselves can be composed of other interfaces. For example, `io.ReadCloser` is an interface composed of the `io.Reader` interface as well as the `io.Closer` interface.

Finally, interfaces are commonly used to avoid cyclical imports. Since they don't have implementations, they'll have limited dependencies.

## Before You Continue

Ultimately, how you structure your code around Go's workspace is something that you'll only feel comfortable with after you've written a couple of non-trivial projects. What's most important for you to remember is the tight relationship between package names and your directory structure (not just within a project, but within the entire workspace).

The way Go handles visibility of types is straightforward and effective. It's also consistent. There are a few things we haven't looked at, such as constants and global variables but rest assured, their visibility is determined by the same naming rule.

Finally, if you're new to interfaces, it might take some time before you get a feel for them. However, the first time you see a function that expects something like `io.Reader`, you'll find yourself thanking the author for not demanding more than he or she needed.