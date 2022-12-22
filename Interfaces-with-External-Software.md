# Interfaces with External Software

NWChem can be interfaced with external software packages by following the instructions below.

## Simint integrals library

To generate the [Simint](https://www.bennyp.org/research/simint/)
library and enable the NWChem interface (only for energy and first derivative code),
you need to define the following environment variables at compile time:  
* `USE_SIMINT=y` (mandatory)   
* `SIMINT_MAXAM=`"Maximum angular momentum" (optional, default is 3, therefore up to f orbitals)   

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
you need first to set the ScaLAPACK settings as described in the previous [section](#ScaLAPACK) and
then you need to define the following environment variables at compile time:  

```
BUILD_ELPA=1
```


## Plumed

The `BUILD_PLUMED` environment variable installs [Plumed](https://www.plumed.org/) and
interfaces it with the [qmd](Gaussian-Basis-AIMD.md) module.

## Libxc

Building NWChem with the [libxc](https://www.tddft.org/programs/libxc/) DFT library requires
setting the environment variable `USE_LIBXC=1`

If you wish to use an existing libxc library, the following environment variables must be set:
* `LIBXC_INCLUDE`  
* `LIBXC_LIB`    


## XTB

[Light-weight tight-binding framework](tblite.readthedocs.io)

environment variable `USE_TBLITE=1`

add `xtb` to `NWCHEM_MODULES`

Example:
```
make nwchem_config NWCHEM_MODULES='tinyqmpw xtb'
export USE_TBLITE=1
make
```