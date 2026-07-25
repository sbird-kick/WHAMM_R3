/* Round-trip several distinct fixed buffers in one run: repetitive, ramp,
   and a short text. Prints per-buffer round-trip equality + crc. */
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "miniz.h"

static void trip(const char *tag, const unsigned char *src, unsigned n) {
    static unsigned char comp[1024];
    mz_ulong clen = sizeof(comp);
    int rc = mz_compress(comp, &clen, src, n);
    static unsigned char dec[512];
    mz_ulong dlen = sizeof(dec);
    int rc2 = mz_uncompress(dec, &dlen, comp, clen);
    int eq = (dlen == n) && (memcmp(src, dec, n) == 0);
    printf("%s n=%u rc=%d clen=%lu rc2=%d eq=%d crc=%08lx\n",
           tag, n, rc, (unsigned long)clen, rc2, eq,
           mz_crc32(MZ_CRC32_INIT, dec, dlen));
}

int main(void) {
    printf("start db_zlib_multibuf_08\n");
    static unsigned char rep[200];
    for (int i = 0; i < 200; i++) rep[i] = (unsigned char)(0x10 + (i % 3));
    trip("rep", rep, sizeof(rep));

    static unsigned char ramp[200];
    for (int i = 0; i < 200; i++) ramp[i] = (unsigned char)(i & 0xFF);
    trip("ramp", ramp, sizeof(ramp));

    static const char txt[] = "compression differential test buffer 0123456789 ABCDEF";
    trip("txt", (const unsigned char *)txt, (unsigned)sizeof(txt));
    return 0;
}
