#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[34]={766,171,253,910,400,624,344,87,755,491,55,378,428,641,271,615,718,851,769,871,2,110,302,583,218,649,167,558,441,562,969,253,670,524};
  printf("start o1_heap_28\n");
  long grand=0;
  for(int c=0;c<7;c++){
    int len=34;
    int* buf=(int*)malloc(sizeof(int)*len);
    memcpy(buf,T,sizeof(int)*len);
    for(int j=0;j<len;j++) buf[j]+= c*3;
    long s=0; for(int j=0;j<len;j++) s+=buf[j];
    grand+=s; free(buf);
  }
  printf("grand=%ld\n",grand);
  return 0;
}
