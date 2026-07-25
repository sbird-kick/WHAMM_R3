/* miniz round-trip on a constant (incompressible-shaped) array, plus an
   alternating high-entropy-ish pattern. Verifies round-trip on data that
   deflate stores rather than shrinks. */
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "miniz.h"

static void trip(const char *tag, const unsigned char *src, unsigned n) {
    static unsigned char comp[2048];
    mz_ulong clen = sizeof(comp);
    int rc = mz_compress(comp, &clen, src, n);
    static unsigned char dec[1024];
    mz_ulong dlen = sizeof(dec);
    int rc2 = mz_uncompress(dec, &dlen, comp, clen);
    int eq = (dlen == n) && (memcmp(src, dec, n) == 0);
    printf("%s rc=%d clen=%lu grew=%d rc2=%d eq=%d crc=%08lx\n",
           tag, rc, (unsigned long)clen, (clen > n), rc2, eq,
           mz_crc32(MZ_CRC32_INIT, dec, dlen));
}

int main(void) {
    printf("start db_zlib_incompressible_03\n");
    static unsigned char constbuf[300];
    for (int i = 0; i < 300; i++) constbuf[i] = 0x5A;
    trip("const", constbuf, sizeof(constbuf));

    static unsigned char altbuf[300];
    for (int i = 0; i < 300; i++) altbuf[i] = (unsigned char)((i * 131 + 7) ^ (i >> 1));
    trip("alt", altbuf, sizeof(altbuf));
    return 0;
}
