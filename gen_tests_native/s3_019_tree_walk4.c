#include <stdio.h>

static long walk_4(int node, int depth) {
    if (depth <= 0) return node % 13;
    long left = walk_4(node * 2 + 1, depth - 1);
    long right = walk_4(node * 2 + 2, depth - 1);
    int m = node % 6;
    switch (m) {
        case 0: return left + right + node;
        case 1: return left - right;
        case 2: return left ^ right;
        default: return (left + right) % 997;
    }
}

int main(void) {
    long total = 0;
    for (int r = 0; r < 4; r++) {
        total += walk_4(r + 1, 4);
    }
    printf("D4 total=%ld\n", total);
    return 0;
}
