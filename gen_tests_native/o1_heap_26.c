#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[42]={431,234,745,37,102,28,805,55,830,785,113,37,525,258,530,401,645,95,990,781,910,209,409,555,960,875,487,484,664,384,845,650,226,238,304,222,364,105,557,206,984,206};
  printf("start o1_heap_26\n");
  long grand=0;
  for(int c=0;c<4;c++){
    int len=42;
    int* buf=(int*)malloc(sizeof(int)*len);
    memcpy(buf,T,sizeof(int)*len);
    for(int j=0;j<len;j++) buf[j]+= c*3;
    long s=0; for(int j=0;j<len;j++) s+=buf[j];
    grand+=s; free(buf);
  }
  printf("grand=%ld\n",grand);
  return 0;
}
