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
    let evecs, evals =
      Eigsh.solve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32
    in
    Option.get evecs, evals
  | Float64 ->
    let evecs, evals =
      Eigsh.solve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64
    in
    Option.get evecs, evals


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
    Eigsh.solve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32 |> snd
  | Float64 ->
    Eigsh.solve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64 |> snd


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
    let evecs, evals =
      Eigs.rsolve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32
    in
    Option.get evecs, evals
  | Float64   ->
    let evecs, evals =
      Eigs.rsolve ~evecs:true ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64
    in
    Option.get evecs, evals
  | Complex32 ->
    let evecs, evals =
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
    Option.get evecs, evals
  | Complex64 ->
    let evecs, evals =
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
    Option.get evecs, evals
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
    Eigs.rsolve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av float Float32 |> snd
  | Float64   ->
    Eigs.rsolve ~evecs:false ~tol ?max_iter ?ncv ~which ~n ~nev av double Float64 |> snd
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
    |> snd
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
    |> snd
  | _         -> failwith "eigs: only implemented for float32(64) and complex32(64)"
