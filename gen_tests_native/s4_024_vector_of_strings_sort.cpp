#include <vector>
#include <string>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<std::string> v = {"banana","apple","cherry","date","fig","apple","egg"};
    std::sort(v.begin(), v.end(), [](const std::string&a, const std::string&b){
        if (a.size() != b.size()) return a.size() < b.size();
        return a < b;
    });
    long s=0;
    for (auto &x : v) s = s*7 + x.size();
    printf("first=%s last=%s s=%ld\n", v.front().c_str(), v.back().c_str(), s);
    return 0;
}
