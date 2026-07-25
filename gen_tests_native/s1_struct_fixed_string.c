#include <stdio.h>

#include <string.h>
typedef struct { char name[16]; int id; } Entry;
int main() {
    printf("start %s %d\n", "s1_struct_fixed_string", 111);
    Entry e;
    memset(&e, 0, sizeof(e));
    strncpy(e.name, "entry111", 15);
    e.id = 111;
    Entry copy = e;
    int ok = (strcmp(copy.name, e.name) == 0) && (copy.id == e.id);
    return !ok;
}
