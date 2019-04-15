NOTEBOOK := $(wildcard notebook/*.ipynb)
EXCLUDE_INPUT := True
.PHONY: build lint pdf html index pdf2

build: pdf html index

pdf: $(NOTEBOOK)
	ipython nbconvert --to latex notebook/*.ipynb --template jsarticle.tplx
	extractbb image/*.png 
	platex -output-directory notebook notebook/*.tex
	cd notebook; dvipdfmx *.dvi
	mkdir -p public/pdf
	mv notebook/*.pdf public/pdf
	
html: $(NOTEBOOK)
	ipython nbconvert --to html notebook/*.ipynb
	mkdir -p public/html
	mv notebook/*.html public/html
	mkdir -p public/image
	cp image/*.png public/image

index: $(NOTEBOOK)
	python3 index_generator.py

textlint: $(NOTEBOOK)
	ipython nbconvert --to markdown notebook/*.ipynb
	textlint -f pretty-error notebook/*.md

pdf2: $(NOTEBOOK)
	mkdir -p public/pdf
	$(eval tmpdir := $(shell mktemp -d))
	# ln -s /notebook/*.ipynb $(tmpdir)/
	ls /book/notebook/*.ipynb | xargs ln -s -t $(tmpdir)
	ln -s /book/notebook/image $(tmpdir)/image
	cd $(tmpdir); \
	ls *.ipynb | xargs ipython nbconvert --to pdf --template jsarticle.tplx --TemplateExporter.exclude_input=$(EXCLUDE_INPUT);\
	mv *.pdf /book/public/pdf
