#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  typedef struct { unsigned char a; int b; unsigned short c; signed char d; } Rec;
  static const Rec R[15]={{111,835,20933,-1},{222,304,48841,-1},{52,331,29832,-5},{220,-26,47712,4},{222,676,49118,-3},{142,-817,51542,-4},{83,639,44715,2},{251,-757,8563,5},{121,-411,18400,2},{3,-259,40057,-3},{110,422,43683,-2},{199,457,48744,-2},{52,833,49989,0},{137,435,39061,1},{242,-760,22836,4}};
  static Rec M[15];
  printf("start o1_pad_14\n");
  long sb=0; unsigned long sa=0,sc=0; long sd=0;
  for(int j=0;j<15;j++){ M[j]=R[j]; sa+=M[j].a; sb+=M[j].b; sc+=M[j].c; sd+=M[j].d; }
  printf("a=%lu b=%ld c=%lu d=%ld\n",sa,sb,sc,sd);
  return 0;
}
