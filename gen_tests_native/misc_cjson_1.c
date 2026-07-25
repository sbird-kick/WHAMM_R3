/* cJSON differential test: parse a fixed JSON doc, read values back,
   round-trip via print+reparse, print computed results. Fixed inputs only. */
#include <stdio.h>
#include <string.h>
#include "cJSON.h"

static const char *DOC =
  "{\"name\":\"whamm\",\"version\":3,\"pi\":3.5,\"ok\":true,"
  "\"tags\":[\"a\",\"bb\",\"ccc\"],"
  "\"nested\":{\"x\":10,\"y\":20,\"z\":30}}";

int main(void){
  printf("start misc_cjson_1\n");
  cJSON *root = cJSON_Parse(DOC);
  if(!root){ printf("parse-fail\n"); return 0; }

  cJSON *name = cJSON_GetObjectItemCaseSensitive(root, "name");
  cJSON *ver  = cJSON_GetObjectItemCaseSensitive(root, "version");
  cJSON *pi   = cJSON_GetObjectItemCaseSensitive(root, "pi");
  cJSON *ok   = cJSON_GetObjectItemCaseSensitive(root, "ok");
  cJSON *tags = cJSON_GetObjectItemCaseSensitive(root, "tags");
  cJSON *nest = cJSON_GetObjectItemCaseSensitive(root, "nested");

  printf("name=%s\n", cJSON_GetStringValue(name));
  printf("version=%d\n", (int)cJSON_GetNumberValue(ver));
  printf("pi_x2=%d\n", (int)(cJSON_GetNumberValue(pi) * 2));
  printf("ok=%d\n", cJSON_IsTrue(ok));

  int ntags = cJSON_GetArraySize(tags);
  int totlen = 0;
  for(int i=0;i<ntags;i++){
    cJSON *t = cJSON_GetArrayItem(tags, i);
    totlen += (int)strlen(cJSON_GetStringValue(t));
  }
  printf("ntags=%d totlen=%d\n", ntags, totlen);

  int sum = 0;
  cJSON *c = NULL;
  cJSON_ArrayForEach(c, nest){ sum += (int)cJSON_GetNumberValue(c); }
  printf("nested_sum=%d\n", sum);

  /* round-trip: print then reparse, verify version survives */
  char *out = cJSON_PrintUnformatted(root);
  if(out){
    cJSON *rt = cJSON_Parse(out);
    int v2 = (int)cJSON_GetNumberValue(cJSON_GetObjectItemCaseSensitive(rt, "version"));
    printf("roundtrip_version=%d outlen=%d\n", v2, (int)strlen(out));
    cJSON_Delete(rt);
    cJSON_free(out);
  }

  cJSON_Delete(root);
  printf("end misc_cjson_1\n");
  return 0;
}
