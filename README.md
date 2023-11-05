# Carnet de doctorant - Roch delannay

Ce site a été construit avec [GNU Make](https://www.gnu.org/software/make/) et [Pandoc](https://pandoc.org/).

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

La production du site est réalisée vie une série de commandes Make.

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