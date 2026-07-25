#include <string>
#include <cstdio>
int main(){
    std::string s = "seed";
    for (int i=0;i<44;i++) s += std::to_string(i%10);
    printf("len=%zu s0=%c sN=%c\n", s.size(), s[0], s.back());
    return 0;
}
