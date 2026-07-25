#include <cstdio>
template<class T> struct Stack { T d[32]; int n=0; void push(T x){d[n++]=x;} T pop(){return d[--n];} bool empty(){return n==0;} };
int main(){
  Stack<long> s;
  const char* rpn="9808 2 * 3 + 5 -";
  long acc=0; long nums[16]; int ni=0; long cur=0; bool innum=false;
  for(const char*p=rpn;;++p){ char c=*p;
    if(c>='0'&&c<='9'){ cur=cur*10+(c-'0'); innum=true; }
    else { if(innum){ s.push(cur); cur=0; innum=false; }
      if(c=='+'){long b=s.pop(),a=s.pop();s.push(a+b);}
      else if(c=='*'){long b=s.pop(),a=s.pop();s.push(a*b);}
      else if(c=='-'){long b=s.pop(),a=s.pop();s.push(a-b);}
      if(c==0) break; } }
  (void)nums;(void)ni;(void)acc;
  printf("%ld\n", s.pop());
  return 0;
}
