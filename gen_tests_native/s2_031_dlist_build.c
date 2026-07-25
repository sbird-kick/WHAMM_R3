#include <stdio.h>
#include <stdlib.h>
typedef struct DNode { int v; struct DNode *prev, *next; } DNode;
int main(void) {
    DNode *head = NULL, *tail = NULL;
    for (int i = 0; i < 222; i++) {
        DNode *n = (DNode *)malloc(sizeof(DNode));
        n->v = i; n->next = NULL; n->prev = tail;
        if (tail) tail->next = n; else head = n;
        tail = n;
    }
    long fsum = 0, bsum = 0;
    for (DNode *c = head; c; c = c->next) fsum += c->v;
    for (DNode *c = tail; c; c = c->prev) bsum += c->v;
    DNode *c = head;
    while (c) { DNode *nx = c->next; free(c); c = nx; }
    printf("fsum=%ld bsum=%ld\n", fsum, bsum);
    return 0;
}
