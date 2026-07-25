#include <vector>
#include <algorithm>
#include <cstdio>
struct Item { int key; int val; };
int main(){
    std::vector<Item> v = {{4,100},{1,200},{4,50},{2,300},{1,10},{3,7}};
    std::sort(v.begin(), v.end(), [](const Item&a,const Item&b){
        if (a.key != b.key) return a.key < b.key;
        return a.val < b.val;
    });
    long s=0;
    for (auto &it : v) s = s*13 + it.key*1000 + it.val;
    printf("s=%ld\n", s);
    return 0;
}
