#include <map>
#include <cstdio>
static long trace = 0;
struct Tracked {
    int id;
    Tracked(int i=0):id(i){ trace += id; }
    Tracked(const Tracked& o):id(o.id){ trace += id*2; }
    ~Tracked(){ trace -= id; }
};
int main(){
    {
        std::map<int,Tracked> m;
        for (int i=1;i<=6;i++) m[i] = Tracked(i);
    }
    printf("trace=%ld\n", trace);
    return 0;
}
