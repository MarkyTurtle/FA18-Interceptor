// dump: writes each track of an IPF disk image as raw MFM, tNNN.bin = the track's length in
// bits (4 bytes, little-endian) then its bits, from the index; uses the SPS / CAPS decoder
// library (capsimg). Built by build_dump.sh.   dump GAME.ipf OUTDIR
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "CommonTypes.h"
#include "CapsAPI.h"
#include "CapsFDC.h"
#include "CapsLib.h"

int main(int argc, char **argv) {
    if (argc != 3) { fprintf(stderr, "usage: dump GAME.ipf OUTDIR\n"); return 2; }
    CAPSInit();
    SDWORD id = CAPSAddImage();
    if (CAPSLockImage(id, argv[1])) { fprintf(stderr, "%s: cannot open\n", argv[1]); return 1; }
    struct CapsImageInfo ii;
    CAPSGetImageInfo(&ii, id);
    printf("cylinders %u-%u, heads %u-%u\n", ii.mincylinder, ii.maxcylinder, ii.minhead, ii.maxhead);
    CAPSLoadImage(id, DI_LOCK_DENVAR | DI_LOCK_INDEX);
    for (UDWORD c = ii.mincylinder; c <= ii.maxcylinder; c++)
        for (UDWORD h = ii.minhead; h <= ii.maxhead; h++) {
            struct CapsTrackInfoT2 ti;
            memset(&ti, 0, sizeof ti);
            ti.type = 2;
            if (CAPSLockTrack((PCAPSTRACKINFO)&ti, id, c, h, DI_LOCK_INDEX | DI_LOCK_TYPE | DI_LOCK_TRKBIT)) {
                printf("track %u: error\n", c * 2 + h);
                continue;
            }
            char fn[1024];
            snprintf(fn, sizeof fn, "%s/t%03u.bin", argv[2], c * 2 + h);
            FILE *f = fopen(fn, "wb");
            UDWORD bits = ti.tracklen;
            fwrite(&bits, 4, 1, f);
            if (ti.trackbuf) fwrite(ti.trackbuf, 1, (bits + 7) / 8, f);
            fclose(f);
            printf("track %3u: %u bits, %u weak areas\n", c * 2 + h, bits, ti.weakcnt);
            CAPSUnlockTrack(id, c, h);
        }
    return 0;
}
