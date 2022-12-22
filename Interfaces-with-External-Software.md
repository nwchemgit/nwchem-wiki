# Interfaces with External Software

NWChem can be interfaced with external software packages by following the instructions below.

## Simint integrals library

To Generate [Simint](https://www.bennyp.org/research/simint/)
library and enable NWChem interface (only for energy and first derivative code),
you need to define the following environment variables at compile time:  
- `USE_SIMINT=y` (mandatory)
- `SIMINT_MAXAM=`"Maximum angular momentum" (optional, default is 3, therefore up to f orbitals)   

The following set directives are required in the input file to trigger use of Simint
```
set int:cando_txs f
set int:cando_nw f
```


## OpenBLAS

To build NWChem with the optimized BLAS and Lapack [OpenBLAS](https://github.com/xianyi/OpenBLAS) library,
you need to define the following environment variables at compile time:  
```
BUILD_OPENBLAS=1
BLAS_SIZE=8
```

## ScaLAPACK

To build NWChem with the [ScaLAPACK](https://github.com/Reference-ScaLAPACK/scalapack) library,
you need to define the following environment variables at compile time:  


```
BUILD_SCALAPACK=1
SCALAPACK_SIZE=8
```

## ELPA

To build NWChem with the [ELPA](https://gitlab.mpcdf.mpg.de/elpa/elpa) eigensolver library,
you need first to set the ScaLAPACK settings as describe in the previous [section](#ScaLAPACK) and
then you need to define the following environment variables at compile time:  

```
BUILD_ELPA=1
```


## Plumed


## LibXC


## XTB