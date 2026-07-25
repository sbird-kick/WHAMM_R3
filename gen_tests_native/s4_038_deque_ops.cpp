#include <deque>
#include <cstdio>
int main(){
    std::deque<int> dq;
    for (int i=0;i<15;i++) {
        if (i%2==0) dq.push_back(i);
        else dq.push_front(i*2);
    }
    long s=0;
    for (int x : dq) s = s*5 + x;
    printf("s=%ld front=%d back=%d\n", s, dq.front(), dq.back());
    return 0;
}
