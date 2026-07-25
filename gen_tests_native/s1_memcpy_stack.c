#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memcpy_stack", 111);
    char src[230];
    char dst[230];
    for (int i = 0; i < 230; i++) src[i] = (char)(i * 3 + 6);
    memcpy(dst, src, 230);
    int ok = 1;
    for (int i = 0; i < 230; i++) if (dst[i] != src[i]) ok = 0;
    return !ok;
}
