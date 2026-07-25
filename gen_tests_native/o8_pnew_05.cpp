#include <cstdio>
#include <new>
template<int SZ> struct Pool { alignas(16) unsigned char buf[SZ]; int off=0;
  void* alloc(int n,int al){ int a=(off+al-1)&~(al-1); off=a+n; return buf+a; } };
struct Rec{ long k; double v; };
int main(){
  Pool<512> pool;
  long s=0;
  for(int i=0;i<10;i++){ Rec* r=new(pool.alloc(sizeof(Rec),alignof(Rec))) Rec{(long)i*9808, (double)i/3}; s+=r->k; s+=(long)(r->v*100); }
  printf("%ld %d\n", s, pool.off);
  return 0;
}
