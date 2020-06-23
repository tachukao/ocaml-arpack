module C = Configurator.V1

let () =
  C.main ~name:"arpack" (fun _ ->
      let cflags = [ "-I/usr/local/opt/arpack/include/arpack" ] in
      let libs = [ "-larpack"; "-lopenblas"; "-L/usr/local/opt/arpack/lib" ] in
      let conf : C.Pkg_config.package_conf = { cflags; libs } in
      C.Flags.write_sexp "c_flags.sexp" conf.cflags;
      C.Flags.write_sexp "c_library_flags.sexp" conf.libs)
