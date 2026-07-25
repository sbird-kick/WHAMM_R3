#include <set>
#include <cstdio>
int main(){
    std::set<int> s;
    for (int i=0;i<30;i++) s.insert((i*17+3) % 40);
    long total=0;
    for (int x : s) total = total*3 + x;
    printf("size=%zu total=%ld\n", s.size(), total);
    return 0;
}
