/* Shared main wrapper for R3 differential Lua tests.
 * Opens a reduced library set (no io/os/debug — those need WASI features Wizard
 * lacks and are dead-code-eliminated by wasm-ld --gc-sections). Loads and runs
 * an embedded, deterministic Lua chunk via lua_pcall. No coroutine.yield and no
 * error() in scripts: Wizard implements no THROW opcode, so Lua's longjmp-based
 * unwinding is compiled to abort() (see shim/setjmp.h). */
#include <stdio.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

extern const unsigned char lua_script[];
extern const unsigned int  lua_script_len;

static const luaL_Reg loadedlibs[] = {
  {LUA_GNAME,       luaopen_base},
  {LUA_TABLIBNAME,  luaopen_table},
  {LUA_STRLIBNAME,  luaopen_string},
  {LUA_MATHLIBNAME, luaopen_math},
  {LUA_UTF8LIBNAME, luaopen_utf8},
  {NULL, NULL}
};

int main(void){
  lua_State *L = luaL_newstate();
  if (!L) return 2;
  const luaL_Reg *lib;
  for (lib = loadedlibs; lib->func; lib++){
    luaL_requiref(L, lib->name, lib->func, 1);
    lua_pop(L, 1);
  }
  int rc = luaL_loadbuffer(L, (const char*)lua_script, lua_script_len, "=script");
  if (rc == LUA_OK) rc = lua_pcall(L, 0, 0, 0);
  if (rc != LUA_OK){
    fprintf(stderr, "LUA-ERR: %s\n", lua_tostring(L, -1));
    lua_close(L);
    return 1;
  }
  lua_close(L);
  return 0;
}
