#include <stdio.h>
/* translate a game that
 *     - is in .txt format
 *     - is a .six game with a swap
 * into its correct mirrored .txt format 
 *     by mirroring moves 3 onward ...   */

main() {
  char ch,outCh; 
  int outNum,moveNum,x,y,swapMade;

  swapMade = 0;
  moveNum = 0;
  for (;;) {
    ch=getchar();
    while ((ch!=EOF)&&(ch!='.')) ch=getchar();
    if (ch == EOF) break;

    /* ch now '.' */
    moveNum++;
    ch=getchar();
    if (ch == 'S') {
      ch=getchar(); /* read W */
      ch=getchar(); /* read A */
      ch=getchar(); /* read P */
      printf("%d.SWAP ",moveNum); 
      swapMade = 1;
    }
    else /*((ch >='a')&&(ch<='k'))*/ {
      x = ch-'a';
      ch=getchar();
      y = ch-'0';
      ch=getchar();
      if ((ch>='0')&&(ch<='9')) {
	y = 10*y+ ch-'0';
	ch=getchar();
      }
      if (swapMade) {
        /* mirror the move */
        outCh = 'a'+y-1;
	outNum = 1+x;
      }
      else {
        outCh = 'a'+x;
	outNum = y;
      }
     printf("%d.",moveNum);
     putchar(outCh);
     printf("%d  ",outNum);
    }
  }
  printf("\n");
}
