#include <stdio.h>
#define N 11
/* create sed file which effects board rotation
 *     by mirroring moves 3 onward ...   */

int main() {
  char ch; int j;

  for (ch='a'; ch<='k'; ch++) 
    for (j=1; j<=N; j++) 
      printf("1,$s/\\[%c%1d\\]/<^<^%c%1d\\]/g\n",ch,j,'a'+'k'-ch,1+N-j);
  printf("1,$s/<^<^/\\[/g\n");
  return 0;
}
