/* stb_sprintf test 1: format fixed values with many conversions and
   print both the formatted string and the returned length. Deterministic. */
#define STB_SPRINTF_IMPLEMENTATION
#include "stb_sprintf.h"
#include <stdio.h>

int main(void){
  printf("start misc_stbsp_1\n");
  char b[256];
  int n;

  n = stbsp_sprintf(b, "int=%d uint=%u hex=%x HEX=%X oct=%o", 42, 42u, 255, 255, 64);
  printf("[%s] n=%d\n", b, n);

  n = stbsp_sprintf(b, "pad=[%5d] zero=[%05d] left=[%-5d] plus=[%+d]", 7, 7, 7, 7);
  printf("[%s] n=%d\n", b, n);

  n = stbsp_sprintf(b, "flt=%.4f exp=%.3e g=%g", 3.14159265, 12345.678, 0.0001);
  printf("[%s] n=%d\n", b, n);

  n = stbsp_sprintf(b, "str=[%s] cpad=[%8s] str2=[%-8s]", "hi", "hi", "hi");
  printf("[%s] n=%d\n", b, n);

  n = stbsp_sprintf(b, "char=%c pct=%%", 'Z');
  printf("[%s] n=%d\n", b, n);

  n = stbsp_sprintf(b, "ll=%lld neg=%d big=%u", 9000000000LL, -123, 4000000000u);
  printf("[%s] n=%d\n", b, n);

  printf("end misc_stbsp_1\n");
  return 0;
}
