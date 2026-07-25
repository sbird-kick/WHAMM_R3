#include <unordered_map>
#include <string>
#include <cstdio>
int main(){
    std::unordered_map<std::string,int> m;
    const char* keys[] = {"a1","b2","c3","d4","e5","f6","g7","h8"};
    for (int i=0;i<8;i++) m[keys[i]] = i*i;
    m.erase("b2");
    m.erase("f6");
    long s=0;
    for (auto &p : m) s += p.second;
    printf("size=%zu s=%ld\n", m.size(), s);
    return 0;
}
