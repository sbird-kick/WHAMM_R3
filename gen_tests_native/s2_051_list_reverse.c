#include <stdio.h>
#include <stdlib.h>
typedef struct Node { int v; struct Node *next; } Node;
int main(void) {
    Node *head = NULL;
    for (int i = 0; i < 222; i++) {
        Node *n = (Node *)malloc(sizeof(Node));
        n->v = i; n->next = head; head = n;
    }
    Node *prev = NULL, *cur = head;
    while (cur) { Node *nx = cur->next; cur->next = prev; prev = cur; cur = nx; }
    head = prev;
    long sum = 0;
    cur = head;
    while (cur) { sum += cur->v; Node *nx = cur->next; free(cur); cur = nx; }
    printf("sum=%ld\n", sum);
    return 0;
}
