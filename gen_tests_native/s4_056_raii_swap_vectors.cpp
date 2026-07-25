#include <vector>
#include <cstdio>
struct Container {
    std::vector<int> data;
    Container(int n, int base) { for (int i=0;i<n;i++) data.push_back(base+i); }
};
int main(){
    Container c1(5, 10);
    Container c2(8, 100);
    std::swap(c1.data, c2.data);
    long s=0;
    for (int x : c1.data) s += x;
    for (int x : c2.data) s -= x;
    printf("s=%ld sizes=%zu,%zu\n", s, c1.data.size(), c2.data.size());
    return 0;
}
