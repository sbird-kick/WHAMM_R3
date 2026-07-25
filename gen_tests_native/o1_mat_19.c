#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static int A[5][6];
  static const int INIT[30]={-7,5,4,-1,-8,-9,4,0,7,1,5,0,-6,1,4,3,-3,1,-1,-6,-1,5,2,-8,-3,0,-9,-2,-9,9};
  printf("start o1_mat_19\n");
  for(int j=0;j<30;j++) ((int*)A)[j]=INIT[j];
  for(int a=0;a<5;a++) for(int b=0;b<6;b++) A[a][b]=A[a][b]*4+8;
  for(int a=0;a<5;a++){ long s=0; for(int b=0;b<6;b++) s+=A[a][b]; printf("row%d=%ld\n",a,s); }
  return 0;
}
