#include <stack>
#include <cstdio>
int main(){
    std::stack<int> st;
    for (int i=0;i<44;i+=4) st.push(i);
    long s=0;
    while (!st.empty()) { s = s*11 + st.top(); st.pop(); }
    printf("s=%ld\n", s);
    return 0;
}
