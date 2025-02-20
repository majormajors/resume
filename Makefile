# Makefile
#
# Borrowed and modified from https://gist.github.com/kristopherjohnson/7466917 
# 
# Converts Markdown to other formats (HTML, PDF, DOCX, TeX) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files

# Convert all files in this directory that have a .md suffix
SOURCE_DOCS := $(wildcard *.md)

EXPORTED_DOCS=\
 $(SOURCE_DOCS:.md=.html) \
 $(SOURCE_DOCS:.md=.pdf) \
 $(SOURCE_DOCS:.md=.docx) \
 $(SOURCE_DOCS:.md=.tex) \

RM := $(shell which rm)
RM_OPTIONS=-f

PANDOC := $(shell which pandoc)
PANDOC_OPTIONS=--standalone --from markdown+smart

PANDOC_HTML_OPTIONS=--to html --css resume.css
PANDOC_PDF_OPTIONS=
PANDOC_DOCX_OPTIONS=
PANDOC_TEX_OPTIONS=

# Pattern-matching Rules

%.html : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

%.pdf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<
	
%.docx : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<

%.tex : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_TEX_OPTIONS) -o $@ $<

# Targets and dependencies

.PHONY: all clean

all : $(EXPORTED_DOCS)

clean:
	- $(RM) $(RM_OPTIONS) $(EXPORTED_DOCS)
