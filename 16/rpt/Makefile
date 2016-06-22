LATEX = latex
DVIPS = dvips -t letter
PAPERNAME = rpt

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
	#-@rm *.eps
	#-@rm games/hexdiag/*.hexdiag

clean: cleanup
	-@rm *.ps *.pdf

figs:
	(cd games/hexdiag; perl make10.pl)
	mv games/hexdiag/*.eps .
