#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_strchr_strstr", 111);
    const char *s = "the quick brown fox 111";
    char *p = strchr(s, 'q');
    char *q = strstr(s, "fox");
    int ok = (p != 0) && (q != 0) && (strlen(s) > 10);
    return !ok;
}
