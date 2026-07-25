static long counter = 20;

__attribute__((export_name("f0")))
float f0(float p0, int p1) {
  counter += 1;
  return (float)(counter + (p0 + p1));
}

__attribute__((export_name("f1")))
float f1(double p0) {
  counter += 1;
  return (float)(counter + (p0));
}

__attribute__((export_name("f2")))
int f2(long p0, double p1) {
  counter += 1;
  return (int)(counter + (p0 + p1));
}
