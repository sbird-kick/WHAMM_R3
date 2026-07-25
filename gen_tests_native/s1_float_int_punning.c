#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_float_int_punning", 111);
    float f = 11.5f;
    unsigned int u;
    memcpy(&u, &f, sizeof(float));
    float f2;
    memcpy(&f2, &u, sizeof(float));
    return !(f == f2);
}
