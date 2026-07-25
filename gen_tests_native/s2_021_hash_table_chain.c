#include <stdio.h>
#include <stdlib.h>
typedef struct Entry { int key, val; struct Entry *next; } Entry;
#define NB 37
int main(void) {
    Entry *buckets[NB] = {0};
    for (int i = 0; i < 222; i++) {
        int key = i * 13 + 7;
        int b = key % NB;
        Entry *e = (Entry *)malloc(sizeof(Entry));
        e->key = key; e->val = i; e->next = buckets[b];
        buckets[b] = e;
    }
    long sum = 0;
    for (int b = 0; b < NB; b++) {
        Entry *cur = buckets[b];
        while (cur) { sum += cur->val; Entry *nx = cur->next; free(cur); cur = nx; }
    }
    printf("sum=%ld\n", sum);
    return 0;
}
