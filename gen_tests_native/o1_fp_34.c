#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const double D[13]={1.0/0.0,-20.3032,328.1885,-112.6790,964.8545,-469.5188,-168.8504,-513.8936,-201.8039,414.4143,-2.503,-1.105,-8.144};
  static int classes[13];
  printf("start o1_fp_34\n");
  int fin=0,inf=0;
  for(int j=0;j<13;j++){ double v=D[j]; if(v==v && v< 1e308 && v> -1e308){classes[j]=0; fin++;} else {classes[j]=1; inf++;} }
  printf("fin=%d inf=%d\n",fin,inf);
  for(int j=0;j<13;j++) printf("%d",classes[j]);
  printf("\n"); return 0;
}
