# Interfaces with External Software

## Overview

NWChem can be interfaced with external software packages by following the instructions below.

The interface can be set either using a pre-exisiting software package or
by downloading and compiling the software from the NWChem makefile infrastructure.  

## Simint integrals library

To generate the [Simint](https://www.bennyp.org/research/simint/)
library and enable the NWChem interface (only for energy and first derivative code),
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

This procedure requires an internet connection to dowload the OpenBLAS source.    
Instead, to use a pre-compiled OpenBLAS library, the `BLASOPT`, `LAPACK_LIB` and `BLAS_SIZE` environment variable need to be set.

## ScaLAPACK

To build NWChem with the [ScaLAPACK](https://github.com/Reference-ScaLAPACK/scalapack) library,
you need to define the following environment variables at compile time:  

```
BUILD_SCALAPACK=1
SCALAPACK_SIZE=8
```
This procedure requires an internet connection to dowload the OpenBLAS source.    
Instead, to use a pre-compiled ScaLAPACK library, the `SCALAPACK_LIB`  and `SCALAPACK_SIZE` environment variable need to be set.

## ELPA

To build NWChem with the [ELPA](https://gitlab.mpcdf.mpg.de/elpa/elpa) eigensolver library,
you need first to set the ScaLAPACK settings as described in the previous [section](#ScaLAPACK) and
then you need to define the following environment variables at compile time:  

```
BUILD_ELPA=1
```
This procedure requires an internet connection to dowload the OpenBLAS source.   
Instead, to use a pre-compiled ELPA library, the `ELPA`  and `ELPA_SIZE` environment variable need to be set.

## Plumed

The `BUILD_PLUMED` environment variable installs [Plumed](https://www.plumed.org/) and
interfaces it with the [qmd](Gaussian-Basis-AIMD.md) module.
This procedure requires an internet connection to dowload the Plumed source.

Instead, if you wish to use an existing Plumed install, the following environment variables must be set (after having unset `BUILD_PLUMED`: 
```
USE_PLUMED=1
```
Requirements:
* The environment variable `PATH` should to point to the location of the `plumed` command  and `LD_LIBRARY_PATH` should point to the location of the plumed libraries.
* `BLAS_SIZE` and `SCALAPACK_SIZE` must be equal to 4 (this is not a requirement when using `BUILD_PLUMED`)

## Libxc

Building NWChem with the [libxc](https://www.tddft.org/programs/libxc/) DFT library requires
setting the environment variable `USE_LIBXC=1`. 

This procedure requires an internet connection to dowload the Libxc source.

Instead, if you wish to use an existing libxc library, the following environment variables must be set, after having unset `USE_LIBXC`:   

 * `LIBXC_INCLUDE`   location of the libxc C header files
 * `LIBXC_MODDIR`   location of the libxc fortran90 module files
 * `LIBXC_LIB`     location of the libxc libraries files

For example, for Debian/Ubuntu systems, the following is needed after having installed the `libxc-dev` package
```
    unset USE_LIBXC
    export LIBXC_LIB=/usr/lib/x86_64-linux-gnu
    export LIBXC_INCLUDE=/usr/include
```
For example, for Fedora systems, the following is needed after having installed the `libxc-devel` package
```
    unset USE_LIBXC
    export LIBXC_LIB=/usr/lib64
    export LIBXC_INCLUDE=/usr/include 
    export LIBXC_MODDIR=/usr/lib64/gfortran/modules
```


## XTB

Building NWChem with the Light-weight tight-binding framework [tblite](https://tblite.readthedocs.io)
requires  

* setting theenvironment variable `USE_TBLITE=1`
* adding `xtb` to list of `NWCHEM_MODULES`

Example:
```
make nwchem_config NWCHEM_MODULES='tinyqmpw xtb'
export USE_TBLITE=1
make
```
