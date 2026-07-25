#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    const char *words[] = {"alpha","beta","gamma","delta","epsilon","zeta","eta","theta"};
    int n = 8;
    char **copies = (char **)malloc(sizeof(char *) * n);
    for (int i = 0; i < n; i++) {
        size_t l = strlen(words[i]) + 1;
        copies[i] = (char *)malloc(l);
        memcpy(copies[i], words[i], l);
    }
    unsigned long chk = 0;
    for (int i = 0; i < n; i++) { chk += strlen(copies[i]); free(copies[i]); }
    free(copies);
    printf("chk=%lu\n", chk);
    return 0;
}
