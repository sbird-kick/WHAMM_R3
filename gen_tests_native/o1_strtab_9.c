#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const char* W[12]={"bravo","echo","november","golf","hotel","quebec","kilo","charlie","delta","foxtrot","oscar","mike"};
  static int counts[12]={0};
  printf("start o1_strtab_9\n");
  for(int s=0;s<36; s++){ int j=s%12; counts[j]+=(int)W[j][0]; }
  long tot=0; for(int j=0;j<12;j++){ printf("%s=%d\n",W[j],counts[j]); tot+=counts[j]; }
  printf("tot=%ld\n",tot);
  return 0;
}
