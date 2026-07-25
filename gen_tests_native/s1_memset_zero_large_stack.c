#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memset_zero_large_stack", 111);
    char buf[342];
    for (int i = 0; i < 342; i++) buf[i] = (char)1;
    memset(buf, 0, 342);
    int ok = 1;
    for (int i = 0; i < 342; i++) if (buf[i] != 0) ok = 0;
    return !ok;
}
