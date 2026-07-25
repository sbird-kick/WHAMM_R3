#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memchr", 111);
    unsigned char buf[170];
    for (int i = 0; i < 170; i++) buf[i] = (unsigned char)(i + 1);
    unsigned char target = (unsigned char)((170/2) + 1);
    void *p = memchr(buf, target, 170);
    return !(p == (void*)&buf[170/2]);
}
