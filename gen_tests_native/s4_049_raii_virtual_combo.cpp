#include <vector>
#include <cstdio>
struct Resource {
    virtual int use() const = 0;
    virtual ~Resource() {}
};
struct FileLike : Resource {
    int* handle;
    FileLike(int v) { handle = new int(v); }
    ~FileLike() override { delete handle; }
    int use() const override { return *handle * 2; }
};
struct MemLike : Resource {
    int val;
    MemLike(int v):val(v){}
    int use() const override { return val + 1000; }
};
int main(){
    long total = 0;
    {
        std::vector<Resource*> rs;
        FileLike f1(4), f2(44);
        MemLike m1(7), m2(9);
        rs.push_back(&f1); rs.push_back(&m1); rs.push_back(&f2); rs.push_back(&m2);
        for (auto r : rs) total += r->use();
    }
    printf("total=%ld\n", total);
    return 0;
}
