#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_circular_buffer_shift", 111);
    int cap = 8;
    int buf[30];
    for (int i = 0; i < cap; i++) buf[i] = i;
    // shift left by 2, drop first 2, append at end conceptually
    memmove(buf, buf + 2, (cap - 2) * sizeof(int));
    buf[cap-2] = 100;
    buf[cap-1] = 101;
    int ok = (buf[0] == 2) && (buf[cap-1] == 101);
    return !ok;
}
