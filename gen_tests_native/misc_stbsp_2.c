/* stb_sprintf test 2: bounded snprintf truncation + callback streaming path.
   Verifies return values and total bytes streamed on fixed inputs. */
#define STB_SPRINTF_IMPLEMENTATION
#include "stb_sprintf.h"
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

static int g_total = 0;
static char g_scratch[STB_SPRINTF_MIN];
static char *cb(const char *buf, void *user, int len){
  (void)buf; (void)user;
  g_total += len;      /* count every byte the formatter produces */
  return g_scratch;    /* keep reusing the same scratch buffer */
}

static int stream(const char *fmt, ...){
  va_list va;
  va_start(va, fmt);
  int n = stbsp_vsprintfcb(cb, 0, g_scratch, fmt, va);
  va_end(va);
  return n;
}

int main(void){
  printf("start misc_stbsp_2\n");
  char small[8];

  /* truncation: return value is full intended length; buffer NUL-terminated */
  int n = stbsp_snprintf(small, sizeof small, "%d-%d-%d", 111, 222, 333);
  printf("trunc_ret=%d buf=[%s] buflen=%d\n", n, small, (int)strlen(small));

  n = stbsp_snprintf(small, sizeof small, "%s", "abcdefghijklmnop");
  printf("trunc2_ret=%d buf=[%s] buflen=%d\n", n, small, (int)strlen(small));

  /* callback streaming path for output larger than one scratch buffer */
  g_total = 0;
  int m = stream("%0200d|%0150d|%.20f", 5, 9, 2.71828182845904523536);
  printf("stream_ret=%d total_bytes=%d match=%d\n", m, g_total, m==g_total);

  printf("end misc_stbsp_2\n");
  return 0;
}
