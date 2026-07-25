/* Checksum-only: exercise miniz adler32/crc32 incrementally over chunked
   buffers (no compression). Verifies streaming checksum == one-shot. */
#include <stdio.h>
#include <stdint.h>
#include "miniz.h"

int main(void) {
    printf("start db_zlib_checksums_07\n");
    static unsigned char buf[384];
    for (int i = 0; i < 384; i++) buf[i] = (unsigned char)((i * 37 + 11) & 0xFF);

    unsigned long a_one = mz_adler32(MZ_ADLER32_INIT, buf, sizeof(buf));
    unsigned long c_one = mz_crc32(MZ_CRC32_INIT, buf, sizeof(buf));

    /* incremental in 3 chunks */
    unsigned long a = MZ_ADLER32_INIT, c = MZ_CRC32_INIT;
    unsigned off = 0, chunks[3] = { 100, 140, 144 };
    for (int k = 0; k < 3; k++) {
        a = mz_adler32(a, buf + off, chunks[k]);
        c = mz_crc32(c, buf + off, chunks[k]);
        off += chunks[k];
    }
    printf("adler one=%08lx inc=%08lx eq=%d\n", a_one, a, (a_one == a));
    printf("crc   one=%08lx inc=%08lx eq=%d\n", c_one, c, (c_one == c));
    return 0;
}
