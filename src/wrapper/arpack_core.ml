module Bindings = Arpack_bindings.Bindings (Arpack_generated)
open Bindings

let saupd
    (type a b)
    ~(kind : (a, b) Bigarray.kind)
    ~ido
    ~bmat
    ~n
    ~which
    ~nev
    ~tol
    ~resid
    ~ncv
    ~v
    ~ldv
    ~iparam
    ~ipntr
    ~workd
    ~workl
    ~lworkl
    ~info
  =
  match kind with
  | Float32 ->
    S.saupd ido bmat n which nev tol resid ncv v ldv iparam ipntr workd workl lworkl info
  | Float64 ->
    D.saupd ido bmat n which nev tol resid ncv v ldv iparam ipntr workd workl lworkl info
  | _       -> failwith "saudpd only implemented for float32 and float64"


let seupd
    (type a b)
    ~(kind : (a, b) Bigarray.kind)
    ~rvec
    ~howmny
    ~select
    ~d
    ~z
    ~ldz
    ~sigma
    ~bmat
    ~n
    ~which
    ~nev
    ~tol
    ~resid
    ~ncv
    ~v
    ~ldv
    ~iparam
    ~ipntr
    ~workd
    ~workl
    ~lworkl
    ~info
  =
  match kind with
  | Float32 ->
    S.seupd
      rvec
      howmny
      select
      d
      z
      ldz
      sigma
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      info
  | Float64 ->
    D.seupd
      rvec
      howmny
      select
      d
      z
      ldz
      sigma
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      info
  | _       -> failwith "seupd only implemented for float32 and float64"


let real_naupd
    (type a b)
    ~(kind : (a, b) Bigarray.kind)
    ~ido
    ~bmat
    ~n
    ~which
    ~nev
    ~tol
    ~resid
    ~ncv
    ~v
    ~ldv
    ~iparam
    ~ipntr
    ~workd
    ~workl
    ~lworkl
    ~info
  =
  match kind with
  | Float32 ->
    S.naupd ido bmat n which nev tol resid ncv v ldv iparam ipntr workd workl lworkl info
  | Float64 ->
    D.naupd ido bmat n which nev tol resid ncv v ldv iparam ipntr workd workl lworkl info
  | _       -> failwith
                 "real_naupd only implemented for float32, complex32, float64, complex64"


let real_neupd
    (type a b)
    ~(kind : (a, b) Bigarray.kind)
    ~rvec
    ~howmny
    ~select
    ~dr
    ~di
    ~z
    ~ldz
    ~sigmar
    ~sigmai
    ~workev
    ~bmat
    ~n
    ~which
    ~nev
    ~tol
    ~resid
    ~ncv
    ~v
    ~ldv
    ~iparam
    ~ipntr
    ~workd
    ~workl
    ~lworkl
    ~info
  =
  match kind with
  | Float32 ->
    S.neupd
      rvec
      howmny
      select
      dr
      di
      z
      ldz
      sigmar
      sigmai
      workev
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      info
  | Float64 ->
    D.neupd
      rvec
      howmny
      select
      dr
      di
      z
      ldz
      sigmar
      sigmai
      workev
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      info
  | _       -> failwith "real_neuped only implemented for float32 and float64"


let complex_naupd
    (type a b)
    ~(kind : (a, b) Bigarray.kind)
    ~ido
    ~bmat
    ~n
    ~which
    ~nev
    ~tol
    ~resid
    ~ncv
    ~v
    ~ldv
    ~iparam
    ~ipntr
    ~workd
    ~workl
    ~lworkl
    ~rwork
    ~info
  =
  match kind with
  | Complex32 ->
    C.naupd
      ido
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      rwork
      info
  | Complex64 ->
    Z.naupd
      ido
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      rwork
      info
  | _         -> failwith "complex_naupd only implemented for complex32, complex64"


let complex_neupd
    (type a b)
    ~(kind : (a, b) Bigarray.kind)
    ~rvec
    ~howmny
    ~select
    ~d
    ~z
    ~ldz
    ~sigma
    ~workev
    ~bmat
    ~n
    ~which
    ~nev
    ~tol
    ~resid
    ~ncv
    ~v
    ~ldv
    ~iparam
    ~ipntr
    ~workd
    ~workl
    ~lworkl
    ~rwork
    ~info
  =
  match kind with
  | Complex32 ->
    C.neupd
      rvec
      howmny
      select
      d
      z
      ldz
      sigma
      workev
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      rwork
      info
  | Complex64 ->
    Z.neupd
      rvec
      howmny
      select
      d
      z
      ldz
      sigma
      workev
      bmat
      n
      which
      nev
      tol
      resid
      ncv
      v
      ldv
      iparam
      ipntr
      workd
      workl
      lworkl
      rwork
      info
  | _         -> failwith "complex_neuped only implemented for complex32 and complex64"
