#include <stdio.h>
#include <stdlib.h>
typedef struct TNode { int val; struct TNode *l, *r; } TNode;
TNode *make(int v) {
    TNode *n = (TNode *)malloc(sizeof(TNode));
    n->val = v; n->l = n->r = NULL;
    return n;
}
void insert(TNode *root, int v) {
    TNode *cur = root;
    for (;;) {
        if (v < cur->val) {
            if (!cur->l) { cur->l = make(v); return; }
            cur = cur->l;
        } else {
            if (!cur->r) { cur->r = make(v); return; }
            cur = cur->r;
        }
    }
}
long sumtree(TNode *n) {
    if (!n) return 0;
    return n->val + sumtree(n->l) + sumtree(n->r);
}
void freetree(TNode *n) {
    if (!n) return;
    freetree(n->l); freetree(n->r); free(n);
}
int main(void) {
    TNode *root = make(500);
    int vals[] = {222,111,333,50,150,250,400,600,700,20,80};
    for (int i = 0; i < 11; i++) insert(root, vals[i]);
    printf("treesum=%ld\n", sumtree(root));
    freetree(root);
    return 0;
}
