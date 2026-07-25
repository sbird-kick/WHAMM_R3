/* miniz compress at several levels; verify each round-trips and print sizes. */
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "miniz.h"

int main(void) {
    printf("start db_zlib_levels_04\n");
    static unsigned char src[400];
    for (int i = 0; i < 400; i++) src[i] = (unsigned char)('a' + ((i / 4) % 6));

    unsigned long a0 = mz_adler32(MZ_ADLER32_INIT, src, sizeof(src));
    printf("src adler=%08lx\n", a0);

    int levels[3] = { 1, 6, 9 };
    for (int k = 0; k < 3; k++) {
        static unsigned char comp[1024];
        mz_ulong clen = sizeof(comp);
        int rc = mz_compress2(comp, &clen, src, sizeof(src), levels[k]);
        static unsigned char dec[400];
        mz_ulong dlen = sizeof(dec);
        int rc2 = mz_uncompress(dec, &dlen, comp, clen);
        int eq = (dlen == sizeof(src)) && (memcmp(src, dec, sizeof(src)) == 0);
        printf("lvl=%d rc=%d clen=%lu rc2=%d eq=%d\n",
               levels[k], rc, (unsigned long)clen, rc2, eq);
    }
    return 0;
}
