# Pandoc-SSP https://github.com/infologie/pandoc-ssp/
# by Arthur Perret https://www.arthurperret.fr
# custom by Roch Delannay https://github.com/RochDLY/pandoc-ssg

########################VARIABLES##############################

POSTS := $(sort $(shell find src/posts -type f -iname '*.md'))
POSTS_DIST := $(patsubst %.md, dist/posts/%.html, $(notdir $(POSTS)))

PAGES := $(sort $(shell find src/pages -type f -iname '*.md'))
PAGES_DIST := $(patsubst %.md, dist/pages/%.html, $(notdir $(PAGES)))

# Copy static files recursively :
# (Adapted from https://stackoverflow.com/questions/41993726/)
STATIC := $(shell find static -type f)
STATIC_DIST := $(patsubst static/%, dist/%, $(STATIC))
$(foreach s,$(STATIC),$(foreach t,$(filter %$(notdir $s),$(STATIC_DIST)),$(eval $t: $s)))
$(STATIC_DIST):; $(if $(wildcard $(@D)),,mkdir -p $(@D) &&) cp $^ $@

references = src/bibliography/references.bib
csl_files = templates/csl/apa.csl

PANDOCFLAGS = \
	--from markdown \
	--to html \
	--standalone \
	--citeproc \
	--wrap none \
	--bibliography $(references) \
#	--csl $(csl_file)


#############################COMMANDS###########################


.PHONY: all html clean #pdf

all: clean html serve #pdf

clean:
	@ rm -rf dist/*

serve:
	@ python3 -m http.server -d dist/

# Pandoc conversions
# HTML
html: $(STATIC_DIST) dist/index.html $(POSTS_DIST) $(PAGES_DIST)

dist/index.html: src/index.md
	@ echo "Index production."
	@ pandoc \
  	$< \
		$(PANDOCFLAGS) \
		--template templates/index.html \
		--output $@
	@ echo "The index is built."

dist/pages/%.html: src/pages/%.md
	@ mkdir -p "$(@D)"
	@ echo "Pages production."
	@ pandoc \
  	$< \
		$(PANDOCFLAGS) \
		--template templates/post.html \
		--output $@
	@ echo "Pages are built."

dist/posts/%.html: src/posts/%.md
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
#pdf: dist/these.pdf

#dist/these.pdf: src/introduction.md $(POSTS) src/conclusion.md
#	pandoc $^ [options] -o dist/these.pdf