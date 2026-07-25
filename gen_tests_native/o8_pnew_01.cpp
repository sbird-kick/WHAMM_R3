#include <cstdio>
#include <new>
#include <cstdint>
struct Node { int id; long payload; Node(int i):id(i),payload((long)i*9808){} };
int main(){
  alignas(16) unsigned char buf[sizeof(Node)*4];
  long s=0;
  for(int i=0;i<4;i++){ Node* n = new (buf + i*sizeof(Node)) Node(i+ (9808%3)); s = s*7 + n->payload + n->id; }
  Node* arr = reinterpret_cast<Node*>(buf);
  for(int i=0;i<4;i++){ arr[i].~Node(); }
  printf("%ld\n", s);
  return 0;
}
