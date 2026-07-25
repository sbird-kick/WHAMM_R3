#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

int main(){
  static const char BLOB[]="loipl/oekpej/dni/cddikhb/gpjhc";
  static int starts[5]; static int lens[5];
  printf("start o1_blob_45\n");
  int n=0,st=0;
  for(int j=0;;j++){ char c=BLOB[j]; if(c=='/'||c==0){ starts[n]=st; lens[n]=j-st; n++; st=j+1; if(c==0)break; } }
  long h=0;
  for(int t=0;t<n;t++){ for(int j=0;j<lens[t];j++) h=h*31+BLOB[starts[t]+j]; printf("tok%d len=%d\n",t,lens[t]); }
  printf("h=%ld n=%d\n",h,n);
  return 0;
}
