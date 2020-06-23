# OCaml Bindings to ARPACK-NG

This is a light-weight OCaml wrapper to [ARPACK-NG](https://github.com/opencollab/arpack-ng).


## Dependencies

### ARPACK-NG
Build ARPACK-NG with `iso_c_binding` support:

```sh
git clone https://github.com/opencollab/arpack-ng.git
cd arpack-ng
mkdir build
cd build
cmake -D MPI=ON -D BUILD_SHARED_LIBS=ON -D ICB=ON -D CMAKE_INSTALL_PREFIX=/usr/local/opt/arpack ..
make && make install
```
Currently, it is assumed that arpack is install in `/usr/local/opt/arpack`. This assumption will be relaxed in the future, for example with the use of `pkg-conifg`.

