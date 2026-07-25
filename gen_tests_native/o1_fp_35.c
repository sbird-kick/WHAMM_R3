#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const double D[16]={310.5483,-645.6625,-893.5086,294.9749,-130.5428,-49.5693,201.4746,209.0144,-470.2583,-866.1910,-870.3653,-243.9394,-776.0736,-1.0/0.0,-5.202,1.688};
  static int classes[16];
  printf("start o1_fp_35\n");
  int fin=0,inf=0;
  for(int j=0;j<16;j++){ double v=D[j]; if(v==v && v< 1e308 && v> -1e308){classes[j]=0; fin++;} else {classes[j]=1; inf++;} }
  printf("fin=%d inf=%d\n",fin,inf);
  for(int j=0;j<16;j++) printf("%d",classes[j]);
  printf("\n"); return 0;
}
