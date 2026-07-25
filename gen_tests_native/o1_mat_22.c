#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static int A[5][7];
  static const int INIT[35]={-5,2,-5,1,-9,1,5,-7,-7,9,8,-8,-1,0,-1,-4,7,-6,3,5,6,2,8,-3,-7,2,8,2,-6,-1,2,-1,1,4,7};
  printf("start o1_mat_22\n");
  for(int j=0;j<35;j++) ((int*)A)[j]=INIT[j];
  for(int a=0;a<5;a++) for(int b=0;b<7;b++) A[a][b]=A[a][b]*4+3;
  for(int a=0;a<5;a++){ long s=0; for(int b=0;b<7;b++) s+=A[a][b]; printf("row%d=%ld\n",a,s); }
  return 0;
}
