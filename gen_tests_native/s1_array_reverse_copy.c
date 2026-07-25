#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_array_reverse_copy", 111);
    int n = 12;
    int src[30], dst[30];
    for (int i = 0; i < n; i++) src[i] = i * 2 + 0;
    for (int i = 0; i < n; i++) memcpy(&dst[i], &src[n-1-i], sizeof(int));
    int ok = 1;
    for (int i = 0; i < n; i++) if (dst[i] != src[n-1-i]) ok = 0;
    return !ok;
}
