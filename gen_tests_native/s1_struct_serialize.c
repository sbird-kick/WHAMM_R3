#include <stdio.h>

#include <string.h>
typedef struct { int a; short b; char c; } Packed;
int main() {
    printf("start %s %d\n", "s1_struct_serialize", 111);
    Packed p = { 111, (short)(111), (char)(111) };
    unsigned char buf[sizeof(Packed)];
    memcpy(buf, &p, sizeof(Packed));
    Packed q;
    memcpy(&q, buf, sizeof(Packed));
    int ok = (q.a == p.a) && (q.b == p.b) && (q.c == p.c);
    return !ok;
}
