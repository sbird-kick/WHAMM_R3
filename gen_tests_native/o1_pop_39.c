#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const unsigned char POP[16]={0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4};
  static const unsigned char DATA[53]={255,24,253,77,163,70,49,217,100,4,5,221,231,105,199,114,225,126,195,24,194,254,140,154,84,162,42,15,142,162,237,57,211,175,190,11,173,73,23,19,198,161,37,110,151,54,10,210,235,128,102,140,133};
  static unsigned char scratch[53];
  printf("start o1_pop_39\n");
  long bits=0;
  for(int j=0;j<53;j++){ unsigned char v=DATA[j]; unsigned char p=POP[v&15]+POP[(v>>4)&15]; scratch[j]=p; bits+=p; }
  long chk=0; for(int j=0;j<53;j++) chk+=scratch[j]*(j&7);
  printf("bits=%ld chk=%ld\n",bits,chk);
  return 0;
}
