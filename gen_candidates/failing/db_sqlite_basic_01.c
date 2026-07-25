/* SQLite in-memory: CREATE/INSERT/SELECT, fully deterministic. */
#include <stdio.h>
#include "sqlite3.h"

static int rc_check(int rc, sqlite3 *db, const char *what) {
    if (rc != SQLITE_OK) {
        printf("ERR %s: %s\n", what, sqlite3_errmsg(db));
        return 1;
    }
    return 0;
}

int main(void) {
    printf("start db_sqlite_basic_01\n");
    sqlite3 *db = 0;
    if (sqlite3_open(":memory:", &db) != SQLITE_OK) { printf("open fail\n"); return 1; }

    char *err = 0;
    sqlite3_exec(db, "CREATE TABLE t(id INTEGER PRIMARY KEY, v INTEGER);", 0, 0, &err);
    for (int i = 1; i <= 20; i++) {
        char sql[128];
        snprintf(sql, sizeof(sql), "INSERT INTO t(id,v) VALUES(%d,%d);", i, (i * 7) % 13);
        sqlite3_exec(db, sql, 0, 0, &err);
    }

    sqlite3_stmt *st = 0;
    sqlite3_prepare_v2(db, "SELECT count(*), sum(v), max(v) FROM t;", -1, &st, 0);
    if (sqlite3_step(st) == SQLITE_ROW) {
        printf("count=%lld sum=%lld max=%lld\n",
               sqlite3_column_int64(st, 0),
               sqlite3_column_int64(st, 1),
               sqlite3_column_int64(st, 2));
    }
    sqlite3_finalize(st);

    sqlite3_close(db);
    printf("done\n");
    return 0;
}
