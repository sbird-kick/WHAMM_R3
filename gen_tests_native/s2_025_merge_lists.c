#include <stdio.h>
#include <stdlib.h>
typedef struct Node { int v; struct Node *next; } Node;
Node *build(int start, int n, int step) {
    Node *head = NULL;
    for (int i = 0; i < n; i++) {
        Node *nd = (Node *)malloc(sizeof(Node));
        nd->v = start + i * step;
        nd->next = head;
        head = nd;
    }
    return head;
}
long sumfree(Node *h) {
    long s = 0;
    while (h) { s += h->v; Node *nx = h->next; free(h); h = nx; }
    return s;
}
int main(void) {
    long total = sumfree(build(0, 74, 3)) + sumfree(build(1, 74, 5)) + sumfree(build(2, 74, 7));
    printf("total=%ld\n", total);
    return 0;
}
