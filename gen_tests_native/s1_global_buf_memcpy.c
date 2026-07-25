#include <stdio.h>

#include <string.h>
static unsigned char gsrc[34];
static unsigned char gdst[34];
int main() {
    printf("start %s %d\n", "s1_global_buf_memcpy", 111);
    for (int i = 0; i < 34; i++) gsrc[i] = (unsigned char)(i * 7 + 1);
    memcpy(gdst, gsrc, 34);
    int ok = 1;
    for (int i = 0; i < 34; i++) if (gdst[i] != gsrc[i]) ok = 0;
    return !ok;
}
