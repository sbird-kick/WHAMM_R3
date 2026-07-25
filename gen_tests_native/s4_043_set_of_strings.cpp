#include <set>
#include <string>
#include <cstdio>
int main(){
    std::set<std::string> s;
    const char* words[] = {"delta","alpha","gamma","beta","alpha","epsilon","beta","zeta"};
    for (auto w : words) s.insert(w);
    long total=0;
    for (auto &w : s) total += w.size();
    printf("distinct=%zu total=%ld first=%s\n", s.size(), total, s.begin()->c_str());
    return 0;
}
