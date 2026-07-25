#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static int A[7][8];
  static const int INIT[56]={7,-9,6,2,8,4,9,8,-2,-1,0,-8,5,-9,-8,6,-6,6,-3,0,-7,-9,0,5,-1,-7,-7,3,-1,5,-2,-4,-1,-9,-4,9,2,9,-3,-8,4,4,8,-4,5,-4,4,-6,6,0,3,3,-8,9,-9,-5};
  printf("start o1_mat_23\n");
  for(int j=0;j<56;j++) ((int*)A)[j]=INIT[j];
  for(int a=0;a<7;a++) for(int b=0;b<8;b++) A[a][b]=A[a][b]*4+9;
  for(int a=0;a<7;a++){ long s=0; for(int b=0;b<8;b++) s+=A[a][b]; printf("row%d=%ld\n",a,s); }
  return 0;
}
