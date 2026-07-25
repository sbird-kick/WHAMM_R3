/* tinyexpr test 1: evaluate fixed arithmetic expressions via te_interp.
   Prints scaled integer results to keep output deterministic. */
#include <stdio.h>
#include "tinyexpr.h"

static void ev(const char *e){
  int err = 0;
  double r = te_interp(e, &err);
  printf("expr=[%s] err=%d val_x1000=%d\n", e, err, (int)(r*1000));
}

int main(void){
  printf("start misc_tinyexpr_1\n");
  ev("1+1");
  ev("3+4*2");
  ev("(3+4)*2");
  ev("2^10");
  ev("sqrt(144)");
  ev("abs(-7.5)");
  ev("10/4");
  ev("min(3,max(9,2))");
  ev("1+2+3+4+5+6+7+8+9+10");
  ev("3+*2");        /* malformed -> err set */
  printf("end misc_tinyexpr_1\n");
  return 0;
}
