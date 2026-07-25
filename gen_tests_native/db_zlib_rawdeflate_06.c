/* Raw (headerless) DEFLATE decode via tinfl, then verify checksum. Stream was
   produced by tdefl_compress_mem_to_mem on native miniz (see db_BUILD.txt). */
#include <stdio.h>
#include <stdint.h>
#include "miniz.h"

/* raw deflate of 240-byte "the quick brown fox " tiling; raw adler=78f757e5 */
static const unsigned char VEC[36] = {
  0xdd,0xc8,0xc1,0x09,0x00,0x20,0x08,0x05,0xd0,0x55,0xfe,0x6c,0x45,0x51,0x08,0x8a,
  0xa2,0xe8,0xf8,0xee,0xe1,0xf5,0xf9,0x3b,0xd0,0xf8,0x9b,0xb0,0x4c,0x92,0x71,0xa5,
  0xe0,0x83,0xad,0x01,
};

int main(void) {
    printf("start db_zlib_rawdeflate_06\n");
    static unsigned char out[512];
    /* flags = 0 -> raw deflate (no zlib header/adler) */
    size_t n = tinfl_decompress_mem_to_mem(out, sizeof(out), VEC, sizeof(VEC), 0);
    if (n == TINFL_DECOMPRESS_MEM_TO_MEM_FAILED) { printf("inflate FAILED\n"); return 1; }
    unsigned long a = mz_adler32(MZ_ADLER32_INIT, out, n);
    printf("out=%lu adler=%08lx match=%d\n",
           (unsigned long)n, a, (n == 240 && a == 0x78f757e5UL));
    return 0;
}
