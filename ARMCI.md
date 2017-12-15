
# Choosing the ARMCI Library

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
    the ARMCI interface by Argonne and Intel. It uses the one-sided
    communication features of MPI, rather than a platform-specific
    conduit. It currents provides both MPI-2 and MPI-3 implementations;
    the MPI-3 one is supported by nearly all platforms. See
    <https://wiki.mpich.org/armci-mpi/index.php/Main_Page> for details.

By default, Global Arrays will choose ARMCI or ComEx, based upon the
environment variables selected by the user (see GA documentation for
details). When a native implementation is available and works reliably,
this is the best option for the NWChem user. However, in cases where an
native implementation of ARMCI is not available or is not reliable, the
user should consider using one of the MPI-based implementations.

There are many different ways to use MPI as the communication runtime of
Global
Arrays:

<center>

|                |                       |                                              |                                                                                                 |
| -------------- | --------------------- | -------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ARMCI\_NETWORK | Additional options    | Result                                       | Notes                                                                                           |
| MPI-PR         |                       | ARMCI with progress rank                     | Recommended, except on Blue Gene/Q.                                                             |
| MPI-PT         |                       | ARMCI with progress thread                   | Appropriate for Blue Gene/Q.                                                                    |
| MPI-MT         |                       | ARMCI over multi-threaded MPI                | [Do not use Open-MPI 1.x.](https://github.com/open-mpi/ompi/issues/157)                         |
| MPI-TS         |                       | ARMCI over MPI without data server           |                                                                                                 |
| MPI-SPAWN      |                       | ARMCI over MPI using dynamic processes       | Requires MPI\_Comm\_spawn support.                                                              |
| ARMCI          | EXTERNAL\_ARMCI\_PATH | Uses ARMCI-MPI (please use *mpi3rma* branch) | See [the ARMCI-MPI NWChem page](https://wiki.mpich.org/armci-mpi/index.php/NWChem) for details. |

</center>

It is difficult to provide complete guidance to the user as to which
option to choose. However, we observe the following:

  - ARMCI\_NETWORK=MPI-PR is stable and performs well on many platforms
    (including Cray XC platforms, e.g. NERSC Edison). This port will use
    one processes on each node for communication, therefore subtracting
    one process (again on each node) for NWChem. Therefore, when
    executing on a single node (i.e. the case of desktop execution) you
    would need to ask for n+1 processes; in other words, a serial
    execution would require the following mpirun invocation `mpirun
    -np 2 ...`
  - On Intel True Scale and Omni Path systems, MPI-PR is more reliable
    than OPENIB or MPI-SPAWN. ARMCI-MPI with Casper and Intel MPI is
    also recommended. See [this
    page](https://github.com/jeffhammond/HPCInfo/blob/master/ofi/NWChem-OPA.md)
    for details. Contact [Jeff Hammond](mailto:jeff.r.hammond@intel.com)
    for assistance.
  - On IBM Blue Gene/Q, one must use the *mpi2rma* branch of ARMCI-MPI
    because MPI-3 is not fully supported. On all other platforms, the
    ARMCI-MPI branch *mpi3rma* is recommended.
  - The performance of ARMCI-MPI is greatly enhanced by
    [Casper](http://www.mcs.anl.gov/project/casper/). See [this
    link](http://www.mcs.anl.gov/publication/casper-asynchronous-progress-model-mpi-rma-many-core-architectures)
    for design details and [this
    page](https://wiki.mpich.org/armci-mpi/index.php/Casper) for
    instructions on how to use it.

When using ARMCI-MPI, please make sure to use the most recent version of
MPI (MPICH 3.2+, Cray MPI 7.2+, MVAPICH2 2.0+, Intel MPI 5.1+, Open-MPI
2.0+). Older versions of MPI are known to have bugs in the MPI-3 RMA
features that affect the correctness of NWChem.

## Support

Global Arrays, ARMCI and ComEx are developed and supported by PNNL. The
user list for support is <hpctools@googlegroups.com>.

ARMCI-MPI is developed by Argonne and Intel. All ARMCI-MPI questions
should be directed to <armci-discuss@lists.mpich.org>. *ARMCI-MPI is not
an Intel product.*

## Automated installation of ARMCI-MPI

If you wish to use ARMCI-MPI, a script is available to automatically
install it:

`cd $NWCHEM_TOP/tools && ./install-armci-mpi`
