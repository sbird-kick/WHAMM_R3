#include <stdio.h>
#include <stdlib.h>
typedef struct Node { int val; struct Node *next; } Node;
int main(void) {
    Node *head = NULL;
    for (int i = 0; i < 222; i++) {
        Node *n = (Node *)malloc(sizeof(Node));
        n->val = i * 3 + 1;
        n->next = head;
        head = n;
    }
    long sum = 0;
    Node *cur = head;
    while (cur) { sum += cur->val; cur = cur->next; }
    printf("list_sum=%ld\n", sum);
    cur = head;
    while (cur) { Node *nx = cur->next; free(cur); cur = nx; }
    return 0;
}
