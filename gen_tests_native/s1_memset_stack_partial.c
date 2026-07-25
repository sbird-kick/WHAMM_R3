#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memset_stack_partial", 111);
    char buf[63];
    memset(buf, 0, 63);
    memset(buf + 2, 0x5A, 63 - 4);
    int ok = (buf[0] == 0) && (buf[63-1] == 0) && (buf[2] == 0x5A);
    return !ok;
}
