#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[51]={-407,-438,277,248,362,176,-116,414,-329,-341,251,370,-444,-471,-281,26,-169,-331,425,-231,-36,-267,-26,-451,-128,80,-379,-497,366,200,-108,434,497,84,-439,151,189,2,312,327,436,146,228,-188,381,-343,-357,211,-295,209,343};
  printf("start o1_lut_3 %d\n",2);
  long acc=0; int p=49;
  for(int s=0;s<46;s++){ acc+=T[p]; p=(p*2+7)%51; if(p<0)p+=-p; }
  printf("acc=%ld p=%d\n",acc,p);
  return 0;
}
