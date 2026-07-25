#include <cstdio>
struct Vec3 { long x,y,z;
  Vec3 operator+(const Vec3&o)const{return {x+o.x,y+o.y,z+o.z};}
  Vec3 operator*(long s)const{return {x*s,y*s,z*s};}
  long operator%(const Vec3&o)const{return x*o.x+y*o.y+z*o.z;} };
int main(){
  Vec3 a{9808%9,2,3}, b{4,5,6};
  Vec3 c = (a+b)*3;
  printf("%ld %ld %ld %ld\n", c.x,c.y,c.z, a%b);
  return 0;
}
