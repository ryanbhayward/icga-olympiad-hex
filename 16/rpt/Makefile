LATEX = latex
DVIPS = dvips -t letter
PPR = rpt

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
	#-@rm *.eps
	#-@rm games/hexdiag/*.hexdiag

clean: cleanup
	-@rm $(PPR).ps $(PPR).pdf

figs:
	(cd games/hexdiag; perl make10.pl)
	mv games/hexdiag/*.eps .
