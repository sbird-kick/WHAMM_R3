#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memmove_noop_and_memcpy", 111);
    int n = 86;
    char buf[300];
    for (int i = 0; i < n; i++) buf[i] = (char)(i * 2);
    memmove(buf, buf, n);
    char other[300];
    memcpy(other, buf, n);
    int ok = 1;
    for (int i = 0; i < n; i++) if (other[i] != buf[i]) ok = 0;
    return !ok;
}
