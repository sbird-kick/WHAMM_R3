#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const char* W[7]={"kilo","golf","juliet","papa","hotel","foxtrot","alpha"};
  static int counts[7]={0};
  printf("start o1_strtab_7\n");
  for(int s=0;s<21; s++){ int j=s%7; counts[j]+=(int)W[j][0]; }
  long tot=0; for(int j=0;j<7;j++){ printf("%s=%d\n",W[j],counts[j]); tot+=counts[j]; }
  printf("tot=%ld\n",tot);
  return 0;
}
