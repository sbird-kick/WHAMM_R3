/* utf8proc test 1: decode fixed UTF-8 strings codepoint by codepoint,
   report codepoint values, category, and total width. Deterministic. */
#include <stdio.h>
#include "utf8proc.h"

static void analyze(const char *label, const char *s){
  const utf8proc_uint8_t *p = (const utf8proc_uint8_t*)s;
  utf8proc_ssize_t remaining = 0;
  { const char *q=s; while(*q){ remaining++; q++; } }
  utf8proc_int32_t cp;
  int count = 0;
  long cpsum = 0;
  int width = 0;
  while(remaining > 0){
    utf8proc_ssize_t used = utf8proc_iterate(p, remaining, &cp);
    if(used < 1) break;
    count++;
    cpsum += cp;
    width += utf8proc_charwidth(cp);
    p += used;
    remaining -= used;
  }
  printf("%s: cps=%d cpsum=%ld width=%d\n", label, count, cpsum, width);
}

int main(void){
  printf("start misc_utf8proc_1\n");
  analyze("ascii", "Hello");
  analyze("accents", "H\xC3\xA9llo");            /* Héllo */
  analyze("greek", "\xCE\xB1\xCE\xB2\xCE\xB3");   /* αβγ */
  analyze("cjk", "\xE4\xB8\xAD\xE6\x96\x87");     /* 中文 */
  analyze("emoji", "\xF0\x9F\x98\x80");           /* U+1F600 */
  printf("end misc_utf8proc_1\n");
  return 0;
}
