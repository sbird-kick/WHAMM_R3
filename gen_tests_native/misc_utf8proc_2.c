/* utf8proc test 2: normalization + case folding of fixed strings.
   Prints output byte lengths and a rolling checksum of output bytes. */
#include <stdio.h>
#include <stdlib.h>
#include "utf8proc.h"

static unsigned cksum(const utf8proc_uint8_t *s){
  unsigned h = 2166136261u;
  while(*s){ h ^= *s++; h *= 16777619u; }
  return h;
}

static void run(const char *label, const char *s, utf8proc_option_t opt){
  utf8proc_uint8_t *out = NULL;
  utf8proc_ssize_t n = utf8proc_map(
      (const utf8proc_uint8_t*)s, 0, &out,
      (utf8proc_option_t)(UTF8PROC_NULLTERM | UTF8PROC_STABLE | opt));
  if(n < 0 || !out){ printf("%s: ERR %ld\n", label, (long)n); return; }
  printf("%s: outbytes=%ld cksum=%08x\n", label, (long)n, cksum(out));
  free(out);
}

int main(void){
  printf("start misc_utf8proc_2\n");
  /* casefold uppercase -> lowercase */
  run("fold_upper", "HELLO World", UTF8PROC_CASEFOLD);
  /* NFC compose: e + combining acute -> é */
  run("nfc_combine", "e\xCC\x81", UTF8PROC_COMPOSE);
  /* NFD decompose: é -> e + combining acute */
  run("nfd_decomp", "\xC3\xA9", UTF8PROC_DECOMPOSE);
  /* compatibility fold of ligature fi (U+FB01) */
  run("compat_fi", "\xEF\xAC\x81", (utf8proc_option_t)(UTF8PROC_COMPAT|UTF8PROC_DECOMPOSE));
  /* strip default-ignorable + casefold on greek */
  run("greek_fold", "\xCE\x91\xCE\x92\xCE\x93", UTF8PROC_CASEFOLD);
  printf("end misc_utf8proc_2\n");
  return 0;
}
