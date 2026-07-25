#include <cstdio>
constexpr unsigned hashstr(const char*s){ unsigned h=2166136261u; while(*s){ h=(h^(unsigned char)*s)*16777619u; s++; } return h; }
constexpr unsigned H[6]={ hashstr("whamm"),hashstr("r3"),hashstr("monitor"),hashstr("9808"),hashstr("oracle"),hashstr("trace") };
int main(){ unsigned s=0; for(int i=0;i<6;i++) s^=H[i]+(unsigned)(i*9808); printf("%u\n", s); return 0; }
