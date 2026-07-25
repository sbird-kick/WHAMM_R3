static long counter = 45;

__attribute__((export_name("f0")))
int f0(int p0) {
  counter += 1;
  return (int)(counter + (p0));
}

__attribute__((export_name("f1")))
float f1(int p0) {
  counter += 1;
  return (float)(counter + (p0));
}

__attribute__((export_name("f2")))
float f2(int p0, double p1) {
  counter += 1;
  return (float)(counter + (p0 + p1));
}

__attribute__((export_name("f3")))
float f3(double p0, double p1) {
  counter += 1;
  return (float)(counter + (p0 + p1));
}
