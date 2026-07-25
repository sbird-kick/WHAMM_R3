#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static int A[8][7];
  static const int INIT[56]={7,1,1,-9,3,8,4,-4,-3,2,4,-6,-4,-4,-3,4,1,-3,8,9,3,8,-4,5,-2,0,8,5,7,-2,8,-9,7,-4,6,-2,-1,-6,5,-8,5,-3,-8,-2,-7,8,9,-8,4,7,8,-9,1,-1,-7,-5};
  printf("start o1_mat_20\n");
  for(int j=0;j<56;j++) ((int*)A)[j]=INIT[j];
  for(int a=0;a<8;a++) for(int b=0;b<7;b++) A[a][b]=A[a][b]*3+2;
  for(int a=0;a<8;a++){ long s=0; for(int b=0;b<7;b++) s+=A[a][b]; printf("row%d=%ld\n",a,s); }
  return 0;
}
