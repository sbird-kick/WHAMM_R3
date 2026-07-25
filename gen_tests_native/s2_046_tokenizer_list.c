#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct Tok { char *s; struct Tok *next; } Tok;
int main(void) {
    char src[] = "the quick brown fox jumps over the lazy dog near river bank 222 times more";
    char buf[128];
    strcpy(buf, src);
    Tok *head = NULL;
    char *saveptr = NULL;
    char *tok = strtok_r(buf, " ", &saveptr);
    while (tok) {
        size_t l = strlen(tok) + 1;
        Tok *t = (Tok *)malloc(sizeof(Tok));
        t->s = (char *)malloc(l);
        memcpy(t->s, tok, l);
        t->next = head;
        head = t;
        tok = strtok_r(NULL, " ", &saveptr);
    }
    unsigned long chk = 0;
    Tok *c = head;
    while (c) { chk += strlen(c->s); Tok *nx = c->next; free(c->s); free(c); c = nx; }
    printf("chk=%lu\n", chk);
    return 0;
}
