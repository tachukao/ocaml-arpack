open Bigarray
open Ctypes

let eigsh
    (type a)
    (kind : (float, a) Bigarray.kind)
    ?(tol = 0.)
    ?max_iter
    ?ncv
    ~which
    ~n
    ~nev
    (av : (float, a, c_layout) Array1.t -> (float, a, c_layout) Array1.t -> unit)
    : (float, a, c_layout) Genarray.t * (float, a, c_layout) Genarray.t
  =
  match kind with
  | Float32 ->
    let d, z =
      Eigsh.solve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32
    in
    d, Option.get z
  | Float64 ->
    let d, z =
      Eigsh.solve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64
    in
    d, Option.get z


let eigshvals
    (type a)
    (kind : (float, a) Bigarray.kind)
    ?(tol = 0.)
    ?max_iter
    ?ncv
    ~which
    ~n
    ~nev
    (av : (float, a, c_layout) Array1.t -> (float, a, c_layout) Array1.t -> unit)
    : (float, a, c_layout) Genarray.t
  =
  match kind with
  | Float32 ->
    let d, _ =
      Eigsh.solve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32
    in
    d
  | Float64 ->
    let d, _ =
      Eigsh.solve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64
    in
    d


let eigs
    (type a b)
    (kind : (a, b) Bigarray.kind)
    ?(tol = 0.)
    ?max_iter
    ?ncv
    ~which
    ~n
    ~nev
    (av : (a, b, c_layout) Array1.t -> (a, b, c_layout) Array1.t -> unit)
    : (a, b, c_layout) Genarray.t * (a, b, c_layout) Genarray.t
  =
  match kind with
  | Float32   ->
    let d, z =
      Eigs.rsolve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32
    in
    d, Option.get z
  | Float64   ->
    let d, z =
      Eigs.rsolve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64
    in
    d, Option.get z
  | Complex32 ->
    let d, z =
      Eigs.csolve
        ~evecs:true
        ~tol
        ?max_iter
        ?ncv
        ~which
        ~n
        ~nev
        av
        complex32
        float
        Complex32
    in
    d, Option.get z
  | Complex64 ->
    let d, z =
      Eigs.csolve
        ~evecs:true
        ~tol
        ?max_iter
        ?ncv
        ~which
        ~n
        ~nev
        av
        complex64
        double
        Complex64
    in
    d, Option.get z
  | _         -> failwith "eigs: only implemented for float32(64) and complex32(64)"


let eigsvals
    (type a b)
    (kind : (a, b) Bigarray.kind)
    ?(tol = 0.)
    ?max_iter
    ?ncv
    ~which
    ~n
    ~nev
    (av : (a, b, c_layout) Array1.t -> (a, b, c_layout) Array1.t -> unit)
    : (a, b, c_layout) Genarray.t
  =
  match kind with
  | Float32   ->
    Eigs.rsolve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32 |> fst
  | Float64   ->
    Eigs.rsolve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64 |> fst
  | Complex32 ->
    Eigs.csolve
      ~evecs:false
      ~tol
      ?max_iter
      ?ncv
      ~which
      ~n
      ~nev
      av
      complex32
      float
      Complex32
    |> fst
  | Complex64 ->
    Eigs.csolve
      ~evecs:false
      ~tol
      ?max_iter
      ?ncv
      ~which
      ~n
      ~nev
      av
      complex64
      double
      Complex64
    |> fst
  | _         -> failwith "eigs: only implemented for float32(64) and complex32(64)"
