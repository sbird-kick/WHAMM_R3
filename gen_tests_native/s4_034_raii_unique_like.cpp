#include <cstdio>
#include <utility>
struct Owner {
    int* p;
    explicit Owner(int v) { p = new int(v); }
    Owner(Owner&& o) noexcept : p(o.p) { o.p = nullptr; }
    Owner& operator=(Owner&& o) noexcept { if (this!=&o) { delete p; p=o.p; o.p=nullptr; } return *this; }
    Owner(const Owner&) = delete;
    ~Owner() { delete p; }
};
int main(){
    Owner a(44);
    Owner b(std::move(a));
    Owner c(7);
    c = std::move(b);
    printf("val=%d anull=%d\n", *c.p, a.p == nullptr);
    return 0;
}
