#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static int A[5][7];
  static const int INIT[35]={0,-9,-8,-9,5,8,-4,-4,-2,-7,-6,1,8,-3,-2,6,-7,1,-8,-1,-2,-4,0,-5,5,4,9,8,-3,0,-5,9,2,0,-1};
  printf("start o1_mat_24\n");
  for(int j=0;j<35;j++) ((int*)A)[j]=INIT[j];
  for(int a=0;a<5;a++) for(int b=0;b<7;b++) A[a][b]=A[a][b]*4+4;
  for(int a=0;a<5;a++){ long s=0; for(int b=0;b<7;b++) s+=A[a][b]; printf("row%d=%ld\n",a,s); }
  return 0;
}
