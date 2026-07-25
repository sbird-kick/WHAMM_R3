#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const double D[11]={-921.9889,237.8094,1.0/0.0,935.4581,-626.7950,-301.8960,914.9103,397.8114,-826.9592,-554.4114,-7.691};
  static int classes[11];
  printf("start o1_fp_31\n");
  int fin=0,inf=0;
  for(int j=0;j<11;j++){ double v=D[j]; if(v==v && v< 1e308 && v> -1e308){classes[j]=0; fin++;} else {classes[j]=1; inf++;} }
  printf("fin=%d inf=%d\n",fin,inf);
  for(int j=0;j<11;j++) printf("%d",classes[j]);
  printf("\n"); return 0;
}
