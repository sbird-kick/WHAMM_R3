#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"
mk() { local name="$1"; cat > "${name}.cpp"; }

mk s4_051_vector_erase_remove <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v;
    for (int i=0;i<44;i++) v.push_back(i);
    v.erase(std::remove_if(v.begin(), v.end(), [](int x){ return x%3==0; }), v.end());
    long s=0;
    for (int x : v) s = s*3+x;
    printf("size=%zu s=%ld\n", v.size(), s);
    return 0;
}
EOF

mk s4_052_map_accumulate <<'EOF'
#include <map>
#include <numeric>
#include <vector>
#include <cstdio>
int main(){
    std::map<int,int> m;
    for (int i=0;i<25;i++) m[i] = i*i % 44;
    std::vector<int> vals;
    for (auto &p : m) vals.push_back(p.second);
    long s = std::accumulate(vals.begin(), vals.end(), 0L);
    printf("s=%ld size=%zu\n", s, vals.size());
    return 0;
}
EOF

mk s4_053_virtual_recursive <<'EOF'
#include <cstdio>
struct Node { virtual int eval() const = 0; virtual ~Node(){} };
struct Leaf : Node { int v; Leaf(int v_):v(v_){} int eval() const override { return v; } };
struct Add : Node { Node *l,*r; Add(Node*a,Node*b):l(a),r(b){} int eval() const override { return l->eval()+r->eval(); } };
struct Mul : Node { Node *l,*r; Mul(Node*a,Node*b):l(a),r(b){} int eval() const override { return l->eval()*r->eval(); } };
int main(){
    Leaf a(4), b(7), c(3), d(9);
    Add s1(&a,&b);
    Mul m1(&c,&d);
    Add top(&s1,&m1);
    printf("result=%d\n", top.eval());
    return 0;
}
EOF

mk s4_054_umap_string_erase <<'EOF'
#include <unordered_map>
#include <string>
#include <cstdio>
int main(){
    std::unordered_map<std::string,int> m;
    const char* keys[] = {"a1","b2","c3","d4","e5","f6","g7","h8"};
    for (int i=0;i<8;i++) m[keys[i]] = i*i;
    m.erase("b2");
    m.erase("f6");
    long s=0;
    for (auto &p : m) s += p.second;
    printf("size=%zu s=%ld\n", m.size(), s);
    return 0;
}
EOF

mk s4_055_set_lower_upper_bound <<'EOF'
#include <set>
#include <cstdio>
int main(){
    std::set<int> s;
    for (int i=0;i<50;i+=3) s.insert(i);
    auto lo = s.lower_bound(20);
    auto hi = s.upper_bound(40);
    long total=0;
    int count=0;
    for (auto it=lo; it!=hi; ++it) { total += *it; count++; }
    printf("count=%d total=%ld\n", count, total);
    return 0;
}
EOF

mk s4_056_raii_swap_vectors <<'EOF'
#include <vector>
#include <cstdio>
struct Container {
    std::vector<int> data;
    Container(int n, int base) { for (int i=0;i<n;i++) data.push_back(base+i); }
};
int main(){
    Container c1(5, 10);
    Container c2(8, 100);
    std::swap(c1.data, c2.data);
    long s=0;
    for (int x : c1.data) s += x;
    for (int x : c2.data) s -= x;
    printf("s=%ld sizes=%zu,%zu\n", s, c1.data.size(), c2.data.size());
    return 0;
}
EOF

mk s4_057_vector_binary_search <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v;
    for (int i=0;i<44;i++) v.push_back(i*2);
    int found = 0;
    for (int q : {10, 21, 44, 87, 3}) {
        if (std::binary_search(v.begin(), v.end(), q)) found++;
    }
    auto it = std::lower_bound(v.begin(), v.end(), 50);
    printf("found=%d idx=%ld\n", found, (long)(it-v.begin()));
    return 0;
}
EOF

mk s4_058_multiset_virtual_combo <<'EOF'
#include <set>
#include <cstdio>
struct Ranker { virtual int rank(int x) const = 0; virtual ~Ranker(){} };
struct ModRank : Ranker { int m; ModRank(int m_):m(m_){} int rank(int x) const override { return x % m; } };
int main(){
    ModRank r(7);
    std::multiset<int> ms;
    int vals[] = {44,3,17,90,4,62,8,71,29,15,22};
    for (int v : vals) ms.insert(r.rank(v));
    long s=0;
    for (int x : ms) s = s*5+x;
    printf("s=%ld size=%zu\n", s, ms.size());
    return 0;
}
EOF

mk s4_059_deque_sort_and_string <<'EOF'
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
EOF

mk s4_060_map_virtual_raii_full <<'EOF'
#include <map>
#include <cstdio>
static long log = 0;
struct Task {
    virtual int run() const = 0;
    virtual ~Task() { log += 1000; }
};
struct TaskA : Task { int n; TaskA(int n_):n(n_){} int run() const override { return n*2; } };
struct TaskB : Task { int n; TaskB(int n_):n(n_){} int run() const override { return n+50; } };
int main(){
    {
        std::map<int, Task*> tasks;
        TaskA a1(4), a2(44);
        TaskB b1(7), b2(9);
        tasks[1] = &a1; tasks[2] = &b1; tasks[3] = &a2; tasks[4] = &b2;
        for (auto &p : tasks) log += p.second->run();
    }
    printf("log=%ld\n", log);
    return 0;
}
EOF

echo "Generated part 4 (10 files)"
