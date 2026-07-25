#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[76]={993,300,116,366,248,108,197,701,329,452,83,913,79,536,139,300,45,890,46,675,590,671,91,184,678,541,237,173,989,861,816,415,582,803,51,109,447,809,505,895,516,895,243,707,269,228,789,300,202,183,143,562,361,843,434,225,320,592,873,899,508,580,697,6,487,415,174,824,89,763,89,223,401,740,162,603};
  printf("start o1_heap_27\n");
  long grand=0;
  for(int c=0;c<6;c++){
    int len=76;
    int* buf=(int*)malloc(sizeof(int)*len);
    memcpy(buf,T,sizeof(int)*len);
    for(int j=0;j<len;j++) buf[j]+= c*3;
    long s=0; for(int j=0;j<len;j++) s+=buf[j];
    grand+=s; free(buf);
  }
  printf("grand=%ld\n",grand);
  return 0;
}
