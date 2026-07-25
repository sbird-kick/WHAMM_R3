#include <stdio.h>

#include <string.h>
typedef struct { int val; int left; int right; } TNode;
int main() {
    printf("start %s %d\n", "s1_array_tree_copy", 111);
    TNode tree[7];
    for (int i = 0; i < 7; i++) { tree[i].val = i * 2; tree[i].left = 2*i+1 < 7 ? 2*i+1 : -1; tree[i].right = 2*i+2 < 7 ? 2*i+2 : -1; }
    TNode copy[7];
    memcpy(copy, tree, sizeof(tree));
    int sum = 0;
    for (int i = 0; i < 7; i++) sum += copy[i].val;
    int expect = 0;
    for (int i = 0; i < 7; i++) expect += i * (2);
    return !(sum == expect);
}
