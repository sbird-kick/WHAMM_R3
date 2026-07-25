#include <map>
#include <cstdio>
int main(){
    std::map<int,std::string> m;
    m[3]="three"; m[1]="one"; m[4]="four"; m[1]="ONE"; m[5]="five"; m[9]="nine";
    m.erase(4);
    m.erase(1);
    long s=0;
    for (auto &p : m) { s = s*13 + p.first; s += p.second.size(); }
    printf("size=%zu s=%ld\n", m.size(), s);
    return 0;
}
