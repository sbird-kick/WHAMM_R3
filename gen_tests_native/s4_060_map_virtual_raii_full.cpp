#include <map>
#include <cstdio>
static long elog = 0;
struct Task {
    virtual int run() const = 0;
    virtual ~Task() { elog += 1000; }
};
struct TaskA : Task { int n; TaskA(int n_):n(n_){} int run() const override { return n*2; } };
struct TaskB : Task { int n; TaskB(int n_):n(n_){} int run() const override { return n+50; } };
int main(){
    {
        std::map<int, Task*> tasks;
        TaskA a1(4), a2(44);
        TaskB b1(7), b2(9);
        tasks[1] = &a1; tasks[2] = &b1; tasks[3] = &a2; tasks[4] = &b2;
        for (auto &p : tasks) elog += p.second->run();
    }
    printf("log=%ld\n", elog);
    return 0;
}
