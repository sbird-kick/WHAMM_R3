#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const unsigned char POP[16]={0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4};
  static const unsigned char DATA[108]={166,195,85,142,196,245,188,35,217,169,165,38,138,64,216,97,52,191,58,26,136,251,200,106,206,42,40,155,163,246,186,56,12,134,64,0,93,22,148,190,252,149,129,102,130,47,243,62,165,66,16,174,17,20,240,156,158,100,243,129,50,66,28,138,132,59,58,121,143,56,197,102,66,53,104,129,74,174,143,139,143,18,30,175,240,112,35,198,75,3,215,7,153,244,89,29,99,142,71,155,169,173,197,196,101,37,156,121};
  static unsigned char scratch[108];
  printf("start o1_pop_38\n");
  long bits=0;
  for(int j=0;j<108;j++){ unsigned char v=DATA[j]; unsigned char p=POP[v&15]+POP[(v>>4)&15]; scratch[j]=p; bits+=p; }
  long chk=0; for(int j=0;j<108;j++) chk+=scratch[j]*(j&7);
  printf("bits=%ld chk=%ld\n",bits,chk);
  return 0;
}
