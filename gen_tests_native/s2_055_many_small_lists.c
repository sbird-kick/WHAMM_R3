#include <stdio.h>
#include <stdlib.h>
typedef struct Node { int v; struct Node *next; } Node;
int main(void) {
    long total = 0;
    for (int L = 0; L < 22; L++) {
        Node *head = NULL;
        int cnt = (L % 10) + 3;
        for (int i = 0; i < cnt; i++) {
            Node *n = (Node *)malloc(sizeof(Node));
            n->v = L * 100 + i;
            n->next = head;
            head = n;
        }
        Node *c = head;
        while (c) { total += c->v; Node *nx = c->next; free(c); c = nx; }
    }
    printf("total=%ld\n", total);
    return 0;
}
