open Ctypes

module RealMake
    (F : Ctypes.FOREIGN) (P : sig
      val elt_typ : float typ
      val saupd : string
      val seupd : string
      val naupd : string
      val neupd : string
    end) =
struct
  open F

  let saupd =
    F.foreign
      P.saupd
      ((* ido *)
       ptr int
      (* bmat *)
      @-> string
      (* n *)
      @-> int
      (* which *)
      @-> string
      (* nev *)
      @-> int
      (* tol *)
      @-> P.elt_typ
      (* resid*)
      @-> ptr P.elt_typ
      (* ncv *)
      @-> int
      (* v *)
      @-> ptr P.elt_typ
      (* ldv *)
      @-> int
      (* iparam *)
      @-> ptr int
      (* ipntr *)
      @-> ptr int
      (* workd *)
      @-> ptr P.elt_typ
      (* workl *)
      @-> ptr P.elt_typ
      (* lworkl *)
      @-> int
      (* info *)
      @-> ptr int
      (* returns nothing *)
      @-> returning void)


  let seupd =
    foreign
      P.seupd
      ((* rvec *)
       int
      (* howmny *)
      @-> string
      (* select *)
      @-> ptr int
      (* d *)
      @-> ptr P.elt_typ
      (* z *)
      @-> ptr P.elt_typ
      (* ldz *)
      @-> int
      (* sigma *)
      @-> P.elt_typ
      (* bmat *)
      @-> string
      (* n *)
      @-> int
      (* which *)
      @-> string
      (* nev *)
      @-> int
      (* tol *)
      @-> P.elt_typ
      (* resid *)
      @-> ptr P.elt_typ
      (* ncv *)
      @-> int
      (* v *)
      @-> ptr P.elt_typ
      (* ldv *)
      @-> int
      (* iparam *)
      @-> ptr int
      (* ipntr *)
      @-> ptr int
      (* workd *)
      @-> ptr P.elt_typ
      (* workl *)
      @-> ptr P.elt_typ
      (* lworkl *)
      @-> int
      (* info *)
      @-> ptr int
      (* returninv void *)
      @-> returning void)


  let naupd =
    foreign
      P.naupd
      ((* ido*)
       ptr int
      (* bmat *)
      @-> string
      (* n *)
      @-> int
      (* which *)
      @-> string
      (* nev *)
      @-> int
      (* tol *)
      @-> P.elt_typ
      (* resid *)
      @-> ptr P.elt_typ
      (* ncv *)
      @-> int
      (* v *)
      @-> ptr P.elt_typ
      (* ldv *)
      @-> int
      (* iparam *)
      @-> ptr int
      (* ipntr *)
      @-> ptr int
      (* workd *)
      @-> ptr P.elt_typ
      (* workl *)
      @-> ptr P.elt_typ
      (* lworkl *)
      @-> int
      (* info *)
      @-> ptr int
      (* returning void *)
      @-> returning void)


  let neupd =
    F.foreign
      P.neupd
      ((* rvec *)
       int
      (* howmny *)
      @-> string
      (* select *)
      @-> ptr int
      (* dr *)
      @-> ptr P.elt_typ
      (* di *)
      @-> ptr P.elt_typ
      (* z *)
      @-> ptr P.elt_typ
      (* ldz *)
      @-> int
      (* sigmar *)
      @-> P.elt_typ
      (* sigmai *)
      @-> P.elt_typ
      (* workev *)
      @-> ptr P.elt_typ
      (* bmat *)
      @-> string
      (* n *)
      @-> int
      (* which *)
      @-> string
      (* nev *)
      @-> int
      (* tol *)
      @-> P.elt_typ
      (* resid *)
      @-> ptr P.elt_typ
      (* ncv *)
      @-> int
      (* v *)
      @-> ptr P.elt_typ
      (* ldv *)
      @-> int
      (* iparam *)
      @-> ptr int
      (* ipntr *)
      @-> ptr int
      (* workd *)
      @-> ptr P.elt_typ
      (* workl *)
      @-> ptr P.elt_typ
      (* lworkl *)
      @-> int
      (* info *)
      @-> ptr int
      (* returninv void *)
      @-> returning void)
end

module ComplexMake
    (F : Ctypes.FOREIGN) (P : sig
      val elt_typ : Complex.t typ
      val real_elt_typ : float typ
      val naupd : string
      val neupd : string
    end) =
struct
  open F

  let naupd =
    foreign
      P.naupd
      ((* ido*)
       ptr int
      (* bmat *)
      @-> string
      (* n *)
      @-> int
      (* which *)
      @-> string
      (* nev *)
      @-> int
      (* tol *)
      @-> P.real_elt_typ
      (* resid *)
      @-> ptr P.elt_typ
      (* ncv *)
      @-> int
      (* v *)
      @-> ptr P.elt_typ
      (* ldv *)
      @-> int
      (* iparam *)
      @-> ptr int
      (* ipntr *)
      @-> ptr int
      (* workd *)
      @-> ptr P.elt_typ
      (* workl *)
      @-> ptr P.elt_typ
      (* lworkl *)
      @-> int
      (* rwork *)
      @-> ptr P.real_elt_typ
      (* info *)
      @-> ptr int
      (* returning void *)
      @-> returning void)


  let neupd =
    F.foreign
      P.neupd
      ((* rvec *)
       int
      (* howmny *)
      @-> string
      (* select *)
      @-> ptr int
      (* d *)
      @-> ptr P.elt_typ
      (* z *)
      @-> ptr P.elt_typ
      (* ldz *)
      @-> int
      (* sigma *)
      @-> P.elt_typ
      (* workev *)
      @-> ptr P.elt_typ
      (* bmat *)
      @-> string
      (* n *)
      @-> int
      (* which *)
      @-> string
      (* nev *)
      @-> int
      (* tol *)
      @-> P.real_elt_typ
      (* resid *)
      @-> ptr P.elt_typ
      (* ncv *)
      @-> int
      (* v *)
      @-> ptr P.elt_typ
      (* ldv *)
      @-> int
      (* iparam *)
      @-> ptr int
      (* ipntr *)
      @-> ptr int
      (* workd *)
      @-> ptr P.elt_typ
      (* workl *)
      @-> ptr P.elt_typ
      (* lworkl *)
      @-> int
      (* rwork *)
      @-> ptr P.real_elt_typ
      (* info *)
      @-> ptr int
      (* returninv void *)
      @-> returning void)
end

module Bindings (F : Ctypes.FOREIGN) = struct
  module S =
    RealMake
      (F)
      (struct
        let elt_typ = Ctypes.float
        let saupd = "ssaupd_c"
        let seupd = "sseupd_c"
        let naupd = "snaupd_c"
        let neupd = "sneupd_c"
      end)

  module D =
    RealMake
      (F)
      (struct
        let elt_typ = Ctypes.double
        let saupd = "dsaupd_c"
        let seupd = "dseupd_c"
        let naupd = "dnaupd_c"
        let neupd = "dneupd_c"
      end)

  module C =
    ComplexMake
      (F)
      (struct
        let elt_typ = complex32
        let real_elt_typ = float
        let naupd = "cnaupd_c"
        let neupd = "cneupd_c"
      end)

  module Z =
    ComplexMake
      (F)
      (struct
        let elt_typ = complex64
        let real_elt_typ = double
        let naupd = "znaupd_c"
        let neupd = "zneupd_c"
      end)
end
