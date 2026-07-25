#include <cstdio>
#include <new>
#include <cstdint>
template<class T, int N> struct Arena {
  alignas(alignof(T)) unsigned char mem[sizeof(T)*N]; int used=0;
  template<class...A> T* make(A...a){ T* p=new(mem+used*sizeof(T)) T(a...); used++; return p; }
};
struct P { double x,y; P(double a,double b):x(a),y(b){} };
int main(){
  Arena<P,8> ar;
  double s=0;
  for(int i=0;i<6;i++){ P* p=ar.make((double)i, (double)(9808%17)/i - i); s += p->x - p->y; }
  printf("%.4f %d\n", s, ar.used);
  return 0;
}
