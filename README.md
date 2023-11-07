# Carnet de doctorant - Roch delannay

Ce site a été construit avec [GNU Make 4.3](https://www.gnu.org/software/make/) et [Pandoc 3.1.1](https://pandoc.org/).

## Organisation des fichiers

```
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

## Production du site

Pour construire le site, utiliser les commandes suivantes :

```
make html
```
Cette commande permet de produire les fichiers `HTML` du site dans le dossier `docs/`.

```
make serve
```
`make serve` permet de jouer le site en local (_localhost_).

```
make clean
```
Cette dernière commande supprime tous les documents qui se trouvent dans le dossier `docs/`

## Remerciements

Merci à [Louis-Olivier Brassard](https://www.lobrassard.net/), pour toutes les explications sur le fonctionnement de Make et pour les bouts de code que je t'ai emprunté.
Merci également à [Arthur Perret](https://www.arthurperret.fr/) pour ton idée de combiner Make et Pandoc (d'ailleurs ce générateur de carnet est un _fork_ de ton projet).

## Licence

Sauf mention contraire, les contenus publiés sur ce site sont réutilisables suivant les termes de la licence Creative Commons Attribution 4.0 International (CC BY), cf. [résumé](https://creativecommons.org/licenses/by/4.0/deed.fr) et [texte intégral](https://creativecommons.org/licenses/by/4.0/legalcode.fr).