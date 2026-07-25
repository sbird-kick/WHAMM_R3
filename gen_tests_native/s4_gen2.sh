#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"
mk() { local name="$1"; cat > "${name}.cpp"; }

# ---------- 6. virtual dispatch ----------
mk s4_026_virtual_basic <<'EOF'
#include <cstdio>
struct Shape { virtual int area() const = 0; virtual ~Shape(){} };
struct Rect : Shape { int w,h; Rect(int w_,int h_):w(w_),h(h_){} int area() const override { return w*h; } };
struct Circ : Shape { int r; Circ(int r_):r(r_){} int area() const override { return 3*r*r; } };
int main(){
    Shape* shapes[4];
    Rect r1(4,7); Circ c1(5); Rect r2(9,2); Circ c2(3);
    shapes[0]=&r1; shapes[1]=&c1; shapes[2]=&r2; shapes[3]=&c2;
    long total=0;
    for (int i=0;i<4;i++) total += shapes[i]->area();
    printf("total=%ld\n", total);
    return 0;
}
EOF

mk s4_027_virtual_vector <<'EOF'
#include <vector>
#include <cstdio>
struct Animal { virtual int legs() const = 0; virtual ~Animal(){} };
struct Dog : Animal { int legs() const override { return 4; } };
struct Bird : Animal { int legs() const override { return 2; } };
struct Snake : Animal { int legs() const override { return 0; } };
int main(){
    std::vector<Animal*> v;
    Dog d1,d2; Bird b1; Snake s1; Dog d3; Bird b2;
    v.push_back(&d1); v.push_back(&b1); v.push_back(&s1);
    v.push_back(&d2); v.push_back(&b2); v.push_back(&d3);
    long total=0;
    for (auto a : v) total += a->legs();
    printf("total=%ld count=%zu\n", total, v.size());
    return 0;
}
EOF

mk s4_028_virtual_hierarchy <<'EOF'
#include <cstdio>
struct Base { virtual int val() const { return 1; } virtual ~Base(){} };
struct Mid : Base { int val() const override { return Base::val() + 10; } };
struct Leaf : Mid { int val() const override { return Mid::val() + 100; } };
int main(){
    Base b; Mid m; Leaf l;
    Base* arr[3] = {&b,&m,&l};
    long total=0;
    for (int i=0;i<3;i++) total += arr[i]->val();
    printf("total=%ld\n", total);
    return 0;
}
EOF

mk s4_029_virtual_indirect_calls <<'EOF'
#include <cstdio>
struct Op { virtual int apply(int x) const = 0; virtual ~Op(){} };
struct AddOp : Op { int n; AddOp(int n_):n(n_){} int apply(int x) const override { return x+n; } };
struct MulOp : Op { int n; MulOp(int n_):n(n_){} int apply(int x) const override { return x*n; } };
int compute(Op* ops[], int count, int start) {
    int v = start;
    for (int i=0;i<count;i++) v = ops[i]->apply(v);
    return v;
}
int main(){
    AddOp a1(4), a2(44); MulOp m1(3), m2(7);
    Op* ops[4] = {&a1,&m1,&a2,&m2};
    int r = compute(ops, 4, 2);
    printf("result=%d\n", r);
    return 0;
}
EOF

mk s4_030_virtual_dtor_order <<'EOF'
#include <cstdio>
static int seq = 0;
struct Base { int id; Base(int i):id(i){} virtual ~Base(){ seq = seq*10 + id; } };
struct Derived : Base { Derived(int i):Base(i){} ~Derived() override { seq = seq*10 + (id+1); } };
int main(){
    {
        Base* b = new Derived(1);
        delete b;
    }
    {
        Derived d(4);
    }
    printf("seq=%d\n", seq);
    return 0;
}
EOF

# ---------- 7. RAII ----------
mk s4_031_raii_basic <<'EOF'
#include <cstdio>
struct Guard {
    int* counter;
    Guard(int* c) : counter(c) { (*counter)++; }
    ~Guard() { (*counter)--; }
};
int depth(int n, int* counter) {
    if (n <= 0) return *counter;
    Guard g(counter);
    return depth(n-1, counter);
}
int main(){
    int counter = 0;
    int maxseen = depth(7, &counter);
    printf("maxseen=%d after=%d\n", maxseen, counter);
    return 0;
}
EOF

mk s4_032_raii_resource <<'EOF'
#include <cstdio>
#include <cstdlib>
struct Buffer {
    int* data;
    size_t n;
    Buffer(size_t n_) : n(n_) { data = (int*)malloc(n*sizeof(int)); for (size_t i=0;i<n;i++) data[i]=(int)i*3; }
    ~Buffer() { free(data); }
    long sum() const { long s=0; for (size_t i=0;i<n;i++) s+=data[i]; return s; }
};
int main(){
    long total = 0;
    for (int i=1;i<=5;i++) {
        Buffer buf(i*8);
        total += buf.sum();
    }
    printf("total=%ld\n", total);
    return 0;
}
EOF

mk s4_033_raii_vector_member <<'EOF'
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
EOF

mk s4_034_raii_unique_like <<'EOF'
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
EOF

mk s4_035_raii_scoped_multi <<'EOF'
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
EOF

echo "Generated part 2 (10 files)"
