open Owl

let n = 10
let nev = 3
let adiag = Mat.(gaussian 1 n) |> Mat.sort
let a = Mat.(diagm adiag)

let av x y =
  let x = Bigarray.genarray_of_array1 x |> fun x -> Mat.reshape x [| -1; 1 |] in
  let tmp = Mat.(a *@ x) |> fun x -> Mat.reshape x [| -1 |] in
  Bigarray.Array1.blit Bigarray.(array1_of_genarray tmp) y


let d, z = Arpack.D.eigs ~tol:0. ~which:`LM ~n ~nev av

let () =
  Mat.print d;
  Mat.print adiag
