#include <cstdio>
int main(){
  int a=9808%50, b=7; long acc=0;
  auto mut=[a,&b,&acc]()mutable{ a+=b; b++; acc+=a; };
  for(int i=0;i<10;i++) mut();
  auto gen=[=]()->long{ return (long)a*1000+b; };
  printf("%ld %ld\n", acc, gen());
  return 0;
}
