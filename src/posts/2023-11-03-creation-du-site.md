---
title: Création du site
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


[^1]: Voir aussi le billet d'Arthur Perret : https://www.arthurperret.fr/blog/2022-06-22-publication-multiformats-pandoc-make.html