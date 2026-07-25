/* cJSON test 3: error handling + numeric edge cases + deep access.
   Exercises parse-error reporting and duplicate/detach. Fixed inputs. */
#include <stdio.h>
#include "cJSON.h"

int main(void){
  printf("start misc_cjson_3\n");

  /* malformed input -> parse fails, error pointer set */
  const char *bad = "{\"a\":1,\"b\":}";
  cJSON *fail = cJSON_Parse(bad);
  const char *ep = cJSON_GetErrorPtr();
  printf("bad_parsed=%d err_at=%c\n", fail!=0, ep?*ep:'?');
  cJSON_Delete(fail);

  /* numbers: negatives, exponents, fractions */
  const char *nums = "[-5, 2.5e2, 0.125, 1000000, -3.75]";
  cJSON *arr = cJSON_Parse(nums);
  double acc = 0;
  cJSON *n = NULL;
  cJSON_ArrayForEach(n, arr){ acc += cJSON_GetNumberValue(n); }
  printf("num_sum_x1000=%d size=%d\n", (int)(acc*1000), cJSON_GetArraySize(arr));
  cJSON_Delete(arr);

  /* deep nesting access + detach */
  const char *deep = "{\"a\":{\"b\":{\"c\":{\"d\":77}}}}";
  cJSON *r = cJSON_Parse(deep);
  cJSON *d = cJSON_GetObjectItem(
              cJSON_GetObjectItem(
               cJSON_GetObjectItem(
                cJSON_GetObjectItem(r,"a"),"b"),"c"),"d");
  printf("deep_d=%d\n", (int)cJSON_GetNumberValue(d));

  cJSON *dup = cJSON_Duplicate(r, 1);
  cJSON *da = cJSON_DetachItemFromObjectCaseSensitive(dup, "a");
  printf("detached_nonnull=%d dup_now_empty=%d\n",
         da!=0, cJSON_GetArraySize(dup)==0);
  cJSON_Delete(da);
  cJSON_Delete(dup);
  cJSON_Delete(r);

  printf("end misc_cjson_3\n");
  return 0;
}
