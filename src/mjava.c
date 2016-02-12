#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/string.h"

#if defined(_WIN32) || defined(_WIN64)
  #include <windows.h>
  #include <stdio.h>
#else
  #include <dlfcn.h>
  #include <stdlib.h>
  #include <unistd.h>
#endif

#include <string.h>
#include <sys/stat.h>

#define DONE mrb_gc_arena_restore(mrb, 0)

static mrb_value
mrb_file_s_chmod2(mrb_state *mrb, mrb_value klass)
{
#if defined(_WIN32) || defined(_WIN64)
  // do nothing
#else
  mrb_value a, b;
  const char *mode, *file;
  int ai = mrb_gc_arena_save(mrb);

  mrb_get_args(mrb, "SS", &a, &b);
  mode = mrb_str_to_cstr(mrb, a);
  file = mrb_str_to_cstr(mrb, b);

  int i;
  i = strtol(mode, 0, 8);
  if (chmod(file,i) < 0) {
    mrb_sys_fail(mrb, mrb_str_to_cstr(mrb, mrb_format(mrb, "chmod2(%S, %S)", a, b)));
  }
  mrb_gc_arena_restore(mrb, ai);
#endif
  return mrb_fixnum_value(0);
}

void
mrb_mjava_gem_init(mrb_state* mrb)
{
  struct RClass *c;
  c = mrb_class_get(mrb, "File");
  mrb_define_class_method(mrb, c, "chmod2", mrb_file_s_chmod2, MRB_ARGS_REQ(2));
}

void
mrb_mjava_gem_final(mrb_state* mrb)
{
}
