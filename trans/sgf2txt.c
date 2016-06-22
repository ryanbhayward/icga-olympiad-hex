#include <stdio.h>
/* translate from .sgf format to human readable format */

main() {
  char ch; int x,moveNum;
  moveNum = 0;
  for (;;) {
    ch=getchar();
    if (ch == EOF) break;
    if (ch=='[') {
      ch=getchar();
      if (ch == 'S') {
        ch=getchar();
        if (ch == 'W') {
          ch=getchar();
          if (ch == 'A') {
            ch=getchar();
            if (ch == 'P') printf(" %d.SWAP",++moveNum);
          }
        }
      }
      if ((ch >= 'a') && (ch <= 'z')) {
        if (0<moveNum%20) printf(" ");
        printf("%2d.",++moveNum);
        putchar(ch);
        ch=getchar();
        if ((ch >= '1') && (ch <= '9')) x = ch-'0';
        if ((ch == '1')) {
          ch=getchar();
          if ((ch >= '0') && (ch <= '9'))  {
            x = 10*x + ch-'0';
            ch=getchar(); 
          }
        }
        printf("%d",x);
        if (x<10) printf(" ");
        if (0==moveNum%20) printf("\n");
      }
    }
  }
  printf("\n");
}
