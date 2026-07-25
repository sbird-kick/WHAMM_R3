#include <cstdio>
static long trace = 0;
struct Scoped {
    int id;
    Scoped(int i) : id(i) { trace = trace*100 + id; }
    ~Scoped() { trace = trace*100 + (id+50); }
};
int main(){
    trace = 1;
    {
        Scoped a(1);
        {
            Scoped b(2);
            Scoped c(3);
        }
        Scoped d(4);
    }
    printf("trace=%ld\n", trace);
    return 0;
}
