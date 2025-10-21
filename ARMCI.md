
# Choosing the ARMCI Library

## Overview

The Global Arrays parallel environment relies upon a one-sided
communication runtime system. There are at least three options currently
available:

  - ARMCI - This is the original one-sided library developed with Global
    Arrays by PNNL. It supports the widest range of platforms. See
    <http://hpc.pnl.gov/globalarrays/support.shtml> for details.
  - ComEx - This library is being developed by PNNL to replace ARMCI. It
    supports the fewer platforms than ARMCI but may be more robust on
    modern ones like InfiniBand. See
    <http://hpc.pnl.gov/globalarrays/support.shtml> for details.
  - ARMCI-MPI - This library is a completely separate implementation of
    the ARMCI interface maintained by Jeff Hammond. It uses the one-sided
    communication features of MPI, rather than a platform-specific
    conduit. It currents provides both MPI-2 and MPI-3 implementations;
    the MPI-3 one is supported by nearly all platforms. See
    <https://www.mpi-forum.org/implementation-status/> for details.

By default, Global Arrays will choose ARMCI or ComEx, based upon the
environment variables selected by the user (see GA documentation for
details). When a native implementation is available and works reliably,
this is the best option for the NWChem user. However, in cases where an
native implementation of ARMCI is not available or is not reliable, the
user should consider using one of the MPI-based implementations.

There are many different ways to use MPI as the communication runtime of
Global Arrays:

 

| ARMCI_NETWORK  | Result                                       | Notes                      |             
| :------------- | :------------------------------------------- | :------------------------- |                             
| `MPI-PR`       | ARMCI with progress rank                     | High-performance option. |
| `MPI-PT`       | ARMCI with progress thread                   | Not recommended. |
| `MPI-MT`       | ARMCI over multi-threaded MPI                | [Do not use Open-MPI 1.x.](https://github.com/open-mpi/ompi/issues/157) |
| `MPI-TS`       | ARMCI over MPI without data server           | Universally portable but not always high-performance. |
| `MPI-SPAWN`    | ARMCI using MPI dynamic processes            | Not recommended.  Requires MPI_Comm_spawn support. |
| `ARMCI`        | Uses ARMCI-MPI. Requires `EXTERNAL_ARMCI_PATH`. | See <https://github.com/pmodels/armci-mpi> for details. |
 

It is difficult to provide complete guidance to the user as to which
option to choose. However, we observe the following:

  - `ARMCI_NETWORK=MPI-PR` is stable and performs well on many platforms
    (including Cray XC platforms, e.g. NERSC Cori). This port will use
    one processes on each node for communication, therefore subtracting
    one process (again on each node) for NWChem. Therefore, when
    executing on a single node (i.e. the case of desktop execution) you
    would need to ask for n+1 processes; in other words, a serial
    execution would require the following mpirun invocation `mpirun -np 2 ...`  
  - On Intel Omni Path systems, `MPI-PR` is more reliable
    than `OPENIB` or `MPI-SPAWN`. `ARMCI-MPI` with Casper and Intel MPI is
    also recommended. See [this page](https://github.com/jeffhammond/HPCInfo/blob/master/ofi/NWChem-OPA.md)
    for details.
  - The performance of `ARMCI-MPI` is greatly enhanced by
    [Casper](https://pmodels.github.io/casper-www/). See [this
    link](https://pmodels.github.io/casper-www/publication.html) 
    for design details.

When using ARMCI-MPI, please make sure to use the most recent version of
MPI (MPICH 3.2+, Cray MPI 7.2+, MVAPICH2 2.0+, Intel MPI 5.1+, Open-MPI
2.0+). Older versions of MPI are known to have bugs in the MPI-3 RMA
features that affect the correctness of NWChem.

## Support

Global Arrays, ARMCI and ComEx are developed and supported by PNNL.
Use <https://github.com/GlobalArrays/ga/issues> for support.

ARMCI-MPI is maintained by Jeff Hammond.
Use <https://github.com/pmodels/armci-mpi/issues> for support.

## Automated installation of ARMCI-MPI

If you wish to use ARMCI-MPI, a script is available to automatically
install it:
```
cd $NWCHEM_TOP/tools && ./install-armci-mpi
```
