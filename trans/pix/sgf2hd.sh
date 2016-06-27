for f in *.sgf; do ../sgf2p.py < $f | ../p2hd > "${f%.sgf}.hexdiag" ; done 
