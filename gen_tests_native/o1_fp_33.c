#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const double D[12]={-418.4849,37.8275,-7.8625,-319.1679,959.0612,-522.1752,1.0/0.0,-1.0/0.0,1.0/0.0,-586.8364,245.6598,-8.665};
  static int classes[12];
  printf("start o1_fp_33\n");
  int fin=0,inf=0;
  for(int j=0;j<12;j++){ double v=D[j]; if(v==v && v< 1e308 && v> -1e308){classes[j]=0; fin++;} else {classes[j]=1; inf++;} }
  printf("fin=%d inf=%d\n",fin,inf);
  for(int j=0;j<12;j++) printf("%d",classes[j]);
  printf("\n"); return 0;
}
