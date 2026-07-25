#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_strcpy_strcat", 111);
    char buf[128];
    strcpy(buf, "hello_111_");
    strcat(buf, "world");
    int ok = (strlen(buf) == strlen("hello_111_world"));
    return !ok;
}
