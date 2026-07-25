#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const unsigned char POP[16]={0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4};
  static const unsigned char DATA[97]={223,148,122,46,34,58,26,41,238,188,60,170,12,100,19,99,195,100,119,105,204,239,147,226,197,187,56,67,129,43,137,246,124,161,62,1,91,229,240,152,71,183,48,180,56,160,105,215,70,35,63,72,244,208,52,200,20,48,57,154,137,214,180,241,59,171,155,65,69,183,84,245,8,121,49,215,250,65,131,225,162,36,58,241,125,165,59,188,153,184,48,151,135,68,133,145,155};
  static unsigned char scratch[97];
  printf("start o1_pop_36\n");
  long bits=0;
  for(int j=0;j<97;j++){ unsigned char v=DATA[j]; unsigned char p=POP[v&15]+POP[(v>>4)&15]; scratch[j]=p; bits+=p; }
  long chk=0; for(int j=0;j<97;j++) chk+=scratch[j]*(j&7);
  printf("bits=%ld chk=%ld\n",bits,chk);
  return 0;
}
