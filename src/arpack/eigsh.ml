open Bigarray
open Ctypes
open Arpack_core

module Which = struct
  let to_string = function
    | `LA -> "LA"
    | `SA -> "SA"
    | `LM -> "LM"
    | `SM -> "SM"
    | `BE -> "BE"
end

let default_ncv ~nev ~n =
  let ncv = 3 * nev in
  if ncv > n then n else ncv


let solve ~evecs ?(tol = 0.) ?max_iter ?ncv ~which ~n ~nev av elt_typ kind =
  let ncv =
    match ncv with
    | Some ncv -> ncv
    | None     -> default_ncv ~nev ~n
  in
  let which = Which.to_string which in
  let bmat = "I" in
  let iparam = Ctypes.CArray.(make int 11) in
  (* set maximum iteration by default 10n *)
  Ctypes.CArray.set iparam 0 1;
  (match max_iter with
  | None          -> Ctypes.CArray.set iparam 2 (10 * n)
  | Some max_iter -> Ctypes.CArray.set iparam 2 max_iter);
  Ctypes.CArray.set iparam 3 1;
  Ctypes.CArray.set iparam 4 0;
  (* mode *)
  Ctypes.CArray.set iparam 6 1;
  let ipntr = Ctypes.CArray.(make int 11) in
  let resid = Ctypes.CArray.(make elt_typ n) in
  let v = Bigarray.Genarray.create kind c_layout [| n; ncv |] in
  let workd = Bigarray.Array1.create kind c_layout (3 * n) in
  let ido = Ctypes.(allocate int 0) in
  let lworkl = (ncv * ncv) + (8 * ncv) in
  let workl = Ctypes.CArray.(make elt_typ lworkl) in
  let info = Ctypes.(allocate int 0) in
  let ldv = n in
  while Ctypes.(!@ido) <> 99 do
    saupd
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
  then failwith (Printf.sprintf "*saupd_c error %i" Ctypes.(!@info))
  else (
    let rvec = if evecs then 1 else 0 in
    let howmny = "A" in
    let select = Ctypes.CArray.(make int ncv) in
    let d = Bigarray.Genarray.create kind c_layout [| 1; nev |] in
    let z =
      if evecs
      then Bigarray.Genarray.create kind c_layout [| n; nev |]
      else Bigarray.Genarray.create kind c_layout [| 1 |]
    in
    let resid = Ctypes.CArray.(make elt_typ n) in
    let ldz = n in
    let sigma = 0. in
    seupd
      ~kind
      ~rvec
      ~howmny
      ~select:(Ctypes.CArray.start select)
      ~d:(Ctypes.bigarray_start genarray d)
      ~z:(Ctypes.bigarray_start genarray z)
      ~ldz
      ~sigma
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
    then failwith (Printf.sprintf "*seupd_c error %i" Ctypes.(!@info));
    if evecs then Some z, d else None, d)
