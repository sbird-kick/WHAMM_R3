#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"
mk() { local name="$1"; cat > "${name}.cpp"; }

# ---------- 8. priority_queue / deque / stack ----------
mk s4_036_priority_queue <<'EOF'
#include <queue>
#include <vector>
#include <cstdio>
int main(){
    std::priority_queue<int> pq;
    int seed=444;
    for (int i=0;i<20;i++){ seed=(seed*1103515245+12345)&0x7fffffff; pq.push(seed%100); }
    long s=0;
    while (!pq.empty()) { s = s*3 + pq.top(); pq.pop(); }
    printf("s=%ld\n", s);
    return 0;
}
EOF

mk s4_037_priority_queue_minheap <<'EOF'
#include <queue>
#include <vector>
#include <functional>
#include <cstdio>
int main(){
    std::priority_queue<int, std::vector<int>, std::greater<int>> pq;
    int vals[] = {44,3,17,90,4,62,8,71,29};
    for (int v : vals) pq.push(v);
    long s=0;
    while (!pq.empty()) { s = s*7 + pq.top(); pq.pop(); }
    printf("s=%ld\n", s);
    return 0;
}
EOF

mk s4_038_deque_ops <<'EOF'
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
EOF

mk s4_039_stack_ops <<'EOF'
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
EOF

mk s4_040_vector_of_pairs_sort <<'EOF'
#include <vector>
#include <utility>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<std::pair<int,int>> v;
    int seed = 444;
    for (int i=0;i<12;i++) {
        seed = (seed*1103515245+12345)&0x7fffffff;
        v.push_back({seed%30, i});
    }
    std::sort(v.begin(), v.end());
    long s=0;
    for (auto &p : v) s = s*17 + p.first*100+p.second;
    printf("s=%ld\n", s);
    return 0;
}
EOF

# ---------- 9. mixed / combos ----------
mk s4_041_map_of_vectors <<'EOF'
#include <map>
#include <vector>
#include <cstdio>
int main(){
    std::map<int,std::vector<int>> m;
    for (int i=0;i<30;i++) m[i%5].push_back(i);
    long s=0;
    for (auto &p : m) for (int x : p.second) s = s*3 + x;
    printf("s=%ld groups=%zu\n", s, m.size());
    return 0;
}
EOF

mk s4_042_vector_virtual_sort <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
struct Scorer { virtual int score(int x) const = 0; virtual ~Scorer(){} };
struct Neg : Scorer { int score(int x) const override { return -x; } };
struct Sqr : Scorer { int score(int x) const override { return x*x % 97; } };
int main(){
    std::vector<int> v{9,4,17,2,44,8,63,1,29};
    Neg neg; Sqr sqr;
    Scorer* s = (v.size() % 2 == 0) ? (Scorer*)&neg : (Scorer*)&sqr;
    std::sort(v.begin(), v.end(), [s](int a, int b){ return s->score(a) < s->score(b); });
    long sum=0;
    for (int x : v) sum = sum*13 + x;
    printf("sum=%ld\n", sum);
    return 0;
}
EOF

mk s4_043_set_of_strings <<'EOF'
#include <set>
#include <string>
#include <cstdio>
int main(){
    std::set<std::string> s;
    const char* words[] = {"delta","alpha","gamma","beta","alpha","epsilon","beta","zeta"};
    for (auto w : words) s.insert(w);
    long total=0;
    for (auto &w : s) total += w.size();
    printf("distinct=%zu total=%ld first=%s\n", s.size(), total, s.begin()->c_str());
    return 0;
}
EOF

mk s4_044_raii_map_cleanup <<'EOF'
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
EOF

mk s4_045_virtual_map_dispatch <<'EOF'
#include <map>
#include <string>
#include <cstdio>
struct Handler { virtual int handle(int x) const = 0; virtual ~Handler(){} };
struct Doubler : Handler { int handle(int x) const override { return x*2; } };
struct Squarer : Handler { int handle(int x) const override { return x*x; } };
struct Negator : Handler { int handle(int x) const override { return -x; } };
int main(){
    Doubler d; Squarer s; Negator n;
    std::map<std::string, Handler*> table = {{"double",&d},{"square",&s},{"neg",&n}};
    const char* seq[] = {"double","square","neg","double","neg"};
    int v = 3;
    for (auto name : seq) v = table[name]->handle(v);
    printf("v=%d\n", v);
    return 0;
}
EOF

mk s4_046_unordered_map_of_sets <<'EOF'
#include <unordered_map>
#include <set>
#include <cstdio>
int main(){
    std::unordered_map<int,std::set<int>> m;
    for (int i=0;i<40;i++) m[i%6].insert(i%13);
    long total=0;
    for (auto &p : m) {
        total += p.first;
        for (int x : p.second) total += x;
    }
    printf("total=%ld groups=%zu\n", total, m.size());
    return 0;
}
EOF

mk s4_047_string_map_count <<'EOF'
#include <map>
#include <string>
#include <cstdio>
int main(){
    std::string text = "the fox jumps over the fox and the dog runs from the fox";
    std::map<std::string,int> counts;
    size_t start = 0;
    for (size_t i=0;i<=text.size();i++) {
        if (i==text.size() || text[i]==' ') {
            if (i>start) counts[text.substr(start,i-start)]++;
            start = i+1;
        }
    }
    long s=0;
    for (auto &p : counts) s = s*7 + p.second;
    printf("distinct=%zu s=%ld\n", counts.size(), s);
    return 0;
}
EOF

mk s4_048_nested_vector_sort <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<std::vector<int>> vv;
    int seed = 444;
    for (int i=0;i<6;i++) {
        std::vector<int> row;
        for (int j=0;j<5;j++) { seed=(seed*1103515245+12345)&0x7fffffff; row.push_back(seed%50); }
        vv.push_back(row);
    }
    std::sort(vv.begin(), vv.end(), [](const std::vector<int>&a, const std::vector<int>&b){
        int sa=0, sb=0;
        for (int x : a) sa += x;
        for (int x : b) sb += x;
        return sa < sb;
    });
    long s=0;
    for (auto &row : vv) for (int x : row) s = s*5+x;
    printf("s=%ld\n", s);
    return 0;
}
EOF

mk s4_049_raii_virtual_combo <<'EOF'
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
EOF

mk s4_050_map_vector_string_combo <<'EOF'
#include <map>
#include <vector>
#include <string>
#include <algorithm>
#include <cstdio>
int main(){
    std::map<char, std::vector<std::string>> groups;
    std::vector<std::string> words = {"apple","ant","bear","bee","cat","car","dog","deer","ape"};
    for (auto &w : words) groups[w[0]].push_back(w);
    for (auto &p : groups) std::sort(p.second.begin(), p.second.end());
    long s=0;
    for (auto &p : groups) {
        s += p.first;
        for (auto &w : p.second) s += w.size();
    }
    printf("groups=%zu s=%ld\n", groups.size(), s);
    return 0;
}
EOF

echo "Generated part 3 (15 files)"
