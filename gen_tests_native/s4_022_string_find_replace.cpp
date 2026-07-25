#include <string>
#include <cstdio>
int main(){
    std::string s = "the quick brown fox jumps over the lazy dog the end";
    size_t pos = 0, cnt=0;
    while ((pos = s.find("the", pos)) != std::string::npos) { cnt++; pos += 3; }
    std::string t = s.substr(4, 20);
    printf("count=%zu sub=%s len=%zu\n", cnt, t.c_str(), s.size());
    return 0;
}
