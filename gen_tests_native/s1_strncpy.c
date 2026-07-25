#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_strncpy", 111);
    char dst[32];
    memset(dst, 'X', 32);
    strncpy(dst, "abcdef111", 10);
    int ok = (dst[0] == 'a') && (dst[9] != 'X' || dst[9] == 0);
    return !ok;
}
