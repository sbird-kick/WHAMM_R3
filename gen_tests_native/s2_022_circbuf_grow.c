#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t cap = 32;
    int *buf = (int *)malloc(sizeof(int) * cap);
    size_t head = 0, count = 0;
    for (int i = 0; i < 300; i++) {
        if (count == cap) {
            size_t ncap = cap * 2;
            int *nb = (int *)malloc(sizeof(int) * ncap);
            for (size_t j = 0; j < count; j++) nb[j] = buf[(head + j) % cap];
            free(buf);
            buf = nb; cap = ncap; head = 0;
        }
        buf[(head + count) % cap] = i;
        count++;
    }
    long sum = 0;
    for (size_t j = 0; j < count; j++) sum += buf[(head + j) % cap];
    printf("sum=%ld cap=%zu\n", sum, cap);
    free(buf);
    return 0;
}
