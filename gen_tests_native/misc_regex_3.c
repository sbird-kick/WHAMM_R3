/* tiny-regex-c test 3: metacharacter classes, star/plus/question, anchors.
   Fixed patterns/texts; prints idx and len for each. Deterministic. */
#include <stdio.h>
#include "re.h"

static void m(const char *pat, const char *txt){
  int len = 0;
  int idx = re_match(pat, txt, &len);
  printf("[%s] ~ [%s] => %d,%d\n", pat, txt, idx, idx<0?0:len);
}

int main(void){
  printf("start misc_regex_3\n");
  m("colou?r", "color");
  m("colou?r", "colour");
  m("ab*c", "ac");
  m("ab*c", "abbbbc");
  m("a+b", "aaab");
  m("[^0-9]+", "abc123");
  m("\\d\\d\\d", "x4567y");
  m("^\\d+$", "12345");
  m("^\\d+$", "12a45");
  m(".*end", "start middle end");
  m("[.]", "a.b");
  printf("end misc_regex_3\n");
  return 0;
}
