#!/usr/bin/env bash
# Generator for s4_ theme tests (STL containers, sort, virtual dispatch, RAII)
# SEED=444
set -u
cd "$(dirname "$0")"

W() { # W <name> ; content comes via heredoc redirected by caller
  :
}

mk() {
  local name="$1"
  cat > "${name}.cpp"
}

# ---------- 1. vector + custom comparator sort ----------
mk s4_001_vec_sort_asc <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v{44,4,17,90,3,62,8,71,29,15};
    std::sort(v.begin(), v.end(), [](int a,int b){return a<b;});
    long s=0; for(int x: v) s = s*31+x;
    printf("sum=%ld first=%d last=%d\n", s, v.front(), v.back());
    return 0;
}
EOF

mk s4_002_vec_sort_desc <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
struct Cmp { bool operator()(int a,int b) const { return a>b; } };
int main(){
    std::vector<int> v{5,44,12,9,63,21,8,77,1,40,4};
    std::sort(v.begin(), v.end(), Cmp());
    long s=0; for(int x: v) s = s*17+x;
    printf("s=%ld top=%d\n", s, v[0]);
    return 0;
}
EOF

mk s4_003_vec_struct_sort <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
struct Item { int key; int val; };
int main(){
    std::vector<Item> v = {{4,100},{1,200},{4,50},{2,300},{1,10},{3,7}};
    std::sort(v.begin(), v.end(), [](const Item&a,const Item&b){
        if (a.key != b.key) return a.key < b.key;
        return a.val < b.val;
    });
    long s=0;
    for (auto &it : v) s = s*13 + it.key*1000 + it.val;
    printf("s=%ld\n", s);
    return 0;
}
EOF

mk s4_004_vec_stable_sort <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v{9,4,4,4,2,2,7,7,1,3,3};
    std::stable_sort(v.begin(), v.end());
    long s=0; for(size_t i=0;i<v.size();++i) s += v[i]*(long)(i+1);
    printf("s=%ld\n", s);
    return 0;
}
EOF

mk s4_005_vec_partial_sort <<'EOF'
#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v{55,12,88,3,44,29,6,71,18,90,2,63};
    std::partial_sort(v.begin(), v.begin()+4, v.end());
    long s=0; for(int x: v) s = s*7+x;
    printf("s=%ld\n", s);
    return 0;
}
EOF

# ---------- 2. std::map ----------
mk s4_006_map_insert_iter <<'EOF'
#include <map>
#include <cstdio>
int main(){
    std::map<int,int> m;
    int seed = 444;
    for (int i=0;i<20;i++){
        seed = (seed*1103515245 + 12345) & 0x7fffffff;
        m[seed % 50] += (seed % 7) + 1;
    }
    long s=0;
    for (auto &p : m) s = s*3 + p.first*10 + p.second;
    printf("size=%zu s=%ld\n", m.size(), s);
    return 0;
}
EOF

mk s4_007_map_erase <<'EOF'
#include <map>
#include <cstdio>
int main(){
    std::map<int,std::string> m;
    m[3]="three"; m[1]="one"; m[4]="four"; m[1]="ONE"; m[5]="five"; m[9]="nine";
    m.erase(4);
    m.erase(1);
    long s=0;
    for (auto &p : m) { s = s*13 + p.first; s += p.second.size(); }
    printf("size=%zu s=%ld\n", m.size(), s);
    return 0;
}
EOF

mk s4_008_map_find <<'EOF'
#include <map>
#include <cstdio>
int main(){
    std::map<std::string,int> m = {{"apple",4},{"banana",44},{"cherry",17},{"date",9}};
    int total=0;
    const char* keys[] = {"banana","fig","apple","cherry"};
    for (auto k : keys) {
        auto it = m.find(k);
        if (it != m.end()) total += it->second;
        else total -= 1;
    }
    printf("total=%d size=%zu\n", total, m.size());
    return 0;
}
EOF

mk s4_009_multimap <<'EOF'
#include <map>
#include <cstdio>
int main(){
    std::multimap<int,int> mm;
    mm.insert({1,10}); mm.insert({1,20}); mm.insert({2,30}); mm.insert({1,40}); mm.insert({3,50});
    long s=0;
    auto range = mm.equal_range(1);
    for (auto it=range.first; it!=range.second; ++it) s += it->second;
    printf("s=%ld count=%zu\n", s, mm.count(1));
    return 0;
}
EOF

mk s4_010_map_reverse_iter <<'EOF'
#include <map>
#include <cstdio>
int main(){
    std::map<int,int,std::greater<int>> m;
    for (int i=0;i<15;i++) m[i*3+444%7] = i*i;
    long s=0;
    for (auto it = m.rbegin(); it != m.rend(); ++it) s = s*5 + it->first + it->second;
    printf("s=%ld\n", s);
    return 0;
}
EOF

# ---------- 3. unordered_map ----------
mk s4_011_umap_basic <<'EOF'
#include <unordered_map>
#include <cstdio>
int main(){
    std::unordered_map<int,int> m;
    for (int i=0;i<44;i++) m[i] = (i*7) % 41;
    long s=0;
    for (int i=0;i<44;i++) s += m[i];
    printf("s=%ld size=%zu\n", s, m.size());
    return 0;
}
EOF

mk s4_012_umap_string_key <<'EOF'
#include <unordered_map>
#include <string>
#include <cstdio>
int main(){
    std::unordered_map<std::string,int> m;
    const char* words[] = {"the","quick","brown","fox","the","lazy","dog","fox","the"};
    for (auto w : words) m[w]++;
    int total = 0;
    for (auto &p : m) total += p.second * (int)p.first.size();
    printf("total=%d distinct=%zu\n", total, m.size());
    return 0;
}
EOF

mk s4_013_umap_erase <<'EOF'
#include <unordered_map>
#include <cstdio>
int main(){
    std::unordered_map<int,long> m;
    for (int i=0;i<30;i++) m[i] = i*i;
    for (int i=0;i<30;i+=3) m.erase(i);
    long s=0;
    for (auto &p : m) s += p.second;
    printf("s=%ld size=%zu\n", s, m.size());
    return 0;
}
EOF

mk s4_014_unordered_set <<'EOF'
#include <unordered_set>
#include <cstdio>
int main(){
    std::unordered_set<int> s;
    int seed=444;
    for (int i=0;i<40;i++){
        seed = (seed*1103515245+12345)&0x7fffffff;
        s.insert(seed % 25);
    }
    long total=0;
    for (int x : s) total += x;
    printf("size=%zu total=%ld\n", s.size(), total);
    return 0;
}
EOF

mk s4_015_umap_bucket_stress <<'EOF'
#include <unordered_map>
#include <cstdio>
int main(){
    std::unordered_map<long,long> m;
    m.reserve(8);
    for (long i=0;i<60;i++) m[i*13 % 97] += i;
    long s=0;
    for (auto &p : m) s += p.first + p.second;
    printf("s=%ld size=%zu\n", s, m.size());
    return 0;
}
EOF

# ---------- 4. set ----------
mk s4_016_set_basic <<'EOF'
#include <set>
#include <cstdio>
int main(){
    std::set<int> s;
    for (int i=0;i<30;i++) s.insert((i*17+3) % 40);
    long total=0;
    for (int x : s) total = total*3 + x;
    printf("size=%zu total=%ld\n", s.size(), total);
    return 0;
}
EOF

mk s4_017_set_intersection <<'EOF'
#include <set>
#include <algorithm>
#include <iterator>
#include <vector>
#include <cstdio>
int main(){
    std::set<int> a = {2,4,6,8,10,12,14,16,18,20};
    std::set<int> b = {4,8,12,16,20,24,28};
    std::vector<int> out;
    std::set_intersection(a.begin(),a.end(),b.begin(),b.end(),std::back_inserter(out));
    long s=0; for(int x: out) s = s*5+x;
    printf("count=%zu s=%ld\n", out.size(), s);
    return 0;
}
EOF

mk s4_018_multiset <<'EOF'
#include <set>
#include <cstdio>
int main(){
    std::multiset<int> ms;
    for (int i=0;i<20;i++) ms.insert(i%5);
    long s=0;
    for (int x : ms) s += x;
    printf("size=%zu s=%ld count3=%zu\n", ms.size(), s, ms.count(3));
    return 0;
}
EOF

mk s4_019_set_custom_cmp <<'EOF'
#include <set>
#include <cstdio>
struct ByAbsMod { bool operator()(int a,int b) const { return (a%7) < (b%7) || ((a%7)==(b%7)&&a<b); } };
int main(){
    std::set<int,ByAbsMod> s;
    int vals[] = {14,3,21,8,44,10,17,29,5,63};
    for (int v : vals) s.insert(v);
    long total=0;
    for (int x : s) total = total*11 + x;
    printf("size=%zu total=%ld\n", s.size(), total);
    return 0;
}
EOF

mk s4_020_set_diff_union <<'EOF'
#include <set>
#include <algorithm>
#include <iterator>
#include <vector>
#include <cstdio>
int main(){
    std::set<int> a = {1,3,5,7,9,11,13};
    std::set<int> b = {3,7,11,15,19};
    std::vector<int> d, u;
    std::set_difference(a.begin(),a.end(),b.begin(),b.end(),std::back_inserter(d));
    std::set_union(a.begin(),a.end(),b.begin(),b.end(),std::back_inserter(u));
    printf("diff=%zu union=%zu\n", d.size(), u.size());
    return 0;
}
EOF

# ---------- 5. string ----------
mk s4_021_string_concat <<'EOF'
#include <string>
#include <cstdio>
int main(){
    std::string s = "seed";
    for (int i=0;i<44;i++) s += std::to_string(i%10);
    printf("len=%zu s0=%c sN=%c\n", s.size(), s[0], s.back());
    return 0;
}
EOF

mk s4_022_string_find_replace <<'EOF'
#include <string>
#include <cstdio>
int main(){
    std::string s = "the quick brown fox jumps over the lazy dog the end";
    size_t pos = 0, cnt=0;
    while ((pos = s.find("the", pos)) != std::string::npos) { cnt++; pos += 3; }
    std::string t = s.substr(4, 20);
    printf("count=%zu sub=%s len=%zu\n", cnt, t.c_str(), s.size());
    return 0;
}
EOF

mk s4_023_string_sort_chars <<'EOF'
#include <string>
#include <algorithm>
#include <cstdio>
int main(){
    std::string s = "the quick brown fox 444";
    std::sort(s.begin(), s.end());
    printf("sorted=%s\n", s.c_str());
    return 0;
}
EOF

mk s4_024_vector_of_strings_sort <<'EOF'
#include <vector>
#include <string>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<std::string> v = {"banana","apple","cherry","date","fig","apple","egg"};
    std::sort(v.begin(), v.end(), [](const std::string&a, const std::string&b){
        if (a.size() != b.size()) return a.size() < b.size();
        return a < b;
    });
    long s=0;
    for (auto &x : v) s = s*7 + x.size();
    printf("first=%s last=%s s=%ld\n", v.front().c_str(), v.back().c_str(), s);
    return 0;
}
EOF

mk s4_025_stringstream_like <<'EOF'
#include <string>
#include <cstdio>
int main(){
    std::string parts[] = {"alpha","beta","gamma","delta","epsilon"};
    std::string joined;
    for (int i=0;i<5;i++) {
        if (i) joined += "-";
        joined += parts[i];
    }
    joined += std::to_string(444);
    printf("joined=%s len=%zu\n", joined.c_str(), joined.size());
    return 0;
}
EOF

echo "Generated 25 files (part 1)"
