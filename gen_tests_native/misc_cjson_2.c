/* cJSON test 2: build a document programmatically, serialize, reparse,
   compute aggregates over an array of objects. Fixed inputs only. */
#include <stdio.h>
#include <string.h>
#include "cJSON.h"

int main(void){
  printf("start misc_cjson_2\n");
  cJSON *root = cJSON_CreateObject();
  cJSON_AddStringToObject(root, "title", "records");
  cJSON *arr = cJSON_AddArrayToObject(root, "items");

  static const int ids[5]   = {1,2,3,4,5};
  static const int qtys[5]  = {10,7,3,20,1};
  static const int prices[5]= {100,250,75,40,999};

  for(int i=0;i<5;i++){
    cJSON *o = cJSON_CreateObject();
    cJSON_AddNumberToObject(o, "id", ids[i]);
    cJSON_AddNumberToObject(o, "qty", qtys[i]);
    cJSON_AddNumberToObject(o, "price", prices[i]);
    cJSON_AddItemToArray(arr, o);
  }

  char *json = cJSON_PrintUnformatted(root);
  printf("serialized_len=%d\n", (int)(json?strlen(json):0));

  /* reparse and compute total cost = sum(qty*price) */
  cJSON *rt = cJSON_Parse(json);
  cJSON *items = cJSON_GetObjectItemCaseSensitive(rt, "items");
  long total = 0; int maxprice = 0;
  cJSON *it = NULL;
  cJSON_ArrayForEach(it, items){
    int q = (int)cJSON_GetNumberValue(cJSON_GetObjectItemCaseSensitive(it,"qty"));
    int p = (int)cJSON_GetNumberValue(cJSON_GetObjectItemCaseSensitive(it,"price"));
    total += (long)q*p;
    if(p>maxprice) maxprice=p;
  }
  printf("total_cost=%ld max_price=%d count=%d\n",
         total, maxprice, cJSON_GetArraySize(items));

  cJSON_Delete(rt);
  cJSON_free(json);
  cJSON_Delete(root);
  printf("end misc_cjson_2\n");
  return 0;
}
