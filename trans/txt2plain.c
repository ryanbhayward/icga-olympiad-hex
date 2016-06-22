#include <stdio.h>
/* translate from .txt format to plain format*/

main() {
  char ch; 
  for (;;) {
    ch=getchar();
    while ((ch!='.')&&(ch!=EOF)) ch=getchar();
    if (ch == EOF) break;
    ch=getchar();
    //if (ch == 'S')  printf("S "); 
    if ((ch == 'S')||(ch =='s'))  printf("S "); 
    if ((ch >='a')&&(ch<='r')) {
      putchar(ch);
      ch=getchar();
      putchar(ch);
      ch=getchar();
      if ((ch>='0')&&(ch<='9')) putchar(ch);
      printf(" ");
    }
  }
  printf("#\n");
}
