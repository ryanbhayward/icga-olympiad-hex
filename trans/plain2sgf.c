#include <stdio.h>

/*
  translate a Hex game record from plain format
     * no move numbers, alphabetic lower case
     * swap symbol: S
     * game end symbol #
      a3 S
      c8 b9  ???
      e10 #
  into stripped .sgf format
*/

void translate() {
  unsigned char ch; int x,y,moveNum,swapMade;

  moveNum = 0;
  swapMade = 0;

  for (;;) {
    ch=getchar();
    if (ch == '#') break;
    if (ch == 'S') {
      printf(";W[SWAP]");
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
      switch ((moveNum+swapMade) % 2) {
        case 0: printf(";W["); putchar('a'+x-1); printf("%1d]",y); break;
        case 1: printf(";B["); putchar('a'+x-1); printf("%1d]",y); break;
      }
     if (9==moveNum%10) printf("\n");
    } 
  } 
}

main() {
  printf("(;AP[Hex-benzene:0.1]FF[4]GM[11]PB[Blue]PW[Red]SZ[11]\n");
  translate();
  printf(")\n");
  return 0;
}
