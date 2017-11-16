## A propos ##
[The Little Go Book](http://openmymind.net/The-Little-Go-Book/) est un livre gratuit d'introduction à Go.

Le livre a été écrit par [Karl Seguin](http://openmymind.net), l'auteur de:

* [Scaling Viki](http://openmymind.net/scaling-viki/)
* [The Little Redis Book](http://openmymind.net/2012/1/23/The-Little-Redis-Book/)
* [The Little MongoDB Book](http://openmymind.net/2011/3/28/The-Little-MongoDB-Book/)
* [Foundations of Programming](http://openmymind.net/FoundationsOfProgramming.pdf)

## Licence ##
Le livre est distribué gratuitement sous la licence  [Attribution-NonCommercial-ShareAlike 4.0 International](<http://creativecommons.org/licenses/by-nc-sa/4.0/>).

## Traductions ##

* [Spanish](https://github.com/raulexposito/the-little-go-book/tree/master/es) by Raúl Expósito
* [Chinese](https://github.com/songleo/the-little-go-book_ZH_CN) by Songleo
* [Traditional Chinese](https://github.com/kevingo/the-little-go-book) by KevinGo
* [Vietnamese](https://github.com/quangnh89/the-little-go-book/blob/master/vi/readme.md) by Quang Nguyễn
* [Italian](https://github.com/francescomalatesta/the-little-go-book-ita) by Francesco Malatesta
* [Français](https://github.com/pufplan/the-little-go-book-fr) par yeswearecoding

## Formats ##
Le livre est écrit en [Markdown](http://daringfireball.net/projects/markdown/) et converti en PDF en utilisant [Pandoc](http://johnmacfarlane.net/pandoc/).

Le modèle Tex se sert de [Lena Herrmann's JavaScript highlighter](http://lenaherrmann.net/2010/05/20/javascript-syntax-highlighting-in-the-latex-listings-package).

Les formats Kindle et ePub sont produit par [Pandoc](http://johnmacfarlane.net/pandoc/).

## Génération des différents formats du livre ##
Les paquets ci-dessous sont pour Ubuntu ; ils devraient être similaires pour les autres distribution.

### PDF

#### Dépendances

Paquets:

* `pandoc`
* `texlive-xetex`
* `texlive-latex-extra`
* `texlive-latex-recommended`

Vous devez également installer ces [polices d'écriture](https://github.com/karlseguin/the-little-redis-book/blob/master/common/pdf-template.tex#L11).

Ou vous pouvez en utiliser d'autres si vous le souhaitez. Attention toutefois, certaines peuvent causer des [problèmes de compilation](https://github.com/karlseguin/the-little-redis-book/issues/26).

#### Compilation

Exécutez `make fr/go.pdf`.

### ePub

#### Dépendances

Paquets:

* `pandoc`

#### Compilation

Exécutez `make fr/go.epub`.

### Mobi

#### Dépendances

Paquets:

* `pandoc`

Vous devez également installer [KindleGen](http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211).

#### Compilation

Exécutez `make fr/go.mobi`.

## Image du titre ##
Un PSD de l'image du titre est inclus. La police utilisée est [Comfortaa](http://www.dafont.com/comfortaa.font).
