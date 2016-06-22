#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

/* translate a Hex game record from .hexdiag format   */
/*  to .shf simple hex format                         */

#define black_stone "*"
#define white_stone "o"
#define marked_black_stone "X"
#define marked_white_stone "O"
#define empty_cell  "-"
#define shaded_cell "."

#define FALSE 0
#define TRUE 1
#define MAX_strLen    40
#define MAX_strLenP1  41
#define MAX_strings 7
#define NUM_tokens 8
#define MAX_boardDim 14

typedef enum {EMPTY, BLACK, WHITE, 
   EMPTYMARKED, BLACKMARKED, WHITEMARKED} Cell;

char inputStrings [MAX_strings][MAX_strLenP1] ;
Cell board[MAX_boardDim][MAX_boardDim];
int boardLabels[MAX_boardDim][MAX_boardDim];

/*
void complain(char * s) {
   fprintf(stderr, "%s!\n", s);
}
*/

int numeric(char str[]) 
{
   int j, n = 0;

   for (j = 0; j < strlen(str); j++)
      n = 10*n + str[j]-'0';
   return n;
}

int read_token(char * ch, char str[]) 
{
   int j = 0;

   while (isspace(* ch)) 
   {
      * ch = getchar();
   }
   if (ispunct(* ch))
   {
      str[j++] = * ch;
      * ch = getchar();
   }
   else if (isalpha(* ch))
   {
      str[j++] = * ch;
      * ch = getchar();
      while (isalpha(* ch) || isdigit(* ch) || ('-' == * ch))
      {
         str[j++] = * ch;
         * ch = getchar();
      }
   }
   else if (isdigit(* ch))
   {
      str[j++] = * ch;
      * ch = getchar();
      while (isdigit(* ch))
      {
         str[j++] = * ch;
         * ch = getchar();
      }
   }
   else 
   {
      assert(EOF == * ch);
   }
   str[j] = '\0';
   return j;
}



/*
int showPieces = 0;
int showCoordinates = 0;
*/

void showBoardLabels(int dimX, int dimY)
{ 
   int x, y, label;

   printf("showBoardLabels dimX %d dimY %d \n",dimX,dimY);
   for (x = 0; x < dimX; x++) 
   {
      for (y = 0; y < x; y++)
         printf(" ");
      for (y = 0; y < dimY; y++)
      {
         label = boardLabels[x][y];
	 if (label < 0)
           printf(" - ");
         else
           printf("%2d ",boardLabels[x][y]);
      }
      printf("\n");
   }
}
    

void showBoard(int dimX, int dimY)
{ 
  int x, y;

  printf("showboard dimX %d dimY %d \n",dimX,dimY);
  for (x = 0; x < dimX; x++) 
  {
    for (y = 0; y < x; y++)
       printf(" ");
    for (y = 0; y < dimY; y++)
       switch(board[x][y])
       {
          case EMPTY:
             printf("- ");
	     break;
          case BLACK:
             printf("* ");
	     break;
          case WHITE:
             printf("o ");
	     break;
          case EMPTYMARKED:
             printf(". ");
	     break;
          case BLACKMARKED:
             printf("X ");
	     break;
          case WHITEMARKED:
             printf("O ");
	     break;
       }
   printf("\n");
   }
}

char ch, str[MAX_strLen];
int dimX, dimY, j, n, x, y, label, tokenLen;


void getNextToken()
{
      tokenLen = read_token(&ch,str);
}

void update(Cell c, int xIndex, int yIndex, int labelIndex)
{
   int x, y;
   x = numeric(inputStrings[ (xIndex) % MAX_strings]);
   y = numeric(inputStrings[ (yIndex) % MAX_strings]);
   board[x-1][y-1] = c;
   if (labelIndex >= 0)
   {
      label = numeric(inputStrings[(labelIndex - 3)% MAX_strings]);
      boardLabels[x-1][y-1] = label;
   }
}

main()
{
   ch = getchar();
   for (j=0;  ;j++) {
      getNextToken();
      if (0 == tokenLen)
         break;
      strcpy(inputStrings[j % MAX_strings],str);
      printf("%s\n",inputStrings[j % MAX_strings]);
      if (0 == strcmp(str,"DimX"))
      {
         getNextToken();
	 dimX = numeric(str);
      }
      else if (0 == strcmp(str,"DimY"))
      {
         getNextToken();
	 dimY = numeric(str);
	 for (x = 0; x < dimX; x++)
	    for (y = 0; y < dimY; y++) {
	       board[x][y] = EMPTY;
	       boardLabels[x][y] = -1;
            }
      }
      else if (0 == strcmp(str,"HexBlackLabelledPiece"))
         update(BLACK, j-6, j-5, j);
      else if (0 == strcmp(str,"HexWhiteLabelledPiece"))
         update(WHITE, j-6, j-5, j);
      else if (0 == strcmp(str,"HexBlackPiece"))
         update(BLACK, j-2, j-1, -1);
      else if (0 == strcmp(str,"HexWhitePiece"))
         update(WHITE, j-2, j-1, -1);
      else if (0 == strcmp(str,"HexBlackMarkedPiece"))
         update(BLACKMARKED, j-2, j-1, -1);
      else if (0 == strcmp(str,"HexWhiteMarkedPiece"))
         update(WHITEMARKED, j-2, j-1, -1);
      else if (0 == strcmp(str,"HexDeadCell"))
         update(EMPTYMARKED, j-2, j-1, -1);
   }
   showBoard(dimX,dimY);
   showBoardLabels(dimX,dimY);
}
