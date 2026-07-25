#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_int_to_bytes_memcpy", 111);
    int v = 333;
    unsigned char buf[4];
    memcpy(buf, &v, 4);
    int back = 0;
    memcpy(&back, buf, 4);
    return !(back == v);
}
