#include <stdio.h>

/*
  translate a Hex game record from plain format
     * no move numbers, alphabetic lower case
     * swap symbol: S
     * game end symbol #
      a3 S
      c8 b9  ???
      e10 #
  into the newformat hexdiag .ps format
      first player is black
      first player has upper-left border
      upper-left border labelled with alphabet
*/

void translate() {
  unsigned char ch; int x,y,moveNum,swapMade;

  moveNum = 0;
  swapMade = 0;

  for (;;) {
    ch=getchar();
    if (ch == '#') break;
    if (ch == 'S') {
      printf("%1d %1d (S) 1 HexBlackLabelledPiece\n",y,x);
      moveNum++;
      swapMade++;
    }
    if ((ch >= 'a') && (ch <= 'z')) {
      x = 1+ch-'a';
      ch=getchar();

      y = ch-'0';
      ch=getchar();
      if ((ch >= '0') && (ch <= '9')) {
        y = 10*y + ch-'0';
        ch=getchar();
      }

      moveNum++;
      printf("%1d %1d ",y,x);
      printf("(%1d) %1d ",
        moveNum,1+(9+moveNum/10)/10);
      switch ((moveNum+swapMade) % 2) {
        case 1: printf("HexBlackLabelledPiece \n"); break;
        case 0: printf("HexWhiteLabelledPiece \n"); break;
      }
    } 
  } 
}

main() {
  printf("/DimX 11 def\n");
  printf("/DimY 11 def\n");
  printf("/Scale 1.2 def\n");
  printf("FlatTopBoard\n");
  printf("DrawHexBoard\n");
  printf("1 HexBoardBorders\n");
  printf("AltHexBoardCoordinates\n\n");
  translate();
  return 0;
}
