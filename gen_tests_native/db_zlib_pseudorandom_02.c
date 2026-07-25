/* miniz round-trip on a pseudo-random (fixed LCG seed) buffer. */
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "miniz.h"

int main(void) {
    printf("start db_zlib_pseudorandom_02\n");
    static unsigned char src[256];
    unsigned int s = 0x1234567u;
    for (int i = 0; i < 256; i++) { s = s * 1103515245u + 12345u; src[i] = (unsigned char)(s >> 16); }

    unsigned long a0 = mz_adler32(MZ_ADLER32_INIT, src, sizeof(src));
    unsigned long c0 = mz_crc32(MZ_CRC32_INIT, src, sizeof(src));
    printf("src adler=%08lx crc=%08lx\n", a0, c0);

    static unsigned char comp[1024];
    mz_ulong clen = sizeof(comp);
    int rc = mz_compress(comp, &clen, src, sizeof(src));
    printf("compress rc=%d clen=%lu\n", rc, (unsigned long)clen);

    static unsigned char dec[256];
    mz_ulong dlen = sizeof(dec);
    int rc2 = mz_uncompress(dec, &dlen, comp, clen);
    int eq = (dlen == sizeof(src)) && (memcmp(src, dec, sizeof(src)) == 0);
    printf("uncompress rc=%d dlen=%lu eq=%d adler=%08lx\n",
           rc2, (unsigned long)dlen, eq, mz_adler32(MZ_ADLER32_INIT, dec, dlen));
    return 0;
}
