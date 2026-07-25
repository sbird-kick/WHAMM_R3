#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct Node { char *data; size_t len; struct Node *next; } Node;
int main(void) {
    Node *head = NULL;
    size_t len = 8;
    for (int i = 0; i < 20; i++) {
        Node *n = (Node *)malloc(sizeof(Node));
        n->data = (char *)malloc(len);
        memset(n->data, i, len);
        n->len = len;
        n->next = head;
        head = n;
        len += 111;
    }
    unsigned long chk = 0;
    Node *cur = head;
    while (cur) {
        chk += (unsigned char)cur->data[0] + cur->len;
        Node *nx = cur->next;
        free(cur->data);
        free(cur);
        cur = nx;
    }
    printf("chk=%lu\n", chk);
    return 0;
}
