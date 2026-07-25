#include <vector>
#include <cstdio>
struct Log {
    std::vector<int>* trace;
    int id;
    Log(std::vector<int>* t, int i) : trace(t), id(i) { trace->push_back(id*10+1); }
    ~Log() { trace->push_back(id*10+9); }
};
void work(std::vector<int>* trace, int id) {
    Log l(trace, id);
    if (id > 0) work(trace, id-1);
}
int main(){
    std::vector<int> trace;
    work(&trace, 4);
    long s=0;
    for (int x : trace) s = s*13 + x;
    printf("size=%zu s=%ld\n", trace.size(), s);
    return 0;
}
