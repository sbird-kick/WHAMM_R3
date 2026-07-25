static long counter = 40;

__attribute__((export_name("f0")))
int f0(long p0) {
  counter += 1;
  return (int)(counter + (p0));
}

__attribute__((export_name("f1")))
double f1(long p0) {
  counter += 1;
  return (double)(counter + (p0));
}

__attribute__((export_name("f2")))
double f2(double p0) {
  counter += 1;
  return (double)(counter + (p0));
}

__attribute__((export_name("f3")))
int f3(int p0) {
  counter += 1;
  return (int)(counter + (p0));
}
