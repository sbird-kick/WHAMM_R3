#include <stdio.h>
#include <stdlib.h>
typedef struct { int id; long val; } Item;
int main(void) {
    size_t cap = 8, len = 0;
    Item *arr = (Item *)malloc(sizeof(Item) * cap);
    for (int i = 0; i < 222; i++) {
        if (len == cap) {
            cap += cap / 2 + 4;
            arr = (Item *)realloc(arr, sizeof(Item) * cap);
        }
        arr[len].id = i;
        arr[len].val = (long)i * i;
        len++;
    }
    long sum = 0;
    for (size_t i = 0; i < len; i++) sum += arr[i].val;
    printf("sum=%ld len=%zu cap=%zu\n", sum, len, cap);
    free(arr);
    return 0;
}
