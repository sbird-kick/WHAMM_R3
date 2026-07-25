/* Deterministic stubs for os/io/time symbols. time() is overridden (not just
 * for the missing ones) so Lua's hash seed, math RNG seed, and table.sort
 * pivot become deterministic AND we avoid wizeng's unimplemented
 * clock_time_get WASI call. None affect the (time-independent) test scripts. */
#include <stdio.h>
#include <time.h>
clock_t clock(void){ return (clock_t)0; }
time_t time(time_t *t){ if(t)*t=(time_t)0; return (time_t)0; }
int system(const char *cmd){ (void)cmd; return -1; }
char *tmpnam(char *s){ (void)s; return (char*)0; }
FILE *tmpfile(void){ return (FILE*)0; }
