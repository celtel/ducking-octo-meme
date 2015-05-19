OUT = cpc
IN = bib
all: $(OUT).pdf

$(OUT).pdf: $(OUT).tex
	pdflatex $(OUT)
	bibtex $(OUT)
	pdflatex $(OUT)
	pdflatex $(OUT)
	
clean:
	rm -f *~ $(OUT).aux $(OUT).pdf $(OUT).brf $(OUT).bbl $(OUT).blg $(OUT).log $(OUT).out
