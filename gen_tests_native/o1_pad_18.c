#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  typedef struct { unsigned char a; int b; unsigned short c; signed char d; } Rec;
  static const Rec R[23]={{72,-314,53018,-4},{189,611,1521,1},{160,-229,35373,-3},{57,-86,8452,5},{93,80,40491,-1},{78,-749,48863,5},{215,705,36647,-3},{162,586,2122,4},{118,623,43523,0},{16,538,2925,-4},{15,-805,13781,0},{206,-80,23894,-1},{100,-632,5634,-4},{31,215,15216,-3},{5,788,18228,3},{217,383,27868,0},{142,505,8410,2},{193,774,10232,-1},{134,-622,50728,-4},{34,712,8365,2},{154,-281,33715,0},{233,-300,14778,3},{102,309,32538,-1}};
  static Rec M[23];
  printf("start o1_pad_18\n");
  long sb=0; unsigned long sa=0,sc=0; long sd=0;
  for(int j=0;j<23;j++){ M[j]=R[j]; sa+=M[j].a; sb+=M[j].b; sc+=M[j].c; sd+=M[j].d; }
  printf("a=%lu b=%ld c=%lu d=%ld\n",sa,sb,sc,sd);
  return 0;
}
