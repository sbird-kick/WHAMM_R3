// Exercises data segment initialization — globals, string literals, static arrays
// These all live in data segments and must be correctly shadowed
#include <string.h>

static int lookup_table[8] = { 1, 1, 2, 3, 5, 8, 13, 21 };
static const char greeting[] = "Hello, shadow memory!";
static double constants[] = { 3.14159, 2.71828, 1.41421 };

int sum_lookup(void) {
    int total = 0;
    for (int i = 0; i < 8; i++) total += lookup_table[i];
    return total;
}

int greeting_len(void) {
    return strlen(greeting);
}

int check_constants(void) {
    // Just read them to generate load events
    double sum = 0;
    for (int i = 0; i < 3; i++) sum += constants[i];
    return sum > 7.0 ? 1 : 0;
}

int main() {
    int a = sum_lookup();       // 54
    int b = greeting_len();     // 21
    int c = check_constants();  // 1
    return (a != 54) || (b != 21) || (c != 1);
}
