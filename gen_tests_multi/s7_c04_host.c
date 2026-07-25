static long counter = 75;

__attribute__((export_name("f0")))
float f0(double p0) {
  counter += 1;
  return (float)(counter + (p0));
}

__attribute__((export_name("f1")))
float f1(long p0) {
  counter += 1;
  return (float)(counter + (p0));
}

__attribute__((export_name("f2")))
long f2(float p0, double p1) {
  counter += 1;
  return (long)(counter + (p0 + p1));
}

__attribute__((export_name("f3")))
long f3(int p0) {
  counter += 1;
  return (long)(counter + (p0));
}
