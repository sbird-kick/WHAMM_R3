// Function pointers compile to call_indirect — tests our indirect call handling
typedef int (*binop)(int, int);

int add(int a, int b) { return a + b; }
int mul(int a, int b) { return a * b; }
int sub(int a, int b) { return a - b; }

int apply(binop fn, int a, int b) {
    return fn(a, b);
}

int main() {
    binop ops[3] = { add, mul, sub };
    int result = 0;
    for (int i = 0; i < 3; i++) {
        result += apply(ops[i], 10, i + 1);
    }
    // add(10,1)=11 + mul(10,2)=20 + sub(10,3)=7 = 38
    return result != 38;
}
