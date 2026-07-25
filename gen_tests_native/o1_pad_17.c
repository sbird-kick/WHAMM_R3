#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  typedef struct { unsigned char a; int b; unsigned short c; signed char d; } Rec;
  static const Rec R[24]={{223,-38,18130,-1},{118,700,13284,1},{72,571,33018,0},{114,908,284,4},{232,542,3284,-5},{209,-429,25799,-1},{175,947,43242,1},{90,-636,41843,-2},{38,24,14569,0},{238,9,3259,-5},{71,-42,27129,-2},{95,-773,51408,-1},{143,167,23967,5},{208,437,6140,-1},{224,277,53984,0},{189,325,26923,5},{158,424,23458,-2},{229,573,31530,0},{241,-23,43968,0},{7,882,11000,-4},{78,229,11622,-1},{51,700,8617,2},{101,832,44109,5},{221,-856,4681,-3}};
  static Rec M[24];
  printf("start o1_pad_17\n");
  long sb=0; unsigned long sa=0,sc=0; long sd=0;
  for(int j=0;j<24;j++){ M[j]=R[j]; sa+=M[j].a; sb+=M[j].b; sc+=M[j].c; sd+=M[j].d; }
  printf("a=%lu b=%ld c=%lu d=%ld\n",sa,sb,sc,sd);
  return 0;
}
