#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_segment_parse_memcpy", 111);
    unsigned char stream[64];
    for (int i = 0; i < 64; i++) stream[i] = (unsigned char)(i + 11);
    int seg_sizes[4] = { 8, 16, 20, 20 };
    unsigned char out[64];
    int off = 0;
    for (int s = 0; s < 4; s++) {
        memcpy(out + off, stream + off, seg_sizes[s]);
        off += seg_sizes[s];
    }
    int ok = 1;
    for (int i = 0; i < 64; i++) if (out[i] != stream[i]) ok = 0;
    return !ok;
}
