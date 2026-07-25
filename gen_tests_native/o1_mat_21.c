#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static int A[8][5];
  static const int INIT[40]={-8,3,-5,-1,-8,-7,7,4,-4,2,6,3,5,5,-2,6,1,1,9,4,-3,4,1,-3,9,8,8,-2,-3,-6,8,-5,-8,4,-1,4,-6,-3,3,7};
  printf("start o1_mat_21\n");
  for(int j=0;j<40;j++) ((int*)A)[j]=INIT[j];
  for(int a=0;a<8;a++) for(int b=0;b<5;b++) A[a][b]=A[a][b]*4+3;
  for(int a=0;a<8;a++){ long s=0; for(int b=0;b<5;b++) s+=A[a][b]; printf("row%d=%ld\n",a,s); }
  return 0;
}
