#include <stdio.h>
#include <stdlib.h>
typedef struct Obj { int v; struct Obj *next; } Obj;
int main(void) {
    Obj *freelist = NULL;
    Obj *used[50];
    int used_n = 0;
    unsigned long chk = 0;
    for (int i = 0; i < 222; i++) {
        Obj *o;
        if (freelist) { o = freelist; freelist = freelist->next; }
        else o = (Obj *)malloc(sizeof(Obj));
        o->v = i;
        if (used_n < 50) used[used_n++] = o;
        else {
            int idx = i % 50;
            Obj *old = used[idx];
            old->next = freelist;
            freelist = old;
            used[idx] = o;
        }
        chk += (unsigned)o->v;
    }
    for (int i = 0; i < used_n; i++) free(used[i]);
    while (freelist) { Obj *nx = freelist->next; free(freelist); freelist = nx; }
    printf("chk=%lu\n", chk);
    return 0;
}
