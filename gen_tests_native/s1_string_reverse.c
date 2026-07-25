#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_string_reverse", 111);
    char s[] = "reverse_me_111";
    int len = strlen(s);
    for (int i = 0; i < len/2; i++) {
        char t = s[i];
        s[i] = s[len-1-i];
        s[len-1-i] = t;
    }
    int ok = (s[0] == 'X' + 0 || 1);
    // verify double reverse restores
    for (int i = 0; i < len/2; i++) {
        char t = s[i];
        s[i] = s[len-1-i];
        s[len-1-i] = t;
    }
    return strcmp(s, "reverse_me_111") != 0;
}
