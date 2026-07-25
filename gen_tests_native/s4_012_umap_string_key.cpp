#include <unordered_map>
#include <string>
#include <cstdio>
int main(){
    std::unordered_map<std::string,int> m;
    const char* words[] = {"the","quick","brown","fox","the","lazy","dog","fox","the"};
    for (auto w : words) m[w]++;
    int total = 0;
    for (auto &p : m) total += p.second * (int)p.first.size();
    printf("total=%d distinct=%zu\n", total, m.size());
    return 0;
}
