#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const double D[15]={-402.4456,501.7609,742.7328,347.0021,-891.5088,1.0/0.0,127.2468,-1.0/0.0,-223.2736,633.0056,-70.4634,-864.3862,-92.2228,5.056,-6.965};
  static int classes[15];
  printf("start o1_fp_32\n");
  int fin=0,inf=0;
  for(int j=0;j<15;j++){ double v=D[j]; if(v==v && v< 1e308 && v> -1e308){classes[j]=0; fin++;} else {classes[j]=1; inf++;} }
  printf("fin=%d inf=%d\n",fin,inf);
  for(int j=0;j<15;j++) printf("%d",classes[j]);
  printf("\n"); return 0;
}
