#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  typedef struct { unsigned char a; int b; unsigned short c; signed char d; } Rec;
  static const Rec R[11]={{20,726,15071,2},{239,-304,18396,-5},{222,687,56429,-2},{133,-821,8427,-1},{72,928,26175,-5},{52,-719,48625,-2},{161,461,13316,4},{179,-344,50869,-4},{209,342,35712,-2},{196,557,16383,-2},{71,877,5589,4}};
  static Rec M[11];
  printf("start o1_pad_13\n");
  long sb=0; unsigned long sa=0,sc=0; long sd=0;
  for(int j=0;j<11;j++){ M[j]=R[j]; sa+=M[j].a; sb+=M[j].b; sc+=M[j].c; sd+=M[j].d; }
  printf("a=%lu b=%ld c=%lu d=%ld\n",sa,sb,sc,sd);
  return 0;
}
