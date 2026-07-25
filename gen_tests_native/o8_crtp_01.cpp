#include <cstdio>
template<class D> struct Shape { long area() const { return static_cast<const D*>(this)->area_impl(); }
  long tag() const { return static_cast<const D*>(this)->tag_impl(); } };
struct Sq : Shape<Sq> { long s; Sq(long x):s(x){} long area_impl()const{return s*s;} long tag_impl()const{return 1;} };
struct Rc : Shape<Rc> { long w,h; Rc(long a,long b):w(a),h(b){} long area_impl()const{return w*h;} long tag_impl()const{return 2;} };
int main(){
  Sq a(9808%13); Rc b(7, 9808%20);
  printf("%ld %ld %ld %ld\n", a.area(), b.area(), a.tag(), b.tag());
  return 0;
}
