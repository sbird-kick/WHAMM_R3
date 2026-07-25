#include <cstdio>
struct Shape { virtual int area() const = 0; virtual ~Shape(){} };
struct Rect : Shape { int w,h; Rect(int w_,int h_):w(w_),h(h_){} int area() const override { return w*h; } };
struct Circ : Shape { int r; Circ(int r_):r(r_){} int area() const override { return 3*r*r; } };
int main(){
    Shape* shapes[4];
    Rect r1(4,7); Circ c1(5); Rect r2(9,2); Circ c2(3);
    shapes[0]=&r1; shapes[1]=&c1; shapes[2]=&r2; shapes[3]=&c2;
    long total=0;
    for (int i=0;i<4;i++) total += shapes[i]->area();
    printf("total=%ld\n", total);
    return 0;
}
