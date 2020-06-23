open Bigarray

val eigsh
  :  (float, 'a) kind
  -> ?tol:float
  -> ?max_iter:int
  -> ?ncv:int
  -> which:[< `BE | `LA | `LM | `SA | `SM ]
  -> n:int
  -> nev:int
  -> ((float, 'a, c_layout) Array1.t -> (float, 'a, c_layout) Array1.t -> unit)
  -> (float, 'a, c_layout) Genarray.t * (float, 'a, c_layout) Genarray.t

val eigshvals
  :  (float, 'a) kind
  -> ?tol:float
  -> ?max_iter:int
  -> ?ncv:int
  -> which:[< `BE | `LA | `LM | `SA | `SM ]
  -> n:int
  -> nev:int
  -> ((float, 'a, c_layout) Array1.t -> (float, 'a, c_layout) Array1.t -> unit)
  -> (float, 'a, c_layout) Genarray.t

val eigs
  :  ('a, 'b) kind
  -> ?tol:float
  -> ?max_iter:int
  -> ?ncv:int
  -> which:[< `LI | `LM | `SI | `SM | `SR ]
  -> n:int
  -> nev:int
  -> (('a, 'b, c_layout) Array1.t -> ('a, 'b, c_layout) Array1.t -> unit)
  -> ('a, 'b, c_layout) Genarray.t * ('a, 'b, c_layout) Genarray.t

val eigsvals
  :  ('a, 'b) kind
  -> ?tol:float
  -> ?max_iter:int
  -> ?ncv:int
  -> which:[< `LI | `LM | `SI | `SM | `SR ]
  -> n:int
  -> nev:int
  -> (('a, 'b, c_layout) Array1.t -> ('a, 'b, c_layout) Array1.t -> unit)
  -> ('a, 'b, c_layout) Genarray.t
