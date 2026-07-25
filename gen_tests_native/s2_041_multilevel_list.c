#include <stdio.h>
#include <stdlib.h>
typedef struct Node { int v; struct Node *down; struct Node *next; } Node;
int main(void) {
    Node *top = NULL, *prevtop = NULL;
    for (int level = 0; level < 4; level++) {
        Node *head = NULL, *tail = NULL;
        for (int i = 0; i < 30; i++) {
            Node *n = (Node *)malloc(sizeof(Node));
            n->v = level * 100 + i; n->next = NULL; n->down = NULL;
            if (tail) tail->next = n; else head = n;
            tail = n;
        }
        if (level == 0) top = head;
        prevtop = head;
    }
    long sum = 0;
    for (Node *c = top; c; c = c->next) sum += c->v;
    Node *c = top;
    while (c) { Node *nx = c->next; free(c); c = nx; }
    printf("sum=%ld\n", sum);
    (void)prevtop;
    return 0;
}
