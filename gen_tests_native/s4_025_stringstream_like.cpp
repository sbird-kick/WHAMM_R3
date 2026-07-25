#include <string>
#include <cstdio>
int main(){
    std::string parts[] = {"alpha","beta","gamma","delta","epsilon"};
    std::string joined;
    for (int i=0;i<5;i++) {
        if (i) joined += "-";
        joined += parts[i];
    }
    joined += std::to_string(444);
    printf("joined=%s len=%zu\n", joined.c_str(), joined.size());
    return 0;
}
