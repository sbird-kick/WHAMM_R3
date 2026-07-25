#include <cstdio>
#include <type_traits>
template<class T> typename std::enable_if<std::is_integral<T>::value,T>::type f(T x){ return x*3+9808; }
template<class T> typename std::enable_if<std::is_floating_point<T>::value,T>::type f(T x){ return x/2 + 0.5; }
int main(){
  printf("%d %lld %.4f\n", f<int>(10), (long long)f<long long>(1000), f<double>(9808.0/64));
  return 0;
}
