#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const int T[54]={-33,-364,-196,-384,244,22,465,400,230,-12,-275,162,-350,-440,69,-431,358,-348,-241,-408,-262,-96,-187,-311,383,384,175,261,-166,-433,-273,-166,-94,-286,-480,-362,-210,-47,165,-450,346,-253,45,70,364,47,-94,-279,-312,387,176,104,289,-152};
  printf("start o1_lut_6 %d\n",7);
  long acc=0; int p=32;
  for(int s=0;s<50;s++){ acc+=T[p]; p=(p*7+7)%54; if(p<0)p+=-p; }
  printf("acc=%ld p=%d\n",acc,p);
  return 0;
}
