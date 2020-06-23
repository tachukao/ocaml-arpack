open Bigarray

module type Real = sig
  type elt

  val eigsh
    :  ?tol:float
    -> ?max_iter:int
    -> ?ncv:int
    -> which:[< `BE | `LA | `LM | `SA | `SM ]
    -> n:int
    -> nev:int
    -> ((float, elt, c_layout) Array1.t -> (float, elt, c_layout) Array1.t -> unit)
    -> (float, elt, c_layout) Genarray.t * (float, elt, c_layout) Genarray.t

  val eigshvals
    :  ?tol:float
    -> ?max_iter:int
    -> ?ncv:int
    -> which:[< `BE | `LA | `LM | `SA | `SM ]
    -> n:int
    -> nev:int
    -> ((float, elt, c_layout) Array1.t -> (float, elt, c_layout) Array1.t -> unit)
    -> (float, elt, c_layout) Genarray.t

  val eigs
    :  ?tol:float
    -> ?max_iter:int
    -> ?ncv:int
    -> which:[< `LI | `LM | `SI | `SM | `SR ]
    -> n:int
    -> nev:int
    -> ((float, elt, c_layout) Array1.t -> (float, elt, c_layout) Array1.t -> unit)
    -> (float, elt, c_layout) Genarray.t * (float, elt, c_layout) Genarray.t

  val eigsvals
    :  ?tol:float
    -> ?max_iter:int
    -> ?ncv:int
    -> which:[< `LI | `LM | `SI | `SM | `SR ]
    -> n:int
    -> nev:int
    -> ((float, elt, c_layout) Array1.t -> (float, elt, c_layout) Array1.t -> unit)
    -> (float, elt, c_layout) Genarray.t
end

module type Complex = sig
  type elt

  val eigs
    :  ?tol:float
    -> ?max_iter:int
    -> ?ncv:int
    -> which:[< `LI | `LM | `SI | `SM | `SR ]
    -> n:int
    -> nev:int
    -> ((Complex.t, elt, c_layout) Array1.t
        -> (Complex.t, elt, c_layout) Array1.t
        -> unit)
    -> (Complex.t, elt, c_layout) Genarray.t * (Complex.t, elt, c_layout) Genarray.t

  val eigsvals
    :  ?tol:float
    -> ?max_iter:int
    -> ?ncv:int
    -> which:[< `LI | `LM | `SI | `SM | `SR ]
    -> n:int
    -> nev:int
    -> ((Complex.t, elt, c_layout) Array1.t
        -> (Complex.t, elt, c_layout) Array1.t
        -> unit)
    -> (Complex.t, elt, c_layout) Genarray.t
end
