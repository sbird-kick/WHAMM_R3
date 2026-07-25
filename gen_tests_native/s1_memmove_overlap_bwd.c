#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memmove_overlap_bwd", 111);
    char buf[35];
    for (int i = 0; i < 35; i++) buf[i] = (char)(i + 1);
    memmove(buf, buf + 3, 35 - 3);
    int ok = 1;
    for (int i = 0; i < 35 - 3; i++) if (buf[i] != (char)(i + 4)) ok = 0;
    return !ok;
}
