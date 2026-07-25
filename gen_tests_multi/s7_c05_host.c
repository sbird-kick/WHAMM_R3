static long counter = 64;

__attribute__((export_name("f0")))
double f0(double p0) {
  counter += 1;
  return (double)(counter + (p0));
}

__attribute__((export_name("f1")))
double f1(long p0, int p1) {
  counter += 1;
  return (double)(counter + (p0 + p1));
}

__attribute__((export_name("f2")))
long f2(float p0) {
  counter += 1;
  return (long)(counter + (p0));
}
