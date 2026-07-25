#include <cstdio>
#include <functional>
struct State { long acc=9808; };
int main(){
  State st;
  std::function<void(int)> step;
  step=[&](int n){ if(n<=0) return; st.acc = (st.acc*31 + n) % 1000000007; step(n-1); };
  step(50);
  printf("%ld\n", st.acc);
  return 0;
}
