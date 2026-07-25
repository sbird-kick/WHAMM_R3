#include <cstdio>
#include <cstdint>
template<typename T>
static T accum(const T* a, int n){
    T s = T(0);
    for (int i=0;i<n;i++) s = s + a[i]*T(3) - a[i>0?i-1:0];
    return s;
}
int main(){
    const int A[6] = {9808%97, 13, 21, 34, 55, 89};
    const int64_t B[5] = {9808, 4900, 3, -7, 42};
    const uint16_t C[4] = {1000, 2000, 3000, 9808%65535};
    int ra = accum<int>(A,6);
    int64_t rb = accum<int64_t>(B,5);
    unsigned rc = accum<uint16_t>(C,4);
    printf("ra=%d rb=%lld rc=%u\n", ra, (long long)rb, rc);
    return 0;
}
