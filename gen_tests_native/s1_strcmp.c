#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_strcmp", 111);
    const char *a = "token_111";
    const char *b = "token_111";
    const char *c = "token_112";
    int ok = (strcmp(a, b) == 0) && (strcmp(a, c) != 0) && (strncmp(a, c, 6) == 0);
    return !ok;
}
