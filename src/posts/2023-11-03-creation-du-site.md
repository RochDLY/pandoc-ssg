---
title: Construire un générateur de carnet
date: "2023-11-03"
---

## Préambule

Cela fait plusieurs mois que j'ai commencé à tenir un carnet lié à ma recherche et aux modes d'écriture en environnement numérique.
Malheureusement, mon premier [carnet](https://cailloux.en-cours-de-construction) n'a pas vu beaucoup de billets paraître sur sa page.

Le carnet me sert surtout à écrire en local et à tester des éditeurs de texte.
À ce jour, j'ai pu tester [VSCodium](https://vscodium.com/), [vim](https://www.vim.org/), [Emacs](https://www.gnu.org/software/emacs/), [Ghostwriter](https://ghostwriter.kde.org/fr/) et [Neovim](https://neovim.io/) avec sa surcouche [LazyVim](https://www.lazyvim.org/).
Tous ont des qualités et des défauts.
N'ayant trouvé de chaussure à mon pied, je les ai tous gardés installés et je passe de l'un à l'autre en fonction de mes humeurs.

Malgré le fait que j'ai gardé des publications en mode `draft` dans mon premier carnet, je n'ai jamais été très à l'aise pour y écrire.
Ce premier carnet est fabriqué avec [Quarto](https://quarto.org/), un système _open source_ de publication scientifique et technique conçu comme une surcouche de [Pandoc](https://pandoc.org/). Pandoc est un couteau-suisse très puissant qui peut convertir ou transformer des formats de balisages entre eux (ainsi que vers du `PDF` en utilisant certains compilateurs comme `LaTeX`, `Typst`).

Quarto est une solution très pratique et clef en main : elle permet de mettre en place rapidement des environnements fonctionnels pour publier ou produire des documents comme le ferait Pandoc, par exemple des présentations sous forme de _slides_ avec [reavealjs](https://revealjs.com/).
C'est un outil vraiment génial pour qui débute avec la manipulation de fichiers en texte brut, des lignes de commandes, ou encore git.
Chaque document, dont l'extension est un `.qmd`, une saveur particulière de Markdown propre à Quarto, est scindé en deux parties : une en-tête contenant des données sérialisées en YAML et le contenu textuel.
Ce qui est intéressant, c'est que les clefs des données YAML sont en fait les paramètres qui seront donnés à la commande pandoc qui va produire les _outputs_.
C'est une dimension très pratique en ce qui concerne l'apprentissage : au lieu d'avoir une courbe d'apprentissage très raide avec des outils comme le terminal et Pandoc, on peut utiliser Quarto comme intermédiaire pour se familiariser avec tout cet environnement.

Pourtant, je n'y étais pas tout à fait à mon aise.
Tout d'abord j'avais du mal à voir exactement les différentes actions réalisées par Quarto lors de chacune des transformations, ce qui est souvent le problème quand on utilise des surcouches.
Ensuite, je n'arrivais pas à épurer complètement le carnet (que je voulais minimaliste).
La plupart des thèmes proposés dans Quarto sont alimentés par [Bootstrap](https://getbootstrap.com/), un _framework_ CSS très en vogue pour construire des interfaces _responsives_.
Enfin il y avait cette envie de tout faire _from scratch_ : c'est mon carnet dans lequel je vais (dois) écrire régulièrement alors autant que je le fasse moi-même selon mes moyens.

Depuis le début de l'année 2023 j'essaye d'utiliser des environnements numériques les plus minimalistes possibles.
J'ai troqué mon Ubuntu pour [Devuan](https://www.devuan.org/) avec le gestionnaire de fenêtres [Awesome](https://awesomewm.org/) afin d'épurer au maximum les surcouches graphiques.
Pourquoi faire cela ? On me rétorque que je suis un _nerd_, un _geek_, que je suis perché dans ma bulle et que mon usage de l'informatique est marginal.
De plus, je ne suis pas un _hacker_, ni un développeur d'ailleurs, j'essaye de bricoler dans mon coin avec ce que je comprends de tout ce dispositif.
Pourquoi m'infliger de travailler dans un environnement aussi rustique, dont l'esthétique (à laquelle je me suis habitué et dont je ne peux plus me passer) en fait fuir plus d'un ?

La recherche que je mène porte sur l'influence des écritures numériques (et donc des environnements dans lesquelles elles se situent) sur les productions savantes (je détaillerai cette recherche dans un autre billet).
Il y est question de (archi)textes, de formats, de transformations et conversions, de publications, de protocoles, d'archives et de mémoires.
Quel est le dénominateur commun de tous ces éléments ?
Le texte.
C'est à lui que je suis confronté tout au long de cette recherche.
La réponse au pourquoi précédent devient évidente : étant donné que le texte est l'élément pivot autour duquel je gravite, il me semble nécessaire de le dénuder et lui retirer tout appareil (graphique) superflu pour le rendre le plus brut possible et le voir tel qu'il est à un niveau plus proche de la machine.

Revenons au _from scratch_.
Mon idée est de me dire qu'au lieu de déléguer le soin d'écrire ce que j'ai envie d'écrire à d'autres entités, je peux essayer de produire une écriture (pas toutes), qui produira à son tour mon écriture.

Les choix sont multiples et vastes, mais je n'ai pas non plus un temps indéfini pour choisir et développer mon carnet.
Grâce à des échanges avec [Arthur Perret](https://www.arthurperret.fr/)[^1], [Antoine Fauchié](https://www.quaternum.net/) et [Louis-Olivier Brassard](https://www.lobrassard.net/), je décide de faire un générateur de carnet statique sur mesure avec les outils [Make](https://www.gnu.org/software/make/) et Pandoc.

Bien évidemment, tout n'est pas construit complètement de zéro : Make s'occupe de recompiler avec Pandoc les différentes sources pour produire les fichiers `.html` de mon carnet web.
Ce qui veut dire que je n'ai pas de regard sur le code (texte) qui produit les transformations et les conversions de mes sources (ceci fera, je l'espère, l'objet d'un billet).
Ces outils étant _open source_, je suis _a minima_ en capacité d'aller les lire, chose que je laisse de côté pour plus tard.

## Le montage du générateur

La base du générateur est donc construite à partir des piles logicielles Pandoc et Make.
Lorsque j'appelle `make` dans mon terminal, je peux lui demander d'exécuter un certains nombres de commandes telles que `make html` ou `make clean` derrière lesquelles se trouvent des recettes et sous-recettes dont l'objectif est de produire et d'organiser le carnet web tel qu'il est ensuite déployé sur son hébergement.

### Make c'est trop cool

La beauté de Make réside dans la possibilité de ne reconstruire que les fichiers qui ont été modifiés et non pas l'intégralité des pages site web !
La plupart des générateurs de sites statiques mettent en avant dans leur communication marketing la capacité du générateur à produire le site web toujours plus vite que leurs concurrents.
Ce système reproduit toutes les pages du site lors de chaque reconstruction du site.
La conséquence directe de ce fonctionnement se matérialise lorsque le site web contient beaucoup de pages ou de billets : construire le site prend de plus en plus de temps.

Plutôt que de reproduire l'intégralité de mon carnet à chaque nouvelle modification, Make me permet de reconstruire uniquement les fichiers qui ont été modifiés.
Étant donné que l'ajout des billets se fait au compte goutte, et que je ne reviendrai que très peu sur les anciens billets postés, la reconstruction du site web ne prendra jamais plus de quelques secondes, si ce n'est pas moins.

Les différentes commandes peuvent être retrouvées dans le fichier `Makefile`.
Dans la commande Pandoc utilisée pour transformer les sources Markdown vers HTML, le nom du fichier à transformer est remplacer par la variable automatique `$<` de Make.
Cette variable sert à appeler la première cible de la recette Make, qui dans le cas de ce carnet, prend par exemple la forme suivante : `src/posts/%.md`.
Cette cible est particulière : il ne s'agit pas de lui donner un fichier spécifique mais de lui donner tous les documents (symbolisé par la _wildcard_ `%`) avec pour extension `.md`.
Ensuite, Make compare la date de dernière modification de la source, qu'il compare avec celle du fichier produit et si la date de dernière modification de la source est plus récente que celle du fichier `.html` alors il reconstruit l'_output_[^2].

### Architecture des documents

Afin de pouvoir appliquer ce fonctionnement à un site web, il convient de définir une architecture du projet et de la respecter rigoureusement.
Voici celle mise en place pour ce carnet :

```bash
pandoc-ssg/
├── docs
│   ├── css
│   │   └── styles.css
│   ├── pages
│   │   ├── colophon.html
│   │   ├── cours.html
│   │   ├── glossaire.html
│   │   └── publications.html
│   ├── posts
│   │   ├── 2023-11-03-creation-du-site.html
│   │   └── etc.
│   └── index.html
├── src
│   ├── bibliography
│   │   └── references.bib
│   ├── pages
│   │   ├── colophon.md
│   │   ├── cours.md
│   │   ├── glossaire.md
│   │   └── publications.md
│   ├── posts
│   │   ├── 2023-11-03-creation-du-site.md
│   │   └── etc.
├── static
│   ├── css
│   │   └── styles.css
├── templates
│   ├── csl
│   │   └── apa.csl
│   ├── partials
│   │   ├── footer.html
│   │   ├── head.html
│   │   ├── header.html
│   │   └── nav.html
│   ├── index.html
│   └── post.html
├── Makefile
├── metadata.yaml
└── README.md
```
### Les commandes

La production du site est réalisée vie une série de commandes Make et Pandoc.

```
make clean
```
Supprime tous les fichiers dans le dossier `docs/`.

```
make html
```
Cette commande permet de produire les fichiers `HTML` du site dans le dossier `docs/` à partir des sources contenues dans le dossier `src/`

```
make serve
```
`make serve` permet de jouer le site en local (_localhost_).

```
make all
```
Cette dernière commande réalise trois actions dans l'ordre suivant : `make clean`, puis `make html` et enfin `make serve`.
Il n'y a pas de système de reconstruction automatique du site intégré dans ce Makefile.
Chaque modification nécessite de recompiler manuellement les documents : toutes les actions n'ont pas à être automatisées, la production et la publication d'un texte ou d'un document sont, d'un point de vue personnel, des actions à réaliser soi-même.

Toutefois, cette commande `make all` ne respecte pas complètement le fonctionnement de Make décrit précédemment car en supprimant la totalité du site à chaque fois que cette commande est lancée, Make reconstruit en conséquence toutes les pages du site.
Il y a moins d'intérêt à l'utiliser couramment, alors que la commande `make html` ne produit que les fichiers sources modifiés et ne touche pas à ceux du dossier `docs/`.

[^1]: Voir aussi le billet d'Arthur Perret : https://www.arthurperret.fr/blog/2022-06-22-publication-multiformats-pandoc-make.html.  
[^2]: Pour plus de renseignements sur le fonctionnement de Make, voir ce [tutoriel](https://makefiletutorial.com/), déjà cité par Arthur Perret dans son blog. Ce tutoriel est une vraie mine d'or pour apprendre à faire un Makefile.
