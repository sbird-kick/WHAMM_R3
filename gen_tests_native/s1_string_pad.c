#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_string_pad", 111);
    char buf[40];
    memset(buf, ' ', 39);
    buf[39] = 0;
    const char *s = "pad_111";
    memcpy(buf, s, strlen(s));
    int ok = (buf[strlen(s)] == ' ') && (buf[39] == 0);
    return !ok;
}
