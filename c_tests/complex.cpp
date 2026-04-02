// Kitchen sink C++ test: polymorphism, STL containers, algorithms, file I/O,
// function pointers, lambdas (via function pointers), heap allocation,
// bulk memory ops, data segments, deep call stacks
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <algorithm>
#include <vector>
#include <map>
#include <set>
#include <unordered_map>
#include <string>
#include <functional>
#include <numeric>

// ── Polymorphism: virtual dispatch → call_indirect ──────────────────────

struct Shape {
    virtual double area() const = 0;
    virtual const char* name() const = 0;
    virtual ~Shape() {}
};

struct Circle : Shape {
    double radius;
    Circle(double r) : radius(r) {}
    double area() const override { return 3.14159265 * radius * radius; }
    const char* name() const override { return "Circle"; }
};

struct Rectangle : Shape {
    double w, h;
    Rectangle(double w, double h) : w(w), h(h) {}
    double area() const override { return w * h; }
    const char* name() const override { return "Rectangle"; }
};

struct Triangle : Shape {
    double base, height;
    Triangle(double b, double h) : base(b), height(h) {}
    double area() const override { return 0.5 * base * height; }
    const char* name() const override { return "Triangle"; }
};

// ── Functional: function pointers ───────────────────────────────────────

typedef double (*Transform)(double);

double square(double x) { return x * x; }
double negate(double x) { return -x; }

void map_inplace(double* arr, int n, Transform fn) {
    for (int i = 0; i < n; i++) arr[i] = fn(arr[i]);
}

double reduce(const double* arr, int n, double init, double (*op)(double, double)) {
    double acc = init;
    for (int i = 0; i < n; i++) acc = op(acc, arr[i]);
    return acc;
}

double add(double a, double b) { return a + b; }

// ── String processing (exercises heap + data segments + WASI fd_write) ──

void string_processing() {
    // Build strings dynamically — heap alloc + data segment reads
    std::vector<std::string> words;
    words.push_back("the");
    words.push_back("quick");
    words.push_back("brown");
    words.push_back("fox");
    words.push_back("jumps");
    words.push_back("over");
    words.push_back("the");
    words.push_back("lazy");
    words.push_back("dog");

    std::sort(words.begin(), words.end());
    printf("Sorted words: ");
    for (auto& w : words) printf("%s ", w.c_str());
    printf("\n");

    // Reverse each word in-place
    for (auto& w : words) std::reverse(w.begin(), w.end());
    printf("Reversed: ");
    for (auto& w : words) printf("%s ", w.c_str());
    printf("\n");
}

// ── Main ────────────────────────────────────────────────────────────────

int main() {
    // === Polymorphic dispatch ===
    std::vector<Shape*> shapes;
    shapes.push_back(new Circle(5.0));
    shapes.push_back(new Rectangle(3.0, 4.0));
    shapes.push_back(new Triangle(6.0, 8.0));
    shapes.push_back(new Circle(1.0));
    shapes.push_back(new Rectangle(10.0, 10.0));

    double total_area = 0;
    for (auto* s : shapes) {
        printf("%s: area=%.2f\n", s->name(), s->area());
        total_area += s->area();
    }
    printf("Total area: %.2f\n", total_area);
    for (auto* s : shapes) delete s;

    // === std::sort with custom comparator ===
    std::vector<int> nums = {42, 17, 99, 3, 55, 28, 71, 8, 63, 1};
    std::sort(nums.begin(), nums.end());
    printf("Sorted: ");
    for (int n : nums) printf("%d ", n);
    printf("\n");

    // Sort descending
    std::sort(nums.begin(), nums.end(), [](int a, int b) { return a > b; });
    printf("Reversed: ");
    for (int n : nums) printf("%d ", n);
    printf("\n");

    // === std::map (ordered, red-black tree) ===
    std::map<std::string, int> word_count;
    const char* words[] = {"hello", "world", "hello", "foo", "bar", "hello", "world", "baz", "foo", "foo"};
    for (auto w : words) word_count[w]++;
    printf("Word counts:\n");
    for (auto& [word, count] : word_count)
        printf("  %s: %d\n", word.c_str(), count);

    // === std::unordered_map (hash map) ===
    std::unordered_map<int, std::string> id_to_name;
    id_to_name[1] = "Alice";
    id_to_name[2] = "Bob";
    id_to_name[3] = "Charlie";
    id_to_name[100] = "Zara";
    printf("Lookup id=2: %s\n", id_to_name[2].c_str());
    printf("Hash map size: %zu\n", id_to_name.size());

    // === std::set (ordered, unique) ===
    std::set<int> unique_nums;
    for (int i = 0; i < 50; i++) unique_nums.insert(i % 7);
    printf("Unique mod 7: ");
    for (int n : unique_nums) printf("%d ", n);
    printf("\n");

    // === std::accumulate + transform ===
    std::vector<double> data = {1, 2, 3, 4, 5, 6, 7, 8};
    double sum = std::accumulate(data.begin(), data.end(), 0.0);
    printf("Sum: %.0f\n", sum);

    std::transform(data.begin(), data.end(), data.begin(), square);
    double sum_sq = std::accumulate(data.begin(), data.end(), 0.0);
    printf("Sum of squares: %.0f\n", sum_sq);

    // === Function pointer map/reduce ===
    double raw[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    map_inplace(raw, 8, negate);
    double neg_sum = reduce(raw, 8, 0.0, add);
    printf("Negated sum: %.0f\n", neg_sum);

    // === Large allocation → memory.grow + memcpy ===
    int* big = (int*)malloc(100000 * sizeof(int));
    for (int i = 0; i < 100000; i++) big[i] = i;
    int* big2 = (int*)malloc(100000 * sizeof(int));
    memcpy(big2, big, 100000 * sizeof(int));
    long checksum = 0;
    for (int i = 0; i < 100000; i++) checksum += big2[i];
    printf("Checksum: %ld\n", checksum);
    free(big);
    free(big2);

    // === memset (memory.fill) ===
    char* buf = (char*)malloc(4096);
    memset(buf, 0xAA, 4096);
    int fill_ok = 1;
    for (int i = 0; i < 4096; i++) {
        if ((unsigned char)buf[i] != 0xAA) { fill_ok = 0; break; }
    }
    printf("Memset check: %s\n", fill_ok ? "OK" : "FAIL");
    free(buf);

    // === String processing ===
    string_processing();

    return 0;
}
