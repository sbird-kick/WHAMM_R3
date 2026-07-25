#include <stdio.h>
#include <stdlib.h>
typedef struct Node { int v; struct Node *next; } Node;
int main(void) {
    Node *head = NULL;
    int depth = 500;
    for (int i = 0; i < depth; i++) {
        Node *n = (Node *)malloc(sizeof(Node));
        n->v = (i * 222) % 1009;
        n->next = head;
        head = n;
    }
    long sum = 0;
    Node *cur = head;
    int cnt = 0;
    while (cur) { sum += cur->v; cnt++; Node *nx = cur->next; free(cur); cur = nx; }
    printf("sum=%ld cnt=%d\n", sum, cnt);
    return 0;
}
