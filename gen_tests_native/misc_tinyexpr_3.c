/* tinyexpr test 3: trig/exp builtins + nested expressions at fixed args.
   Uses te_interp; scales results to integers for determinism. */
#include <stdio.h>
#include "tinyexpr.h"

static void ev(const char *e){
  int err = 0;
  double r = te_interp(e, &err);
  printf("[%s] e=%d v=%d\n", e, err, (int)(r*10000));
}

int main(void){
  printf("start misc_tinyexpr_3\n");
  ev("sin(0)");
  ev("cos(0)");
  ev("exp(0)");
  ev("ln(exp(2))");
  ev("floor(3.9)");
  ev("ceil(3.1)");
  ev("pow(2,8)");
  ev("fmod(17,5)");
  ev("(1+sqrt(4))*ceil(2.2)");
  ev("log10(1000)");
  printf("end misc_tinyexpr_3\n");
  return 0;
}
