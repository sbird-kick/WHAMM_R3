#include <cstdio>
#include <new>
#include <cstdint>
union Slot { double d; long l; int i[2]; };
int main(){
  alignas(8) unsigned char buf[sizeof(Slot)*6];
  long s=0;
  for(int i=0;i<6;i++){ Slot* sl=new(buf+i*sizeof(Slot)) Slot; sl->l=(long)i*9808+7; s^=sl->i[0]; s+=sl->l; }
  printf("%ld\n", s);
  return 0;
}
