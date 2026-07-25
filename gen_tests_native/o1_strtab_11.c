#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const char* W[14]={"juliet","mike","bravo","delta","india","foxtrot","oscar","hotel","papa","lima","quebec","november","echo","kilo"};
  static int counts[14]={0};
  printf("start o1_strtab_11\n");
  for(int s=0;s<42; s++){ int j=s%14; counts[j]+=(int)W[j][0]; }
  long tot=0; for(int j=0;j<14;j++){ printf("%s=%d\n",W[j],counts[j]); tot+=counts[j]; }
  printf("tot=%ld\n",tot);
  return 0;
}
