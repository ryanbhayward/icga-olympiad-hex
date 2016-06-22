#include <stdio.h>
/* translate from .six format to human readable format */

main() {
  char ch; int x,moveNum;
  moveNum = 0;
  ch=getchar();
  while (ch!='.') ch=getchar();
  for (;;) {
    ch=getchar();
    if (ch == EOF) break;
    if (ch == 'S') {
      ch=getchar();
      if (ch == 'W'||ch=='w') {
        ch=getchar();
        if (ch == 'A'||ch=='a') {
          ch=getchar();
          if (ch == 'P'||ch=='p') 
            printf(" %d.SWAP",++moveNum); } } }
    if ((ch >='A')&&(ch<='K')) {
      if (0<moveNum%20) printf(" ");
      printf("%2d.",++moveNum);
      putchar('a'+ch-'A');
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
  printf("\n");
}
