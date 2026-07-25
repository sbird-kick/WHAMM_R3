#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memmove_overlap_fwd", 111);
    char buf[174];
    for (int i = 0; i < 174; i++) buf[i] = (char)i;
    memmove(buf + 3, buf, 174 - 3);
    int ok = 1;
    for (int i = 0; i < 174 - 3; i++) if (buf[i+3] != (char)i) ok = 0;
    return !ok;
}
