#include <map>
#include <string>
#include <cstdio>
int main(){
    std::string text = "the fox jumps over the fox and the dog runs from the fox";
    std::map<std::string,int> counts;
    size_t start = 0;
    for (size_t i=0;i<=text.size();i++) {
        if (i==text.size() || text[i]==' ') {
            if (i>start) counts[text.substr(start,i-start)]++;
            start = i+1;
        }
    }
    long s=0;
    for (auto &p : counts) s = s*7 + p.second;
    printf("distinct=%zu s=%ld\n", counts.size(), s);
    return 0;
}
