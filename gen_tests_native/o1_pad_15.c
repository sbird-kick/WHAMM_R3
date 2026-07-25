#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  typedef struct { unsigned char a; int b; unsigned short c; signed char d; } Rec;
  static const Rec R[25]={{205,-396,27332,3},{73,206,42715,-3},{50,-479,2457,5},{226,416,21608,-2},{96,-195,39279,-3},{102,72,8028,-2},{31,576,51948,-5},{208,-305,49736,0},{170,830,33240,-1},{246,953,53939,-4},{167,137,3802,-3},{93,765,53073,-3},{250,837,53035,5},{100,-873,11047,2},{73,-119,41989,-1},{203,3,26226,-5},{241,679,20402,1},{118,-479,5849,4},{148,361,32688,-5},{200,-859,59327,-3},{165,-349,27929,4},{156,-562,35032,4},{212,138,44940,4},{16,-441,12708,3},{33,-904,26033,-1}};
  static Rec M[25];
  printf("start o1_pad_15\n");
  long sb=0; unsigned long sa=0,sc=0; long sd=0;
  for(int j=0;j<25;j++){ M[j]=R[j]; sa+=M[j].a; sb+=M[j].b; sc+=M[j].c; sd+=M[j].d; }
  printf("a=%lu b=%ld c=%lu d=%ld\n",sa,sb,sc,sd);
  return 0;
}
