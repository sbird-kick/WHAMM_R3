#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[38]={668,688,961,564,997,97,563,402,983,606,53,637,872,253,662,285,259,601,330,903,268,955,268,516,917,925,857,196,127,304,297,501,247,649,333,826,193,188};
  printf("start o1_heap_30\n");
  long grand=0;
  for(int c=0;c<7;c++){
    int len=38;
    int* buf=(int*)malloc(sizeof(int)*len);
    memcpy(buf,T,sizeof(int)*len);
    for(int j=0;j<len;j++) buf[j]+= c*3;
    long s=0; for(int j=0;j<len;j++) s+=buf[j];
    grand+=s; free(buf);
  }
  printf("grand=%ld\n",grand);
  return 0;
}
