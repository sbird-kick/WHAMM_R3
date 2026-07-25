#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[67]={408,151,403,104,711,383,885,360,66,152,294,771,924,219,345,924,434,750,793,348,781,73,544,791,874,966,214,447,88,960,882,910,229,622,432,485,2,819,2,392,645,453,123,158,296,386,423,55,860,58,318,906,76,896,978,913,920,964,604,409,408,71,873,747,690,547,779};
  printf("start o1_heap_29\n");
  long grand=0;
  for(int c=0;c<4;c++){
    int len=67;
    int* buf=(int*)malloc(sizeof(int)*len);
    memcpy(buf,T,sizeof(int)*len);
    for(int j=0;j<len;j++) buf[j]+= c*3;
    long s=0; for(int j=0;j<len;j++) s+=buf[j];
    grand+=s; free(buf);
  }
  printf("grand=%ld\n",grand);
  return 0;
}
