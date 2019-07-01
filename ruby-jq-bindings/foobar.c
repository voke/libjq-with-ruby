#include <ruby.h>
#include <string.h>
#include <jq.h>

VALUE rb_try_libjq() {

  jv input;
  jv result;
  jv dumped;

  const char *buf = "\"foobar\""; // "foobar"
  const char *prog = "scan(\"foo(.+)\")"; // scan("foo(.+)")
  const char *output;

  jq_state *jq = NULL;
  jq = jq_init();

  input = jv_parse(buf);
  jq_compile(jq, prog);

  jq_start(jq, input, JQ_DEBUG_TRACE);

  result = jq_next(jq);

  dumped = jv_dump_string(result, 0);
  output = jv_string_value(dumped);

  jq_teardown(&jq);

  // To get a new VALUE with your locale’s encoding
  return rb_str_export_locale(rb_str_new_cstr(output));

}

void Init_foobar()
{
  VALUE mod = rb_define_module("Foobar");
  rb_define_singleton_method(mod, "try_libjq", rb_try_libjq, 0);
}
