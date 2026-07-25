#include <map>
#include <vector>
#include <string>
#include <algorithm>
#include <cstdio>
int main(){
    std::map<char, std::vector<std::string>> groups;
    std::vector<std::string> words = {"apple","ant","bear","bee","cat","car","dog","deer","ape"};
    for (auto &w : words) groups[w[0]].push_back(w);
    for (auto &p : groups) std::sort(p.second.begin(), p.second.end());
    long s=0;
    for (auto &p : groups) {
        s += p.first;
        for (auto &w : p.second) s += w.size();
    }
    printf("groups=%zu s=%ld\n", groups.size(), s);
    return 0;
}
