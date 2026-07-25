#include <deque>
#include <algorithm>
#include <string>
#include <cstdio>
int main(){
    std::deque<std::string> dq = {"pear","fig","kiwi","plum","date","lime"};
    std::sort(dq.begin(), dq.end());
    std::string joined;
    for (auto &s : dq) joined += s + ",";
    printf("joined=%s\n", joined.c_str());
    return 0;
}
