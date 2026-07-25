#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_strtok", 111);
    char s[64];
    strcpy(s, "aa,bb,cc,dd_3");
    int count = 0;
    char *tok = strtok(s, ",");
    while (tok) { count++; tok = strtok(0, ","); }
    return !(count == 4);
}
