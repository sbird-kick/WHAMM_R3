#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_string_concat_loop", 111);
    char buf[256];
    buf[0] = 0;
    int n = 7;
    for (int i = 0; i < n; i++) {
        char part[8];
        part[0] = 'a' + (i % 26);
        part[1] = 0;
        strcat(buf, part);
    }
    return !(strlen(buf) == (unsigned long)n);
}
