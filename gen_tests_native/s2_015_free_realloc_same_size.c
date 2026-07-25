#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    unsigned long chk = 0;
    for (int i = 0; i < 300; i++) {
        char *p = (char *)malloc(888);
        memset(p, i & 0xFF, 888);
        chk += (unsigned char)p[444];
        free(p);
    }
    printf("chk=%lu\n", chk);
    return 0;
}
