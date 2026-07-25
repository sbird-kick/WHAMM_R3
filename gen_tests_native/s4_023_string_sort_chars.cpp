#include <string>
#include <algorithm>
#include <cstdio>
int main(){
    std::string s = "the quick brown fox 444";
    std::sort(s.begin(), s.end());
    printf("sorted=%s\n", s.c_str());
    return 0;
}
