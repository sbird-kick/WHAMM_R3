// Many small allocations — stress-tests malloc/free and shadow memory tracking
#include <stdlib.h>

int main() {
    int *ptrs[1000];

    // Allocate 1000 small buffers
    for (int i = 0; i < 1000; i++) {
        ptrs[i] = malloc(sizeof(int) * 4);
        ptrs[i][0] = i;
        ptrs[i][1] = i * 2;
        ptrs[i][2] = i * 3;
        ptrs[i][3] = i * 4;
    }

    // Read them all back
    long total = 0;
    for (int i = 0; i < 1000; i++) {
        total += ptrs[i][0] + ptrs[i][1] + ptrs[i][2] + ptrs[i][3];
    }

    // Free in reverse
    for (int i = 999; i >= 0; i--) {
        free(ptrs[i]);
    }

    // total should be sum(i + 2i + 3i + 4i) = 10 * sum(i) = 10 * 999*500 = 4995000
    return total != 4995000;
}
