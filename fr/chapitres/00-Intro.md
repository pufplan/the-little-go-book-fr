# A propos de ce livre

## Licence

Le "Little Go Book" utilise la licence Attribution-NonCommercial-ShareAlike 4.0 International. Vous ne devriez pas payer pour ce livre.

Vous êtes libre de copier, distribuer, modifier ou afficher le livre. Néanmoins, je vous demande de toujours m'attribuer, à moi Karl Seguin, le livre et de ne pas l'utiliser à des fins commerciales.

Vous pouvez consulter l'intégralité du texte de la licence sur :

<https://creativecommons.org/licenses/by-nc-sa/4.0/> ou  
<https://creativecommons.org/licenses/by-nc-sa/3.0/fr/>

## Dernière version

Les dernières sources de ce livre sont disponibles à :
<https://github.com/karlseguin/the-little-go-book>

# Introduction

I've always had a love-hate relationship when it comes to learning new languages. On the one hand, languages are so fundamental to what we do, that even small changes can have measurable impact. That *aha* moment when something clicks can have a lasting effect on how you program and can redefine your expectations of other languages. On the downside, language design is fairly incremental. Learning new keywords, type system, coding style as well as new libraries, communities and paradigms is a lot of work that seems hard to justify. Compared to everything else we have to learn, new languages often feel like a poor investment of our time.

That said, we *have* to move forward. We *have* to be willing to take incremental steps because, again, languages are the foundation of what we do. Though the changes are often incremental, they tend to have a wide scope and they impact productivity, readability, performance, testability, dependency management, error handling, documentation, profiling, communities, standard libraries, and so on. Is there a positive way to say *death by a thousand cuts*?

That leaves us with an important question: **why Go?** For me, there are two compelling reasons. The first is that it's a relatively simple language with a relatively simple standard library. In a lot of ways, the incremental nature of Go is to simplify some of the complexity we've seen being added to languages over the last couple of decades. The other reason is that for many developers, it will complement your existing arsenal.

Go was built as a system language (e.g., operating systems, device drivers) and thus aimed at C and C++ developers. According to the Go team, and which is certainly true of me, application developers, not system developers, have become the primary Go users. Why? I can't speak authoritatively for system developers, but for those of us building websites, services, desktop applications and the like, it partially comes down to the emerging need for a class of systems that sit somewhere in between low-level system applications and higher-level applications.

Maybe it's a messaging, caching, computational-heavy data analysis, command line interface, logging or monitoring. I don't know what label to give it, but over the course of my career, as systems continue to grow in complexity and as concurrency frequently measures in the tens of thousands, there's clearly been a growing need for custom infrastructure-type systems. You *can* build such systems with Ruby or Python or something else (and many people do), but these types of systems can benefit from a more rigid type system and greater performance. Similarly, you *can* use Go to build websites (and many people do), but I still prefer, by a wide margin, the expressiveness of Node or Ruby for such systems.

There are other areas where Go excels. For example, there are no dependencies when running a compiled Go program. You don't have to worry if your users have Ruby or the JVM installed, and if so, what version. For this reason, Go is becoming increasingly popular as a language for command-line interface programs and other types of utility programs you need to distribute (e.g., a log collector).

Put plainly, learning Go is an efficient use of your time. You won't have to spend long hours learning or even mastering Go, and you'll end up with something practical from your effort.

## A Note from the Author

I've hesitated writing this book for a couple reasons. The first is that Go's own documentation, in particular [Effective Go](https://golang.org/doc/effective_go.html), is solid.

The other is my discomfort at writing a book about a language. When I wrote The Little MongoDB Book, it was safe to assume most readers understood the basics of relational database and modeling. With The Little Redis Book, you could assume a familiarity with a key value store and take it from there.

As I think about the paragraphs and chapters that lay ahead, I know that I won't be able to make those same assumptions. How much time do you spend talking about interfaces knowing that for some, the concept will be new, while others won't need much more than *Go has interfaces*? Ultimately, I take comfort in knowing that you'll let me know if some parts are too shallow or others too detailed. Consider that the price of this book.

# Getting Started

If you're looking to play a little with Go, you should check out the [Go Playground](https://play.golang.org/) which lets you run code online without having to install anything. This is also the most common way to share Go code when seeking help in [Go's discussion forum](https://groups.google.com/forum/#!forum/golang-nuts) and places like StackOverflow.

Installing Go is straightforward. You can install it from source, but I suggest you use one of the pre-compiled binaries. When you [go to the download page](https://golang.org/dl/), you'll see installers for various platforms. Let's avoid these and learn how to set up Go ourselves. As you'll see, it isn't hard.

Except for simple examples, Go is designed to work when your code is inside a workspace. The workspace is a folder composed of `bin`, `pkg` and `src` subfolders. You might be tempted to force Go to follow your own style - don't.

Normally, I put my projects inside of `~/code`. For example, `~/code/blog` contains my blog. For Go, my workspace is `~/code/go` and my Go-powered blog would be in `~/code/go/src/blog`.

In short, create a `go` folder with a `src` subfolder wherever you expect to put your projects.

## OSX / Linux
Download the `tar.gz` for your platform. For OSX, you'll most likely be interested in `go#.#.#.darwin-amd64-osx10.8.tar.gz`, where `#.#.#` is the latest version of Go.

Extract the file to `/usr/local` via `tar -C /usr/local -xzf go#.#.#.darwin-amd64-osx10.8.tar.gz`.

Set up two environment variables:

  1. `GOPATH` points to your workspace, for me, that's `$HOME/code/go`.
  2. We need to append Go's binary to our `PATH`.

You can set these up from a shell:

    echo 'export GOPATH=$HOME/code/go' >> $HOME/.profile
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile

You'll want to activate these variables. You can close and reopen your shell, or you can run `source $HOME/.profile`.

Type `go version` and you'll hopefully get an output that looks like `go version go1.3.3 darwin/amd64`.

## Windows
Download the latest zip file. If you're on an x64 system, you'll want `go#.#.#.windows-amd64.zip`, where `#.#.#` is the latest version of Go.

Unzip it at a location of your choosing. `c:\Go` is a good choice.

Set up two environment variables:

  1. `GOPATH` points to your workspace. That might be something like `c:\users\goku\work\go`.
  2. Add `c:\Go\bin` to your `PATH` environment variable.

Environment variables can be set through the `Environment Variables` button on the `Advanced` tab of the `System` control panel. Some versions of Windows provide this control panel through the `Advanced System Settings` option inside the `System` control panel.

Open a command prompt and type `go version`. You'll hopefully get an output that looks like `go version go1.3.3 windows/amd64`.
