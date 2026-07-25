#include <stdio.h>

#include <stdlib.h>
typedef struct { int key; int payload; } Item;
int main() {
    printf("start %s %d\n", "s1_struct_bubble_sort", 111);
    int n = 10;
    Item *arr = malloc(n * sizeof(Item));
    if (!arr) return 1;
    for (int i = 0; i < n; i++) { arr[i].key = (n - i) * 1; arr[i].payload = i; }
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - 1 - i; j++)
            if (arr[j].key > arr[j+1].key) {
                Item t = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = t;
            }
    int ok = 1;
    for (int i = 0; i < n - 1; i++) if (arr[i].key > arr[i+1].key) ok = 0;
    free(arr);
    return !ok;
}
