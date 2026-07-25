static long counter = 80;

__attribute__((export_name("f0")))
float f0(float p0) {
  counter += 1;
  return (float)(counter + (p0));
}

__attribute__((export_name("f1")))
long f1(float p0, double p1) {
  counter += 1;
  return (long)(counter + (p0 + p1));
}
