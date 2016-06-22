#lexical substitutions:
CC = gcc -Wall
CFILE = plain2plainhd

#target: dependencies (files or targets)
# <tab>  -actions  (continue upon execution failure)
# <tab>   actions  (halt upon execution failure)

$(CFILE): $(CFILE).c 
	-rm $(CFILE)
	$(CC) -o $(CFILE) $(CFILE).c

clean: 
	-rm $(CFILE)

