#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_manual_strdup", 111);
    const char *src = "duplicate_this_111";
    char *dup = malloc(strlen(src) + 1);
    if (!dup) return 1;
    strcpy(dup, src);
    int ok = (strcmp(dup, src) == 0);
    free(dup);
    return !ok;
}
