// Exercises: malloc/free (memory.grow), array stores/loads,
// function calls with various signatures
#include <stdlib.h>
#include <string.h>

int sum_array(int *arr, int n) {
    int total = 0;
    for (int i = 0; i < n; i++) {
        total += arr[i];
    }
    return total;
}

void fill_array(int *arr, int n, int val) {
    for (int i = 0; i < n; i++) {
        arr[i] = val + i;
    }
}

int main() {
    int *buf = malloc(100 * sizeof(int));
    fill_array(buf, 100, 1);
    int s = sum_array(buf, 100);
    // s should be 5050
    buf[0] = s;
    free(buf);
    return buf[0] != 5050;
}
