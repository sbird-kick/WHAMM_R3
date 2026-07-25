/* tiny-regex-c test 2: precompile patterns with re_compile, scan a fixed
   corpus for all non-overlapping matches, count them and sum positions. */
#include <stdio.h>
#include "re.h"

static void scan(const char *pat, const char *txt){
  re_t rx = re_compile(pat);
  int count = 0, possum = 0, base = 0;
  const char *p = txt;
  while(*p){
    int len = 0;
    int idx = re_matchp(rx, p, &len);
    if(idx < 0) break;
    if(len == 0){ p++; continue; }
    count++;
    possum += base + idx;
    p   += idx + len;
    base += idx + len;
  }
  printf("pat=[%s] count=%d possum=%d\n", pat, count, possum);
}

int main(void){
  printf("start misc_regex_2\n");
  static const char *corpus =
    "id=17 id=204 id=3 tag=abc id=99 zzz id=1000 end";
  scan("id=[0-9]+", corpus);
  scan("[0-9]+", corpus);
  scan("[a-z]+", "one two three four five");
  scan("\\w+", "alpha, beta; gamma. delta");
  printf("end misc_regex_2\n");
  return 0;
}
