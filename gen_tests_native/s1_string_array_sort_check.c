#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_string_array_sort_check", 111);
    char words[4][12] = { "delta", "alpha", "charlie", "bravo" };
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3 - i; j++)
            if (strcmp(words[j], words[j+1]) > 0) {
                char tmp[12];
                memcpy(tmp, words[j], 12);
                memcpy(words[j], words[j+1], 12);
                memcpy(words[j+1], tmp, 12);
            }
    return !(strcmp(words[0], "alpha") == 0 && strcmp(words[3], "delta") == 0);
}
