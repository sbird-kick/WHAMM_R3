#include <map>
#include <cstdio>
int main(){
    std::map<std::string,int> m = {{"apple",4},{"banana",44},{"cherry",17},{"date",9}};
    int total=0;
    const char* keys[] = {"banana","fig","apple","cherry"};
    for (auto k : keys) {
        auto it = m.find(k);
        if (it != m.end()) total += it->second;
        else total -= 1;
    }
    printf("total=%d size=%zu\n", total, m.size());
    return 0;
}
