// Structs with mixed types — exercises various load/store sizes
#include <string.h>

struct Point { float x; float y; };
struct Rect { struct Point origin; struct Point size; };

float area(struct Rect *r) {
    return r->size.x * r->size.y;
}

struct Rect make_rect(float x, float y, float w, float h) {
    struct Rect r;
    r.origin.x = x; r.origin.y = y;
    r.size.x = w; r.size.y = h;
    return r;
}

int main() {
    struct Rect rects[4];
    for (int i = 0; i < 4; i++) {
        rects[i] = make_rect(i * 1.0f, i * 2.0f, (i + 1) * 3.0f, (i + 1) * 4.0f);
    }
    float total = 0;
    for (int i = 0; i < 4; i++) {
        total += area(&rects[i]);
    }
    // 3*4 + 6*8 + 9*12 + 12*16 = 12+48+108+192 = 360
    return (int)total != 360;
}
