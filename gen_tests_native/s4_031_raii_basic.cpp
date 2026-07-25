#include <cstdio>
struct Guard {
    int* counter;
    Guard(int* c) : counter(c) { (*counter)++; }
    ~Guard() { (*counter)--; }
};
int depth(int n, int* counter) {
    if (n <= 0) return *counter;
    Guard g(counter);
    return depth(n-1, counter);
}
int main(){
    int counter = 0;
    int maxseen = depth(7, &counter);
    printf("maxseen=%d after=%d\n", maxseen, counter);
    return 0;
}
