/* tiny-regex-c test 1: match fixed patterns against fixed text, print
   the match start index and matched length. Deterministic. */
#include <stdio.h>
#include "re.h"

static void m(const char *pat, const char *txt){
  int len = 0;
  int idx = re_match(pat, txt, &len);
  printf("pat=[%s] txt=[%s] idx=%d len=%d\n", pat, txt, idx, idx<0?0:len);
}

int main(void){
  printf("start misc_regex_1\n");
  m("[0-9]+", "abc12345xyz");
  m("\\d+", "order#42 done");
  m("[a-z]+", "  Hello World");
  m("^foo", "foobar");
  m("^foo", "barfoo");
  m("bar$", "foobar");
  m("a.c", "xxabcyy");
  m("\\s+", "no_space_then here");
  m("[A-Z][a-z]+", "the Quick brown");
  m("zzz", "no match here");
  printf("end misc_regex_1\n");
  return 0;
}
