#include <stdio.h>
#include <stdlib.h>
typedef struct QNode { int v; struct QNode *next; } QNode;
int main(void) {
    QNode *front = NULL, *back = NULL;
    long sum_in = 0, sum_out = 0;
    for (int i = 0; i < 400; i++) {
        QNode *n = (QNode *)malloc(sizeof(QNode));
        n->v = i; n->next = NULL;
        if (back) back->next = n; else front = n;
        back = n;
        sum_in += i;
        if (i % 2 == 1 && front) {
            sum_out += front->v;
            QNode *nx = front->next;
            free(front);
            front = nx;
            if (!front) back = NULL;
        }
    }
    while (front) { sum_out += front->v; QNode *nx = front->next; free(front); front = nx; }
    printf("in=%ld out=%ld\n", sum_in, sum_out);
    return 0;
}
