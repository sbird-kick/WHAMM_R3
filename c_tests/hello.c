// Simple: printf triggers WASI fd_write import calls
#include <stdio.h>

int main() {
    printf("Hello from WASI!\n");
    return 0;
}
