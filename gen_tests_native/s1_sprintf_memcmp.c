#include <stdio.h>

#include <stdio.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_sprintf_memcmp", 111);
    char a[32], b[32];
    sprintf(a, "val=%d", 111);
    sprintf(b, "val=%d", 111);
    return !(memcmp(a, b, strlen(a)) == 0);
}
