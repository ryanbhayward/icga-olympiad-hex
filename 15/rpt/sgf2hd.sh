for f in ../games/11x11/*.sgf
do
  g=${f%.sgf}
  echo ${f%%.*} ${g##*/}
  ../../trans/sgf2txt < $f | ../../trans/txt2p | ../../trans/p2hd > "games/hexdiag/${g##*/}.hexdiag"
done
for f in ../games/13x13/*.sgf
do
  g=${f%.sgf}
  echo ${f%%.*} ${g##*/}
  ../../trans/sgf2txt < $f | ../../trans/txt2p | ../../trans/p2hd > "games/hexdiag/${g##*/}.hexdiag"
done
for f in ../games/11x11/human/*.sgf
do
  g=${f%.sgf}
  echo ${f%%.*} ${g##*/}
  ../../trans/sgf2txt < $f | ../../trans/txt2p | ../../trans/p2hd > "games/hexdiag/${g##*/}.hexdiag"
done
