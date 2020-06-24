open Bigarray
open Ctypes
open Arpack_core

module Which = struct
  let to_string = function
    | `LM -> "LM"
    | `SM -> "SM"
    | `SR -> "SR"
    | `LI -> "LI"
    | `SI -> "SI"
end

let default_ncv ~nev ~n =
  let ncv = (3 * nev) + 1 in
  if ncv > n then n else ncv


let rsolve ~evecs ?(tol = 0.) ?max_iter ?ncv ~which ~n ~nev av elt_typ kind =
  let ncv =
    match ncv with
    | Some ncv -> ncv
    | None     -> default_ncv ~n ~nev
  in
  let which = Which.to_string which in
  let bmat = "I" in
  let iparam = Ctypes.CArray.(make int 11) in
  Ctypes.CArray.set iparam 0 1;
  (match max_iter with
  | None          -> Ctypes.CArray.set iparam 2 (10 * n)
  | Some max_iter -> Ctypes.CArray.set iparam 2 max_iter);
  Ctypes.CArray.set iparam 3 1;
  Ctypes.CArray.set iparam 4 0;
  Ctypes.CArray.set iparam 6 1;
  let ipntr = Ctypes.CArray.(make int 11) in
  let resid = Ctypes.CArray.(make elt_typ n) in
  let v = Bigarray.Genarray.create kind c_layout [| ncv; n |] in
  let workd = Bigarray.Array1.create kind c_layout (3 * n) in
  let ido = Ctypes.(allocate int 0) in
  let lworkl = (3 * (ncv * ncv)) + (6 * ncv) in
  let workl = Ctypes.CArray.(make elt_typ lworkl) in
  let info = Ctypes.(allocate int 0) in
  let ldv = n in
  while Ctypes.(!@ido) <> 99 do
    real_naupd
      ~kind
      ~ido
      ~bmat
      ~n
      ~which
      ~nev
      ~tol
      ~resid:Ctypes.CArray.(start resid)
      ~ncv
      ~v:Ctypes.(bigarray_start genarray v)
      ~ldv
      ~iparam:Ctypes.CArray.(start iparam)
      ~ipntr:Ctypes.CArray.(start ipntr)
      ~workd:Ctypes.(bigarray_start array1 workd)
      ~workl:Ctypes.CArray.(start workl)
      ~lworkl
      ~info;
    if Ctypes.(!@ido = 1) || Ctypes.(!@ido = -1)
    then (
      let src = Array1.sub workd (Ctypes.CArray.(get ipntr 0) - 1) n in
      let dest = Array1.sub workd (Ctypes.CArray.(get ipntr 1) - 1) n in
      av src dest)
  done;
  if Ctypes.(!@info) < 0
  then failwith (Printf.sprintf "*naupd_c error %i" Ctypes.(!@info))
  else (
    let rvec = if evecs then 1 else 0 in
    let howmny = "A" in
    let select = Ctypes.CArray.(make int ncv) in
    let d = Bigarray.Genarray.create kind c_layout [| 2; nev |] in
    let dr = Bigarray.Genarray.sub_left d 0 1 in
    let di = Bigarray.Genarray.sub_left d 1 1 in
    let resid = Ctypes.CArray.(make elt_typ n) in
    let ldz = n in
    let sigmar = 0. in
    let sigmai = 0. in
    let workev = Ctypes.CArray.(make elt_typ (3 * ncv)) in
    real_neupd
      ~kind
      ~rvec
      ~howmny
      ~select:(Ctypes.CArray.start select)
      ~dr:(Ctypes.bigarray_start genarray dr)
      ~di:(Ctypes.bigarray_start genarray di)
      ~z:(Ctypes.bigarray_start genarray v)
      ~ldz
      ~sigmar
      ~sigmai
      ~workev:(Ctypes.CArray.start workev)
      ~bmat
      ~n
      ~which
      ~nev
      ~tol
      ~resid:(Ctypes.CArray.start resid)
      ~ncv
      ~v:(Ctypes.bigarray_start genarray v)
      ~ldv
      ~iparam:(Ctypes.CArray.start iparam)
      ~ipntr:(Ctypes.CArray.start ipntr)
      ~workd:(Ctypes.bigarray_start array1 workd)
      ~workl:(Ctypes.CArray.start workl)
      ~lworkl
      ~info;
    if Ctypes.(!@info) < 0
    then failwith (Printf.sprintf "*neupd_c error %i" Ctypes.(!@info));
    if evecs then Some Genarray.(sub_left v 0 nev), d else None, d)


let csolve ~evecs ?(tol = 0.) ?max_iter ?ncv ~which ~n ~nev av elt_typ real_elt_typ kind =
  let ncv =
    match ncv with
    | Some ncv -> ncv
    | None     -> default_ncv ~n ~nev
  in
  let which = Which.to_string which in
  let bmat = "I" in
  let iparam = Ctypes.CArray.(make int 11) in
  Ctypes.CArray.set iparam 0 1;
  (match max_iter with
  | None          -> Ctypes.CArray.set iparam 2 (10 * n)
  | Some max_iter -> Ctypes.CArray.set iparam 2 max_iter);
  Ctypes.CArray.set iparam 3 1;
  Ctypes.CArray.set iparam 4 0;
  Ctypes.CArray.set iparam 6 1;
  let ipntr = Ctypes.CArray.(make int 11) in
  let resid = Ctypes.CArray.(make elt_typ n) in
  let v = Bigarray.Genarray.create kind c_layout [| ncv + 1; n |] in
  let workd = Bigarray.Array1.create kind c_layout (3 * n) in
  let ido = Ctypes.(allocate int 0) in
  let lworkl = (3 * (ncv * ncv)) + (6 * ncv) in
  let workl = Ctypes.CArray.(make elt_typ lworkl) in
  let rwork = Ctypes.CArray.(make real_elt_typ ncv) in
  let info = Ctypes.(allocate int 0) in
  let ldv = n in
  while Ctypes.(!@ido) <> 99 do
    complex_naupd
      ~kind
      ~ido
      ~bmat
      ~n
      ~which
      ~nev
      ~tol
      ~resid:Ctypes.CArray.(start resid)
      ~ncv
      ~v:Ctypes.(bigarray_start genarray v)
      ~ldv
      ~iparam:Ctypes.CArray.(start iparam)
      ~ipntr:Ctypes.CArray.(start ipntr)
      ~workd:Ctypes.(bigarray_start array1 workd)
      ~workl:Ctypes.CArray.(start workl)
      ~lworkl
      ~rwork:Ctypes.CArray.(start rwork)
      ~info;
    if Ctypes.(!@ido = 1) || Ctypes.(!@ido = -1)
    then (
      let src = Array1.sub workd (Ctypes.CArray.(get ipntr 0) - 1) n in
      let dest = Array1.sub workd (Ctypes.CArray.(get ipntr 1) - 1) n in
      av src dest)
  done;
  if Ctypes.(!@info) < 0
  then failwith (Printf.sprintf "*naupd_c error %i" Ctypes.(!@info))
  else (
    let rvec = if evecs then 1 else 0 in
    let howmny = "A" in
    let select = Ctypes.CArray.(make int ncv) in
    let d = Bigarray.Genarray.create kind c_layout [| nev + 1; n |] in
    let resid = Ctypes.CArray.(make elt_typ n) in
    let ldz = n in
    let sigma = Complex.{ re = 0.; im = 0. } in
    let workev = Ctypes.CArray.(make elt_typ (3 * ncv)) in
    complex_neupd
      ~kind
      ~rvec
      ~howmny
      ~select:(Ctypes.CArray.start select)
      ~d:(Ctypes.bigarray_start genarray d)
      ~z:(Ctypes.bigarray_start genarray v)
      ~ldz
      ~sigma
      ~workev:(Ctypes.CArray.start workev)
      ~bmat
      ~n
      ~which
      ~nev
      ~tol
      ~resid:(Ctypes.CArray.start resid)
      ~ncv
      ~v:(Ctypes.bigarray_start genarray v)
      ~ldv
      ~iparam:(Ctypes.CArray.start iparam)
      ~ipntr:(Ctypes.CArray.start ipntr)
      ~workd:(Ctypes.bigarray_start array1 workd)
      ~workl:(Ctypes.CArray.start workl)
      ~lworkl
      ~rwork:(Ctypes.CArray.start rwork)
      ~info;
    if Ctypes.(!@info) < 0
    then failwith (Printf.sprintf "*neupd_c error %i" Ctypes.(!@info));
    if evecs then Some Genarray.(sub_left v 0 nev), d else None, d)
