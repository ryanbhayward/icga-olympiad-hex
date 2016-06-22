LATEX = latex
DVIPS = dvips -t letter
PPR = info

pdf: full good
	ps2pdf $(PPR).ps

full: figs 
	$(LATEX) $(PPR)
	#bibtex $(PPR)
	#$(LATEX) $(PPR)
	#$(LATEX) $(PPR)
	#$(LATEX) $(PPR)

good: $(PPR).dvi
	$(DVIPS) -D 600 $(PPR) -o

cleanup:
	-@rm $(PPR).dvi $(PPR).blg $(PPR).bbl $(PPR).aux $(PPR).log

clean: cleanup
	-@rm $(PPR).ps $(PPR).pdf data/pix/*.eps

figs:
	(cd data/pix; perl make10.pl)
