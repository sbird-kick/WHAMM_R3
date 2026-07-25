#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const unsigned char POP[16]={0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4};
  static const unsigned char DATA[107]={219,19,158,244,217,33,248,120,132,162,170,140,196,88,206,103,191,79,3,58,74,118,55,230,134,191,163,19,69,51,234,191,50,194,89,227,189,235,26,237,18,85,132,16,185,150,147,8,60,53,221,113,218,152,147,71,57,102,155,97,142,70,241,35,159,115,16,135,169,81,132,150,176,111,19,43,113,216,207,242,233,205,179,16,195,144,250,119,229,184,199,211,41,124,90,70,222,11,21,199,174,12,31,99,24,194,163};
  static unsigned char scratch[107];
  printf("start o1_pop_40\n");
  long bits=0;
  for(int j=0;j<107;j++){ unsigned char v=DATA[j]; unsigned char p=POP[v&15]+POP[(v>>4)&15]; scratch[j]=p; bits+=p; }
  long chk=0; for(int j=0;j<107;j++) chk+=scratch[j]*(j&7);
  printf("bits=%ld chk=%ld\n",bits,chk);
  return 0;
}
