/* miniz round-trip: repetitive buffer, print checksums + equality flag. */
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "miniz.h"

int main(void) {
    printf("start db_zlib_roundtrip_01\n");

    /* Deterministic repetitive source buffer. */
    static unsigned char src[512];
    for (int i = 0; i < 512; i++) src[i] = (unsigned char)('A' + (i % 7));

    unsigned long adler_src = mz_adler32(MZ_ADLER32_INIT, src, sizeof(src));
    unsigned long crc_src   = mz_crc32(MZ_CRC32_INIT, src, sizeof(src));
    printf("src adler=%08lx crc=%08lx\n", adler_src, crc_src);

    static unsigned char comp[1024];
    mz_ulong comp_len = sizeof(comp);
    int rc = mz_compress(comp, &comp_len, src, sizeof(src));
    printf("compress rc=%d clen=%lu\n", rc, (unsigned long)comp_len);

    static unsigned char decomp[512];
    mz_ulong decomp_len = sizeof(decomp);
    int rc2 = mz_uncompress(decomp, &decomp_len, comp, comp_len);
    printf("uncompress rc=%d dlen=%lu\n", rc2, (unsigned long)decomp_len);

    int eq = (decomp_len == sizeof(src)) && (memcmp(src, decomp, sizeof(src)) == 0);
    unsigned long adler_dec = mz_adler32(MZ_ADLER32_INIT, decomp, decomp_len);
    printf("roundtrip eq=%d adler=%08lx\n", eq, adler_dec);
    return 0;
}
