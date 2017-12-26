NOTEBOOK := $(wildcard notebook/*.ipynb)
.PHONY: build lint pdf html index

build: pdf html index

pdf: $(NOTEBOOK)
	ipython nbconvert --to latex notebook/*.ipynb --template jsarticle.tplx
	extractbb images/*.png 
	platex -output-directory notebook notebook/*.tex
	cd notebook; dvipdfmx *.dvi
	mkdir -p public/pdf
	mv notebook/*.pdf public/pdf
	
html: $(NOTEBOOK)
	ipython nbconvert --to html notebook/*.ipynb
	mkdir -p public/html
	mv notebook/*.html public/html
	mkdir -p public/images
	cp images/*.png public/images

index: $(NOTEBOOK)
	python3 index_generator.py

textlint: $(NOTEBOOK)
	ipython nbconvert --to markdown notebook/*.ipynb
	textlint -f pretty-error notebook/*.md
