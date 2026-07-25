#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const char* W[9]={"quebec","delta","juliet","foxtrot","lima","oscar","kilo","bravo","alpha"};
  static int counts[9]={0};
  printf("start o1_strtab_12\n");
  for(int s=0;s<27; s++){ int j=s%9; counts[j]+=(int)W[j][0]; }
  long tot=0; for(int j=0;j<9;j++){ printf("%s=%d\n",W[j],counts[j]); tot+=counts[j]; }
  printf("tot=%ld\n",tot);
  return 0;
}
