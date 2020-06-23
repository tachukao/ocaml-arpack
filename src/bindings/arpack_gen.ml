let () =
  let fmt file = Format.formatter_of_out_channel (open_out file) in
  let fmt_c = fmt "arpack_stubs.c" in
  Format.fprintf fmt_c "#include \"arpack.h\"@.";
  Cstubs.write_c fmt_c ~prefix:"caml" (module Arpack_bindings.Bindings);
  let fmt_ml = fmt "arpack_generated.ml" in
  Cstubs.write_ml fmt_ml ~prefix:"caml" (module Arpack_bindings.Bindings);
  flush_all ()
