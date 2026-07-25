#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const char* W[6]={"lima","golf","november","alpha","juliet","oscar"};
  static int counts[6]={0};
  printf("start o1_strtab_8\n");
  for(int s=0;s<18; s++){ int j=s%6; counts[j]+=(int)W[j][0]; }
  long tot=0; for(int j=0;j<6;j++){ printf("%s=%d\n",W[j],counts[j]); tot+=counts[j]; }
  printf("tot=%ld\n",tot);
  return 0;
}
