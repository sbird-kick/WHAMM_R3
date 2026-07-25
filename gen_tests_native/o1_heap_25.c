#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[45]={904,168,76,196,712,207,477,627,756,162,797,251,77,984,687,38,154,923,289,434,878,782,17,193,212,348,354,795,762,949,353,868,367,1000,47,476,849,807,467,480,75,868,670,759,778};
  printf("start o1_heap_25\n");
  long grand=0;
  for(int c=0;c<6;c++){
    int len=45;
    int* buf=(int*)malloc(sizeof(int)*len);
    memcpy(buf,T,sizeof(int)*len);
    for(int j=0;j<len;j++) buf[j]+= c*3;
    long s=0; for(int j=0;j<len;j++) s+=buf[j];
    grand+=s; free(buf);
  }
  printf("grand=%ld\n",grand);
  return 0;
}
