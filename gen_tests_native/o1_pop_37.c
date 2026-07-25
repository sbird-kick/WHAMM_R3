#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const unsigned char POP[16]={0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4};
  static const unsigned char DATA[87]={245,250,93,124,77,57,221,74,118,188,172,34,99,20,45,34,159,137,222,128,145,125,97,233,101,142,251,246,103,48,169,208,107,66,43,18,251,99,219,217,219,12,124,139,249,226,235,247,110,176,139,84,27,214,13,54,30,74,46,237,184,170,233,139,222,214,255,32,218,72,61,150,137,253,220,114,106,146,253,55,196,234,225,211,191,52,69};
  static unsigned char scratch[87];
  printf("start o1_pop_37\n");
  long bits=0;
  for(int j=0;j<87;j++){ unsigned char v=DATA[j]; unsigned char p=POP[v&15]+POP[(v>>4)&15]; scratch[j]=p; bits+=p; }
  long chk=0; for(int j=0;j<87;j++) chk+=scratch[j]*(j&7);
  printf("bits=%ld chk=%ld\n",bits,chk);
  return 0;
}
