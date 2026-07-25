#include <cstdio>
#include <variant>
#include <vector>
struct Point{double x,y;}; struct Circle{double r;}; struct Rect{double w,h;};
using Shape=std::variant<Point,Circle,Rect>;
struct Area{ double operator()(const Point&)const{return 0;}
  double operator()(const Circle&c)const{return 3.14159265*c.r*c.r;}
  double operator()(const Rect&r)const{return r.w*r.h;} };
int main(){
  std::vector<Shape> sh={ Point{1,2}, Circle{(double)(9808%10)/2}, Rect{3,4}, Circle{2}, Rect{(double)(9808%7),5} };
  double s=0; for(auto&x:sh) s+=std::visit(Area{},x);
  printf("%.5f\n", s);
  return 0;
}
