/* tinyexpr test 2: compile once with bound variables, evaluate at many
   fixed points (like sampling a function). Deterministic integer output. */
#include <stdio.h>
#include "tinyexpr.h"

int main(void){
  printf("start misc_tinyexpr_2\n");
  double x = 0, y = 0;
  te_variable vars[] = {{"x", &x}, {"y", &y}};
  int err = 0;

  /* polynomial in x */
  te_expr *p = te_compile("x*x - 3*x + 2", vars, 2, &err);
  if(!p){ printf("compile-fail-at=%d\n", err); return 0; }
  long acc = 0;
  for(int i=0;i<=10;i++){
    x = i;
    double v = te_eval(p);
    acc += (long)v;
    printf("p(%d)=%d\n", i, (int)v);
  }
  printf("poly_acc=%ld\n", acc);
  te_free(p);

  /* two-variable expression */
  te_expr *h = te_compile("sqrt(x*x + y*y)", vars, 2, &err);
  if(h){
    x = 3; y = 4; printf("hyp(3,4)=%d\n", (int)te_eval(h));
    x = 5; y = 12; printf("hyp(5,12)=%d\n", (int)te_eval(h));
    x = 8; y = 15; printf("hyp(8,15)=%d\n", (int)te_eval(h));
    te_free(h);
  }

  printf("end misc_tinyexpr_2\n");
  return 0;
}
