#include <cstdio>
#include <cstdint>
struct CRC { uint32_t t[256];
  constexpr CRC():t(){ for(uint32_t i=0;i<256;i++){ uint32_t c=i; for(int k=0;k<8;k++) c = c&1?0xEDB88320u^(c>>1):c>>1; t[i]=c; } } };
constexpr CRC C{};
int main(){
  const char* msg="whamm-r3-9808";
  uint32_t crc=0xFFFFFFFFu;
  for(const char*p=msg;*p;p++) crc = C.t[(crc^ (uint8_t)*p)&0xFF] ^ (crc>>8);
  printf("%08x\n", crc^0xFFFFFFFFu);
  return 0;
}
