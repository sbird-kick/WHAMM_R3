#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t cap = 16, len = 0;
    char *buf = (char *)malloc(cap);
    const char *word = "wasm222";
    size_t wl = strlen(word);
    for (int i = 0; i < 40; i++) {
        if (len + wl + 1 > cap) {
            cap = cap * 2;
            buf = (char *)realloc(buf, cap);
        }
        memcpy(buf + len, word, wl);
        len += wl;
        buf[len] = '\0';
    }
    printf("len=%zu cap=%zu last=%c\n", len, cap, buf[len - 1]);
    free(buf);
    return 0;
}
