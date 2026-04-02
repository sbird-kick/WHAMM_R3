// Recursive function calls — deep call stacks exercise call_depth tracking
#include <stdio.h>

int fib(int n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}

int main() {
    for (int i = 0; i < 15; i++) {
        printf("fib(%d) = %d\n", i, fib(i));
    }
    return 0;
}
