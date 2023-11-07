# Pandoc-SSP https://github.com/infologie/pandoc-ssp/
# by Arthur Perret https://www.arthurperret.fr
# custom by Roch Delannay https://github.com/RochDLY/pandoc-ssg

########################VARIABLES##############################

POSTS := $(sort $(shell find src/posts -type f -iname '*.md'))
POSTS_DOCS := $(patsubst %.md, docs/posts/%.html, $(notdir $(POSTS)))

PAGES := $(sort $(shell find src/pages -type f -iname '*.md'))
PAGES_DOCS := $(patsubst %.md, docs/pages/%.html, $(notdir $(PAGES)))

# Copy static files recursively :
# (Adapted from https://stackoverflow.com/questions/41993726/)
STATIC := $(shell find static -type f)
STATIC_DOCS := $(patsubst static/%, docs/%, $(STATIC))
$(foreach s,$(STATIC),$(foreach t,$(filter %$(notdir $s),$(STATIC_DOCS)),$(eval $t: $s)))
$(STATIC_DOCS):; $(if $(wildcard $(@D)),,mkdir -p $(@D) &&) cp $^ $@

references = src/bibliography/references.bib
csl_file = templates/csl/apa.csl
metadata_site = src/metadata.yml

PANDOCFLAGS = \
	--from markdown \
	--to html \
	--standalone \
	--citeproc \
	--wrap none \
	--bibliography $(references) \
	--metadata-file $(metadata_site) \
	--csl $(csl_file)


#############################COMMANDS###########################


.PHONY: all html clean #pdf

all: clean html serve #pdf

clean:
	@ rm -rf docs/*

serve:
	@ python3 -m http.server -d docs/

# Pandoc conversions
# HTML
html: $(STATIC_DOCS) docs/index.html $(POSTS_DOCS) $(PAGES_DOCS)

docs/index.html: src/index.md
	@ echo "Index production."
	@ pandoc \
  	$< \
		$(PANDOCFLAGS) \
		--template templates/index.html \
		--output $@
	@ echo "The index is built."

docs/pages/%.html: src/pages/%.md
	@ mkdir -p "$(@D)"
	@ echo "Pages production."
	@ pandoc \
  	$< \
		$(PANDOCFLAGS) \
		--template templates/post.html \
		--output $@
	@ echo "Pages are built."

docs/posts/%.html: src/posts/%.md
	@ mkdir -p "$(@D)"
	@ echo "Production of posts."
	@ pandoc \
  	$< \
		$(PANDOCFLAGS) \
		--template templates/post.html \
		--table-of-content \
		--output $@
	@ echo "Posts are built."

# PDF
#pdf: docs/these.pdf

#docs/these.pdf: src/introduction.md $(POSTS) src/conclusion.md
#	pandoc $^ [options] -o docs/these.pdf