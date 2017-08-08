#for f in 11*.sgf; do ../sgf2p.py < $f | ../p2hd.11 > "${f%.sgf}.hexdiag" ; done 
for f in me*.sgf; do ../sgf2p.py < $f | ../p2hd.13 > "${f%.sgf}.hexdiag" ; done 
for f in em*.sgf; do ../sgf2p.py < $f | ../p2hd.13 > "${f%.sgf}.hexdiag" ; done 
