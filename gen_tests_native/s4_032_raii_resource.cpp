#include <cstdio>
#include <cstdlib>
struct Buffer {
    int* data;
    size_t n;
    Buffer(size_t n_) : n(n_) { data = (int*)malloc(n*sizeof(int)); for (size_t i=0;i<n;i++) data[i]=(int)i*3; }
    ~Buffer() { free(data); }
    long sum() const { long s=0; for (size_t i=0;i<n;i++) s+=data[i]; return s; }
};
int main(){
    long total = 0;
    for (int i=1;i<=5;i++) {
        Buffer buf(i*8);
        total += buf.sum();
    }
    printf("total=%ld\n", total);
    return 0;
}
