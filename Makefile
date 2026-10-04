.PHONY: build clean

build:
	latexmk -g -pdf -interaction=nonstopmode -halt-on-error hypergeometric.tex

clean:
	$(RM) $(filter-out hypergeometric.tex,$(wildcard hypergeometric*)) \
		$(filter-out %.tex,$(wildcard Chapters/* FrontBackmatter/*))
