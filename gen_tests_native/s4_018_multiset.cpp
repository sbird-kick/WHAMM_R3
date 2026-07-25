#include <set>
#include <cstdio>
int main(){
    std::multiset<int> ms;
    for (int i=0;i<20;i++) ms.insert(i%5);
    long s=0;
    for (int x : ms) s += x;
    printf("size=%zu s=%ld count3=%zu\n", ms.size(), s, ms.count(3));
    return 0;
}
