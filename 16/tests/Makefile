LATEX = latex
DVIPS = dvips -t letter
PAPERNAME = info

pdf: full good
	ps2pdf $(PAPERNAME).ps

full: figs 
	$(LATEX) $(PAPERNAME)
	#bibtex $(PAPERNAME)
	#$(LATEX) $(PAPERNAME)
	#$(LATEX) $(PAPERNAME)
	#$(LATEX) $(PAPERNAME)

good: $(PAPERNAME).dvi
	$(DVIPS) -D 600 $(PAPERNAME) -o

cleanup:
	-@rm *.dvi *.blg *.bbl *.aux *.log

clean: cleanup
	-@rm *.ps *.pdf data/pix/*.eps

figs:
	(cd data/pix; perl make10.pl)
