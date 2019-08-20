# Compiling NWChem from source

On this page, a step-by-step description of the build process and
necessary and optional environment variables is outlined. In addition,
based on the experiences of developers and users how-to's for various
platforms have been created. These how-to's will be updated with
additional platforms and better environment variables over time.

## Setting up the proper environment variables

  - **NWCHEM\_TOP** defines the top directory of the NWChem source tree,
    e.g.

When dealing with source from a ***NWChem release*** (6.8 in this
example)
```
export NWCHEM_TOP=<your path>/nwchem-6.8
```
when using the ***NWChem development*** source
```
export NWCHEM_TOP=<your path>/nwchem
```
  - $NWCHEM\_TARGET defines your target platform, e.g.
```
export NWCHEM_TARGET=LINUX64
```
<table>
<caption>The platforms that available are:</caption>
<tbody>
<tr class="odd">
<td><p>NWCHEM_TARGET</p></td>
<td><p>Platform</p></td>
<td><p>OS/Version</p></td>
<td><p>Compilers</p></td>
</tr>
<tr class="even">
<td><p>LINUX</p></td>
<td><p>x86<br />
ppc<br/>
arm</p></td>
<td><p>RedHat, Suse<br />
Suse</p></td>
<td><p>GNU, Intel, PGI<br />
GNU, xlf</p></td>
</tr>
<tr class="odd">
<td><p>LINUX64</p></td>
<td><p>ia64<br />
x86_64<br />
ppc64</br>
ppc64le</br>
aarch64</p></td>
<td><p>RedHat<br />
SLES, RedHat<br />
SLES, RedHat</p></td>
<td><p>Intel<br />
GNU, PGI, PathScale, Intel<br />
xlf</p></td>
</tr>
<tr class="even">
<td><p>BGL<br />
BGP<br />
BGQ</p></td>
<td><p>Blue Gene/L<br />
Blue Gene/P<br />
Blue Gene/Q</p></td>
<td><p>SLES (login) CNK (compute)</p></td>
<td><p>blrts_xlf<br />
bgxlf_r<br />
bgxlf_r</p></td>
</tr>
<tr class="odd">
<td><p>LAPI<br />
LAPI64</p></td>
<td><p>IBM SP</p></td>
<td><p>AIX/LAPI</p></td>
<td><p>xlf</p></td>
</tr>
<tr class="even">
<td><p>MACX<br />
MACX64</p></td>
<td><p>Apple MacOSX</p></td>
<td><p>OSX</p></td>
<td><p>GNU, xlf, Intel</p></td>
</tr>
<tr class="odd">
<td>CYGWIN<br />
</td>
<td><p>Intel x86</p></td>
<td><p>Windows with Cygwin<br />
Windows</p></td>
<td><p>GNU</p></td>
</tr>
<tr class="even">
</tr>
</tbody>
</table>

  - **ARMCI\_NETWORK** must be defined in order to achieve best
    performance on high performance networks, e.g.
```
export ARMCI_NETWORK=OPENIB
```
For a single processor system, this environment variable does not have
to be defined.

<table>
<caption>Supported combination of ARMCI_NETWORK and NWCHEM_TARGET variables:</caption>
<tbody>
<tr class="odd">
<td><p>ARMCI_NETWORK</p></td>
<td><p>NWCHEM_TARGET</p></td>
<td><p>Network</p></td>
<td><p>Protocol</p></td>
</tr>
<tr class="even">
<td><p>OPENIB</p></td>
<td><p>LINUX, LINUX64</p></td>
<td><p>Mellanox InfiniBand</p></td>
<td><p>Verbs</p></td>
</tr>
<tr class="odd">
<td><p>MPI-PR</td>
<td><p>LINUX64</p></td>
<td><p>Any network</p></td>
<td><p>MPI</p></td>
</tr>
<tr class="even">
<td><p>MPI-MT<br />
MPI-SPAWN</p></td>
<td><p>LINUX64</p></td>
<td><p>MPI support multi-threading multiple</p></td>
<td><p>MPI-2</p></td>
</tr>
<tr class="odd">
<td><p>MPI-TS</p></td>
<td><p>any</p></td>
<td><p>any network with MPI</p></td>
<td><p>MPI</p></td>
</tr>
<tr class="even">
<td><p>MPI-PT</p></td>
<td><p>any</p></td>
<td><p>any network with MPI</p></td>
<td><p>MPI</p></td>
</tr>
<tr class="odd">
<td><p>DMAPP</p></td>
<td><p>LINUX64</p></td>
<td><p>Cray Gemini &amp; Aries</p></td>
<td><p>Cray DMAPP</p></td>
</tr>
<tr class="even">
<td><p>GEMINI</p></td>
<td><p>LINUX64</p></td>
<td><p>Cray Gemini</p></td>
<td><p>Cray libonesided</p></td>
</tr>
<tr class="odd">
<td><p>PORTALS</p></td>
<td><p>LINUX64</p></td>
<td><p>Cray SeaStar/HyperTransport</p></td>
<td><p>Cray Portals3</p></td>
</tr>
<tr class="even">
<td><p>BGMLMPI</p></td>
<td><p>BGL</p></td>
<td><p>IBM Blue Gene/L</p></td>
<td><p>BGLMPI</p></td>
</tr>
<tr class="odd">
<td><p>DCMFMPI</p></td>
<td><p>BGP</p></td>
<td><p>IBM Blue Gene/P</p></td>
<td><p>DCMF, MPI</p></td>
</tr>
<tr class="odd">
</tr>
</tbody>
</table>

Please see [Choosing the ARMCI Library](ARMCI "wikilink") for
additional information on choosing the right network
options.

### MPI variables

|              |                                                                                                                                  |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| USE\_MPI     | Set to "y" to indicate that NWChem should be compiled with MPI                                                                   |
| USE\_MPIF    | Set to "y" for the NWPW module to use fortran-bindings of MPI (Generally set when USE\_MPI is set)                               |
| USE\_MPIF4   | Set to "y" for the NWPW module to use Integer\*4 fortran-bindings of MPI. (Generally set when USE\_MPI is set on most platforms) |
| LIBMPI       | Name of the MPI library that should be linked with -l (eg. -lmpich)                                                              |
| MPI\_LIB     | Directory where the MPI library resides                                                                                          |
| MPI\_INCLUDE | Directory where the MPI include files reside                                                                                     |
|  |

**<span style="color:#FF0000">New in NWChem 6.6</span>**: If the
location of the mpif90 command is part of your PATH env. variable,
NWChem will figure out the values of LIBMPI, MPI\_LIB and MPI\_INCLUDE
(if they are not set). Therefore, we do **NOT** recommend to set LIBMPI,
MPI\_LIB and MPI\_INCLUDE and add the location of mpif90 to the PATH
variable, instead.

The output of the command

` mpif90 -show`

can be used to extract the values of LIBMPI, MPI\_LIB and MPI\_INCLUDE

E.g. for MPICH2, this might look
like:
```
$ mpif90 -show
f95 -I/usr/local/mpich2.141p1/include -I/usr/local/mpich2.141p1/include -L/usr/local/mpich2.141p1/lib \
-lmpichf90 -lmpichf90 -lmpich -lopa -lmpl -lrt -lpthread
```
The corresponding environment variables
are
```
  % setenv USE_MPI y
  % setenv LIBMPI "-lmpich -lopa -lmpl -lpthread -lmpichf90 -lfmpich -lmpich"
  % setenv MPI_LIB /usr/local/mpich2.141p1/lib 
  % setenv MPI_INCLUDE '/usr/local/mpich2.141p1/include
```
Note: a script is available in NWChem 6.5 to extract the environment variables listed above

$NWCHEM\_TOP/contrib/distro-tools/getmpidefs\_nwchem

<table>
<caption>For some specific implementations the settings for MPI_LIB, MPI_INCLUDE, and LIBMPI look like:</caption>
<tbody>
<tr class="odd">
<td><p>MPI Implementation</p></td>
<td><p>Environment variables</p></td>
</tr>
<tr class="even">
<td><p>MPICH</p></td>
<td><p>setenv MPI_LOC /usr/local #location of mpich installation<br />
setenv MPI_LIB $MPI_LOC/lib<br />
setenv MPI_INCLUDE $MPI_LOC/include<br />
setenv LIBMPI &quot;-lfmpich -lmpich -lpmpich&quot;</p></td>
</tr>
<tr class="odd">
<td><p>MPICH2</p></td>
<td><p>setenv MPI_LOC /usr/local #location of mpich2 installation<br />
setenv MPI_LIB $MPI_LOC/lib<br />
setenv MPI_INCLUDE $MPI_LOC/include<br />
setenv LIBMPI &quot;-lmpich -lopa -lmpl -lrt -lpthread&quot;</p></td>
</tr>
<tr class="even">
<td><p>OPENMPI</p></td>
<td><p>setenv MPI_LOC /usr/local #location of openmpi installation<br />
setenv MPI_LIB $MPI_LOC/lib<br />
setenv MPI_INCLUDE $MPI_LOC/include<br />
setenv LIBMPI &quot;-lmpi_f90 -lmpi_f77 -lmpi -ldl -Wl,--export-dynamic -lnsl -lutil&quot;</p></td>
</tr>
<tr class="odd">
</tr>
</tbody>
</table>

Note:

When MPI is used, the appropriate MPI run command should be used to
start an NWChem calculation, e.g.
```
  % mpirun -np 8 $NWCHEM_TOP/bin/${NWCHEM_TARGET}}/nwchem h2o.nw
```
When all nodes are connected via shared memory and the ch\_shmem version
of MPICH is installed and used, NWChem can be called directly, e.g.
```
  % $NWCHEM_TOP/bin/${NWCHEM_TARGET}/nwchem -np 8 h2o.nw
```
  - **NWCHEM\_MODULES** defines the modules to be compiled, e.g.
```
export NWCHEM_MODULES="all python"
```
The following modules are available:

|            |                               |
| ---------- | ----------------------------- |
| Module     | Description                   |
| all        | Everything useful             |
| all python | Everything useful plus python |
| qm         | All quantum mechanics modules |
| md         | MD only build                 |
|  |


Note that additional environment variables need to be defined to specify
the location of the Python libraries, when the python module is
compiled. See the optional environmental variables section for
specifics.

## Adding optional environmental variables

**USE\_NOFSCHECK** can be set to avoid NWChem creating files for each
process when testing the size of the scratch directory (a.k.a. creation
of junk files), e.g.
```
export USE_NOFSCHECK=TRUE
```
**USE\_NOIO** can be set to avoid NWChem 6.5 doing I/O for the ddscf,
mp2 and ccsd modules (it automatically sets USE\_NOFSCHECK, too). It is
strongly recommended on large clusters or supercomputers or any computer
lacking any fast and large local filesystem.
```
export USE_NOIO=TRUE
```
**LIB\_DEFINES** can be set to pass additional defines to the C
preprocessor (for both Fortran and C), e.g.
```
export LIB_DEFINES=-DDFLT_TOT_MEM=16777216
```
Note: -DDFLT\_TOT\_MEM sets the default dynamic memory available for
NWChem to run, where the units are in doubles. Instead of manually
defining these one can optionally use the `getmem.nwchem` script in the
$NWCHEM\_TOP/contrib directory. This script should be run after an
initial build of the binary has been completed. The script will assess
memory availability and make an educated guess, recompile the
appropriate files and relink.

**MRCC\_METHODS** can be set to request the multireference coupled
cluster capability to be included in the code, e.g.
```
export MRCC_METHODS=TRUE
```
**Setting Python environment variables**

Python programs may be embedded into the NWChem input and used to
control the execution of NWChem. To build with Python, Python needs to
be available on your machine. The software can be download from
<http://www.python.org> . Follow the Python instructions for
installation and testing. NWChem has been tested with Python versions
1.x and 2.x.

The following environment variables need to be set when compiling with
Python:
```
export PYTHONHOME=/usr/local/Python-1.5.1
export PYTHONVERSION=1.5
```
Note that the third number in the version should not be kept: 2.2.3
should be set as 2.2

**<span style="color:#FF0000">New in NWChem 6.6</span>**: By setting the
env. variable
```
USE_PYTHONCONFIG=Y
```
all the linking bits should be picked up, therefore you will not need to
set any further env .variable other than PYTHONHOME and PYTHONVERSION
(and safely ignore the rest of this paragraph)

The following env. variables might be required
```
export USE_PYTHON64= y
export PYTHONLIBTYPE=so
export PYTHONCONFIGDIR=config-x86_64-linux-gnu
```
USE\_PYTHON64 is needed on platforms were the Python library is found
under the /usr/lib64 tree instead of /usr/lib (e.g. 64-bit RHEL6:
/usr/lib64/python2.6/config/libpython2.6.so).

PYTHONLIBTYPE=so needs to be set when static libraries are not present,
and shared libraries needs to be used, instead
(/usr/lib64/python2.6/config/libpython2.6.a vs
/usr/lib64/python2.6/config/libpython2.6.so).

PYTHONCONFIGDIR needs to be set when the name of the subdirectory
containing the Python library is not config (e.g.
config-x86\_64-linux-gnu instead of config).

To run with Python, make sure that PYTHONHOME is set as mentioned above.
You will also need to set PYTHONPATH to include any modules that you are
using in your input. Examples of Python within NWChem are in the
$NWCHEM\_TOP/QA/tests/pyqa and $NWCHEM\_TOP/contrib/python directories.

### Optimized math libraries

By default NWChem uses its own basic linear algebra subroutines (BLAS).
To include faster BLAS routines, the environment variable BLASOPT needs
to be set before building the code. For example, with
ATLAS
```
export BLASOPT="-L/usr/local/ATLAS -llapack -lf77blas -latlas"
```
Good choices of optimized BLAS libraries on x86 (e.g. LINUX and LINUX64)
hardware include:  

|             |                                                                                               |
|-------------|-----------------------------------------------------------------------------------------------|
| BLIS        | <https://github.com/flame/blis>                                                               |    
| OpenBLAS    | <https://github.com/xianyi/OpenBLAS>                                                          |
| GotoBLAS    | <http://www.tacc.utexas.edu/tacc-projects/gotoblas2>                                          |  
| Intel MKL   | <http://www.intel.com/software/products/mkl>                                                  |
| ATLAS       | <http://math-atlas.sf.net>                                                                    |
| Cray LibSci | Available only on Cray hardware, it is automatically linked when compiling on Cray computers. |

**Newafter commit [6b0a971](https://github.com/nwchemgit/nwchem/commit/6b0a971207e776f43dec81974014e86caf8cee61#diff-1750a4dcc9a0a9b1773d275e96c46a1e )**:  If BLASOPT is defined, the LAPACK_LIB environment variable must be set up, too.  LAPACK_LIB must provide the location of the library containg the LAPACK toutines.

NWChem can also take advantage of the [ScaLAPACK
library](http://www.netlib.org/scalapack/) if it is installed on your
system. The following environment variables need to be set:
```
export USE_SCALAPACK=y
  
export SCALAPACK="location of Scalapack and BLACS library"
```
### How to deal with with  integer size of Linear Algebra libraries 
In the case of 64-bit platforms, most vendors optimized BLAS
libraries cannot be used. This is due to the fact that while NWChem uses
64-bit integers (i.e. integer\*8) on 64-bit platforms, most of the
vendors optimized BLAS libraries used 32-bit integers. The same holds
for the ScaLAPACK libraries, which internally use 32-bit integers.  
The BLAS_SIZE environment variable is used at compile time to set the size of integer arguments in BLAS calls.  


| BLAS_SIZE  |  size of integer arguments in BLAS routines  |
|:--:| -- |
 4 |  32-bit   (most common default)  |
  8  |   64-bit   |


A method is available to link against the libraries mentioned above,
using the following procedure:
```
   cd $NWCHEM_TOP/src
   make clean
   make 64_to_32
   make USE_64TO32=y  BLAS_SIZE=4 BLASOPT=" optimized BLAS" SCALAPACK="location of Scalapack and BLACS library"
```
E.g., for IBM64 this looks like

`  % make  USE_64TO32=y BLAS_SIZE=4 BLASOPT="-lessl -lmass"`

Notes:

  - GotoBLAS2 (or OpenBLAS) can be installed with 64bit integers. This
    is accomplished by compiling the GotoBLAS2 library after having by
    edited the GotoBLAS2 Makefile.rule file and un-commenting the line
    containing the INTERFACE64 definition. In other words, the line
```
          #INTERFACE64 = 1
```
                needs to be changed to
```
          INTERFACE64 = 1
```
  - ACML and MKL can support 64-bit integers if the appropriate library
    is chosen. For MKL, one can choose the ILP64 Version of Intel® MKL
    and the correct recipe can be extracted from the website
    <https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor>.
    For ACML the int64 libraries should be chosen, e.g. in the case of
    ACML 4.4.0 using a PGI compiler
    /opt/acml/4.4.0/pgi64\_int64/lib/libacml.a

### Linking in NBO

The 5.0 (obsolete) version of NBO provides a utility to generate source
code that can be linked into computational chemistry packages such as
NWChem. To utilize this functionality, follow the instructions in the
NBO 5 package to generate an nwnbo.f file. Linking NBO into NWChem can
be done using the following procedure:
```
  % cd $NWCHEM_TOP/src 
  % cp nwnbo.f $NWCHEM_TOP/src/nbo/.  
  % make nwchem_config NWCHEM_MODULES="all nbo" 
  % make
```
One can now use "task nbo" and incorporate NBO input into the NWChem
input file directly:
```
 nbo  
   $NBO NRT $END  
   ... 
 end  
  
 task nbo
```
## Building the NWChem binary

Once all required and optional environment variables have been set,
NWChem can be compiled:
```
  % cd $NWCHEM_TOP/src  
  
  % make nwchem_config 
  
  % make >& make.log
```
The make above will use the standard compilers available on your system.
To use compilers different from the default one can either set
environment variables:
```
  % export FC=<fortran compiler>  
  % export CC=<c compiler>
```
Or one can supply the compiler options to the make command (_recommended_ option), e.g:
```
  % make FC=ifort 
```
For example, on Linux FC could be set either equal to ifort, gfortran or pgf90

**Nota bene:** NWChem does NOT support usage of the full path in FC and
CC variables. Please provide filenames only as in the examples above\!

Note 1: If in a Linux environment, FC is set equal to anything other
than the tested compilers, there is no guarantee of a successful
installation, since the makefile structure has not been tested to
process other settings. In other words, please avoid make FC="ifort -O3 -xhost"
and stick to make FC="ifort", instead

Note 2: It's better to avoid redefining CC, since a) NWChem does not
have C source that is a computational bottleneck and b) we typically
test just the default C compiler. In other words, the recommendation is
to compile with make FC=ifort

Note 3: It's better to avoid modifying the values of the FOPTIMIZE and
COPTIMIZE variables. The reason is that the default values for FOPTIMIZE
and COPTIMIZE have been tested by the NWChem developers (using the
internal QA suites, among others), while any modification might produce
incorrect results.

# How-to: Build\_nwchem script (unsupported)

The build\_nwchem script is an auto-compile tool. It guesses the
configuration of your machine based on the results of a number of tests
and compiles a corresponding binary. It is of course possible that the
script guesses something wrong in which case that setting can be
corrected by manually specifying the corresponding environment variable.
See the other platform how-to's for details on those variables. The only
requirement to use the script is that the MPI compiler wrappers (e.g.
mpif90, mpicc and mpiCC) should be in your path, and that if your
machine uses the "module" software you should have all modules you want
to use loaded. If these requirements are met then simply run
```
% cd $NWCHEM_TOP  
 % ./contrib/distro-tools/build_nwchem | tee build_nwchem.log
```
In the file build_nwchem.log you will find under "Building NWChem" a
report on what platform the script thinks you are using.

In addition to compiling the code the build\_nwchem script now also
creates scripts that can be used to set or unset all the environment
variables that were used in the build. Those scripts are

` nwchem_make_env.csh`  
` nwchem_make_env.sh`  
` nwchem_make_unenv.csh`  
` nwchem_make_unenv.sh`

The scripts also define a command

` renwc`

that can be used to recompile just one directory and relink the code.
This is particularly convenient when developing.

# How-to: Linux platforms

  - **Common environmental variables for building in serial or in
    parallel with MPI**
```
 % setenv NWCHEM_TOP <your path>/nwchem  
 % setenv NWCHEM_TARGET LINUX64  
 % setenv NWCHEM_MODULES  all
```
  - **Common environmental variables for building with MPI**

The following environment variables need to be set when NWChem is
compiled with
MPI:
```
% setenv USE_MPI y  
% setenv USE_MPIF y  
% setenv USE_MPIF4 y

 % setenv MPI_LOC <your path>/openmpi-1.4.3  (for example, if you are using OpenMPI)  
 % setenv MPI_LIB <your path>/openmpi-1.4.3/lib  
 % setenv MPI_INCLUDE <your path>/openmpi-1.4.3/include  
 % setenv LIBMPI "-lmpi_f90 -lmpi_f77 -lmpi -lpthread"
```
**New in NWChem 6.6:** If the location of the mpif90 command is part of
your PATH env. variable, NWChem will figure out the values of LIBMPI,
MPI_LIB and MPI_INCLUDE (if they are not set). Therefore, we recommend
not to set LIBMPI, MPI_LIB and MPI_INCLUDE and add the location of
mpif90 to the PATH variable, instead.

  - **Compiling the code once all variables are set**
```
  % cd $NWCHEM_TOP/src  
  
  % make nwchem_config
  
  % make FC=gfortran >& make.log
```
#### NWChem 6.6 on Ubuntu 14.04 (Trusty Tahr)

These instruction are likely to work (with minor modifications) on all
Debian based distributions

  - Packages
required:

`python-dev gfortran libopenblas-dev libopenmpi-dev openmpi-bin tcsh make `

  - Settings
```
export USE_MPI=y  
export NWCHEM_TARGET=LINUX64  
export USE_PYTHONCONFIG=y  
export PYTHONVERSION=2.7  
export PYTHONHOME=/usr 
export BLASOPT="-lopenblas -lpthread -lrt"  
export BLAS_SIZE=4  
export USE_64TO32=y
```
  - Compilation steps
```
make nwchem_config NWCHEM_MODULES="all python"
make 64_to_32
make
```
#### NWChem 6.6 on Fedora 22

  - Packages
required:

`python-devel gcc-gfortran openblas-devel openblas-serial64 openmpi-devel tcsh make patch`

  - Settings

`export USE_MPI=y`  
`export NWCHEM_TARGET=LINUX64`  
`export USE_PYTHONCONFIG=y`  
`export PYTHONVERSION=2.7`  
`export PYTHONHOME=/usr`  
`export BLASOPT="-lnwclapack -lopenblas64"`  
`export BLAS_SIZE=8`  
`export PATH=/usr/lib64/openmpi/bin:$PATH`  
`export LD_LIBRARY_PATH=/usr/lib64/openmpi/lib:$LD_LIBRARY_PATH`  
`export USE_ARUR=y`

  - Compilation steps

`make nwchem_config NWCHEM_MODULES="all python"`  
`make`

#### NWChem 6.8 on Centos 7.1/Fedora 27
Once you have added the [EPEL
repository](https://fedoraproject.org/wiki/EPEL) to your Centos/Fedora/RedHat
installation, you can have a more efficient NWChem build. 
```
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
```
  - Packages
required:

`python-devel gcc-gfortran  openblas-devel openblas-serial64 openmpi-devel scalapack-openmpi-devel \`  
`elpa-openmpi-devel tcsh openssh-clients which tar`

  - Settings
```
export USE_MPI=y
export NWCHEM_TARGET=LINUX64  
export USE_PYTHONCONFIG=y  
export PYTHONVERSION=2.7  
export PYTHONHOME=/usr  
export USE_64TO32=y  
export BLAS_SIZE=4  
export BLASOPT="-lopenblas -lpthread -lrt"  
export SCALAPACK_SIZE=4  
export SCALAPACK="-L/usr/lib64/openmpi/lib -lscalapack "  
export ELPA="-I/usr/lib64/gfortran/modules/openmpi -L/usr/lib64/openmpi/lib -lelpa"  
export LD_LIBRARY_PATH=/usr/lib64/openmpi/lib/:$LD_LIBRARY_PATH 
export PATH=/usr/lib64/openmpi/bin/:$PATH
```
  - Compilation steps
```
cd $NWCHEM_TOP/src  
make nwchem_config NWCHEM_MODULES="all python"  
make 64_to_32  
make
```
#### NWChem 6.6 on RedHat 6

  - Packages required:

`python-devel gcc-gfortran openmpi-devel  tcsh make`

  - Settings
```
export USE_MPI=y
export NWCHEM_TARGET=LINUX64
export USE_PYTHONCONFIG=y
export PYTHONVERSION=2.6
export PYTHONHOME=/usr
export USE_INTERNALBLAS
export LD_LIBRARY_PATH=/usr/lib64/openmpi/lib/:$LD_LIBRARY_PATH
export PATH=/usr/lib64/openmpi/bin/:$PATH
```
  - Compilation steps
```
make nwchem_config NWCHEM_MODULES="all python"
make
```
#### NWChem 6.6 on RedHat 6 & EPEL repository

Once you have added the [EPEL
repository](https://fedoraproject.org/wiki/EPEL) to you RedHat 6
installation, you can have a more efficient NWChem build. The settings
are exactly the same as
[Centos 7.1](http://www.nwchem-sw.org/index.php?title=Compiling_NWChem#NWChem_6.6_on_Centos_7.1)

#### NWChem 6.6 on OpenSuse 13

  - Packages
required:

`gcc-fortran make python-devel openblas-devel openmpi-devel tcsh`

  - Settings

`export USE_MPI=y`  
`export NWCHEM_TARGET=LINUX64`  
`export USE_PYTHONCONFIG=y`  
`export PYTHONVERSION=2.7`  
`export PYTHONHOME=/usr`  
`export USE_64TO32=y`  
`export BLAS_SIZE=4`  
`export BLASOPT="-lopenblas -lpthread -lrt"`  
`export PATH=/usr/lib64/mpi/gcc/openmpi/bin:$PATH `  
`export LD_LIBRARY_PATH=/usr/lib64/mpi/gcc/openmpi/lib64:$LD_LIBRARY_PATH`  
`export PATH=/usr/lib64/openmpi/bin/:$PATH`

  - Compilation steps

`make nwchem_config NWCHEM_MODULES="all python"`  
`make 64_to_32`  
`make`

# How to: Mac platforms

## Compilation of NWChem 6.3 release on Mac OS X 10.7

  - Download and unpack latest NWChem tarball to the directory of your
    choosing, say /Users/johndoe/nwchem
  - Download XCode from the [App
    store](http://itunes.apple.com/us/app/xcode/id497799835?mt=12)
  - From within Xcode install command line tools
  - Download
    [gfortran 4.6.2](http://quatramaran.ens.fr/~coudert/gfortran/gfortran-4.6.2-x86_64-Lion.dmg)
    from <http://gcc.gnu.org/wiki/GFortranBinaries#MacOS>
  - To compile serial version of NWChem 6.3 set (unset) the following
    environmental variables

`unsetenv USE_MPI`  
`setenv NWCHEM_MODULES all`  
`setenv OLD_GA  yes`  
`setenv NWCHEM_TARGET MACX`  
`setenv NWCHEM_TOP /Users/johndoe/nwchem`

  - Go to your source directory, configure, and compile

` cd /Users/johndoe/nwchem/src`  
` make nwchem_config`  
` make `

  - That is it \!

## Compilation of NWChem 6.5 release on Mac OS X 10.9 x86\_64

  - Download and unpack latest NWChem tarball to the directory of your
    choosing, say /Users/johndoe/nwchem
  - Install Homebrew as described at
<http://brew.sh>
```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```
  - Use Homebrew to install mpich2
```
brew install mpich2
```
  - As usual, set the env. variables

`setenv USE_MPI y`  
`setenv NWCHEM_MODULES all`  
`setenv NWCHEM_TARGET MACX64`  
`setenv NWCHEM_TOP /Users/johndoe/nwchem`

  - **Important**: set the following env. variable (GA will not compile
    otherwise)

`setenv CFLAGS_FORGA "-DMPICH_NO_ATTR_TYPE_TAGS"`

  - Go to your source directory, configure, and compile

` cd /Users/johndoe/nwchem/src`  
` make nwchem_config`  
` make`

## Compilation of NWChem 6.6 on Mac OS X 10.10 (Yosemite) x86\_64

#### Method \#1: using gfortran from hpc.sf.net and mpich from macports

  - Download and unpack latest NWChem tarball to the directory of your
    choosing, say /Users/johndoe/nwchem
  - Install gfortran (4.9) from <http://hpc.sourceforge.net/> (
    <http://prdownloads.sourceforge.net/hpc/gcc-4.9-bin.tar.gz?download>
    ) and make sure to add the location to your path

<!-- end list -->

  - Install mpi (e.g. using macports)

`sudo port install mpich`  
`sudo port select mpi mpich-mp-fortran`

  - Set environmental variables

`export NWCHEM_TOP=/Users/johndoe/nwchem/`  
`export NWCHEM_TARGET=MACX64`  
`export USE_MPI="y"`  
`export USE_MPIF="y"`  
`export USE_MPIF4="y"`  
`export CFLAGS_FORGA="-DMPICH_NO_ATTR_TYPE_TAGS"`  
`export LIBMPI=" -lmpifort -lmpi -lpmpi -lpthread"`  
`export BLASOPT=" "`

  - Go to your source directory, configure, and compile

` cd /Users/johndoe/nwchem/src`  
` make nwchem_config`  
` make`

#### Method \#2: using gfortran and openmpi from brew

  - Download and unpack latest NWChem tarball to the directory of your
    choosing, say /Users/johndoe/nwchem
  - Install Homebrew as described at <http://brew.sh> (more details at
    <https://docs.brew.sh/Installation.html>)

<!-- end list -->

``` 
 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 
```

  - Use Homebrew to install open-mpi
```
brew install open-mpi
```
  - As usual, set the env. variables
```
export USE_MPI=y  
export NWCHEM_TARGET=MACX64  
export NWCHEM_TOP=/Users/johndoe/nwchem  
export USE_INTERNALBLAS=y
```
  - **Important**: set the following env. variable (GA will not compile
    otherwise)
```
export CFLAGS_FORGA "-DMPICH_NO_ATTR_TYPE_TAGS"
```
  - Go to your source directory, configure, and compile
```
 cd /Users/johndoe/nwchem/src  
 make nwchem_config`  
 make
```
**WARNING:** Please do not use the Mac OS X default BLAS and LAPACK
libraries available (or brew's veclibfort), since they are causing
NWChem to produce erroneous results

#### Method \#3: using Intel compilers and MKL

The Intel compilers and MKL work just fine on Mac with the following
options:

`NWCHEM_TARGET=MACX64`  
`CC=icc`  
`FC=ifort`  
`BLASOPT="-mkl -openmp"`  
`USE_OPENMP=T`

MPICH and ARMCI-MPI work reliably on Mac. See [Choosing the ARMCI
Library](ARMCI "wikilink") for details on ARMCI-MPI

# How-to: Cray platforms

Common environmental variables for building and running on the Cray XT, XE, XC and XK:
```
  % setenv NWCHEM_TOP <your path>/nwchem  
  % setenv NWCHEM_TARGET LINUX64  
  % setenv NWCHEM_MODULES all  
  % setenv USE_MPI y
  % setenv USE_MPIF y 
  % setenv USE_MPIF4 y 
  % setenv USE_SCALAPACK y 
  % setenv USE_64TO32 y  
  % setenv LIBMPI " "
```
  - **Compiling the code on Cray once all variables (described below)
    are set**
```
  % cd $NWCHEM_TOP/src
  
  % make nwchem_config  
  
  % make 64_to_32
  
  % make FC=ftn >& make.log
```
The step `make 64_to_32` is required only if either SCALAPACK\_SIZE or
BLAS\_SIZE are set equal to 4.

### Portals, e.g. XT3, XT4, XT5

Set the following environmental variable for compilation:
```
  % setenv ARMCI_NETWORK PORTALS
```
### Gemini, e.g. XE6, XK7

#### Method \#1: ARMCI\_NETWORK=GEMINI  

Load the onsided module by executing the command
```
  % module load onesided
```
Note: Preferred version of onesided is 1.5.0 or later ones.

Set the environmental variables for compilation:
```
  % setenv ARMCI_NETWORK GEMINI  
  % setenv ONESIDED_USE_UDREG 1  
  % setenv ONESIDED_UDREG_ENTRIES 2048
```
#### Method \#2: ARMCI\_NETWORK=MPI-PR

This is a **<span style="color:#FF0000">new option available in NWChem
6.6.</span>**

Set the environmental variables for compilation:
```
  % setenv ARMCI_NETWORK MPI-PR
```
#### Example: OLCF Titan

These are variables used for compilation on the [OLCF Titan, a Cray
XK7](https://www.olcf.ornl.gov/computing-resources/titan-cray-xk7/) We
assume use of Portland Group compilers programming environment (`module
load PrgEnv-pgi`)
```
NWCHEM_TARGET=LINUX64  
ARMCI_NETWORK=MPI-PR  
USE_64TO32=y  
USE_MPI=y  
BLAS_SIZE=4 
LAPACK_SIZE=4  
SCALAPACK_SIZE=4  
SCALAPACK=-lsci_pgi_mp  
BLASOPT=-lsci_pgi_mp
```
To enable the GPU part, set

`TCE_CUDA=y`

and load the cudatoolkit module

`module load cudatoolkit`

### Aries, e.g. XC30/XC40

#### Method \#1: ARMCI\_NETWORK=MPI-PR  

This is a **<span style="color:#FF0000">new option available in NWChem
6.6.</span>**

Set the environmental variables for compilation:

`  % setenv ARMCI_NETWORK MPI-PR`

#### Method \#2: ARMCI\_NETWORK=DMAPP (deprecated) 

This method is now **<span style="color:#FF0000">deprecated</span>** in
favor of method \#1 ARMCI\_NETWORK=MPI-PR

Might need to execute

` % module load craype-hugepages64M`

Recommended: replace ga-5-3 (or ga-5-4) with GA/ARMCI developed
by Cray. The software is hosted on github at
<https://github.com/ryanolson/ga>.

Instructions:

``` 
% cd $NWCHEM_TOP/src/tools
% module load dmapp
% wget https://github.com/ryanolson/ga/archive/cray.zip -O cray.zip
% unzip cray.zip
% make FC=ftn GA_DIR=ga-cray  DMAPP_INCLUDE=$CRAY_DMAPP_INCLUDE_OPTS   DMAPP_LIB=$CRAY_DMAPP_POST_LINK_OPTS   
```

Load the dmapp module by executing the command
```
  % module load dmapp
```
Set the environmental variable for compilation:
```
  % setenv ARMCI_NETWORK DMAPP
```
in the PBS script, add the following env. variables definitions
```
  % setenv HUGETLB_MORECORE yes 
  % setenv HUGETLB_DEFAULT_PAGE_SIZE 8M  
  % setenv UGNI_CDM_MDD_DEDICATED 2
```
#### Example: NERSC Edison

These are variables used for compilation on [NERSC Edison, a Cray
XC30](https://www.nersc.gov/users/computational-systems/edison/), as of
October 23rd 2015, when using Intel compilers (i.e. after issuing the
commands `module swap PrgEnv-gnu PrgEnv-intel`). Very similar settings
can be applied to other Cray XC30 computers, such as [the UK ARCHER
computer](http://www.archer.ac.uk)
```
CRAY_CPU_TARGET=sandybridge 
NWCHEM_TARGET=LINUX64  
ARMCI_NETWORK=MPI-PR  
USE_MPI=y
SCALAPACK="-L$MKLROOT/lib/intel64 -lmkl_scalapack_ilp64 -lmkl_intel_ilp64 -lmkl_core -lmkl_sequential \\  
-lmkl_blacs_intelmpi_ilp64 -lpthread -lm"  
SCALAPACK_SIZE=8  
BLAS_SIZE=8  
BLASOPT="-L$MKLROOT/lib/intel64 -lmkl_intel_ilp64 -lmkl_core -lmkl_sequential -lpthread -lm"  
LD_LIBRARY_PATH=/opt/gcc/4.9.2/snos/lib64:$LD_LIBRARY_PATH 
PATH=/opt/gcc/4.9.2/bin:$PATH  
CRAYPE_LINK_TYPE=dynamic 
```
To compile
```
make nwchem_config 
make FC=ftn
```
The following env. variables needs to added to the batch queue
submission script
```  
MPICH_GNI_MAX_VSHORT_MSG_SIZE=8192
MPICH_GNI_MAX_EAGER_MSG_SIZE=131072   
MPICH_GNI_NUM_BUFS=300   
MPICH_GNI_NDREG_MAXSIZE=16777216  
MPICH_GNI_MBOX_PLACEMENT=nic    
COMEX_MAX_NB_OUTSTANDING=6
```
#### Example: NERSC Cori

These are variables used for compilation on the Haswell partition of
[NERSC Edison, a Cray
XC40](https://www.nersc.gov/users/computational-systems/cori), as of
November 6th 2016, when using Intel compilers (i.e. after issuing the
commands `module swap PrgEnv-gnu
PrgEnv-intel`).
```
export NWCHEM_TARGET=LINUX64  
export USE_MPI=y  
export NWCHEM_TARGET=LINUX64  
export ARMCI_NETWORK=MPI-PR  
export USE_MPI=y  
export USE_SCALAPACK=y  
export SCALAPACK="-L$MKLROOT/lib/intel64 -lmkl_scalapack_ilp64 -lmkl_intel_ilp64 -lmkl_core -lmkl_sequential \  
-lmkl_blacs_intelmpi_ilp64 -lpthread -lm"  
export SCALAPACK_SIZE=8  
export SCALAPACK_LIB="$SCALAPACK" 
export BLAS_SIZE=8
export BLASOPT="-L$MKLROOT/lib/intel64 -lmkl_intel_ilp64 -lmkl_core -lmkl_sequential -lmkl_core -liomp5 -lpthread -ldmapp -lm"  
export USE_NOIO=y  
export CRAYPE_LINK_TYPE=dynamic
```
To compile
```
make nwchem_config
make FC=ftn
```
The following env. variables needs to added to the batch queue
submission script
```
MPICH_GNI_MAX_VSHORT_MSG_SIZE=10000  
MPICH_GNI_MAX_EAGER_MSG_SIZE=98304  
MPICH_GNI_NUM_BUFS=300  
MPICH_GNI_NDREG_MAXSIZE=16777216 
MPICH_GNI_MBOX_PLACEMENT=nic
COMEX_MAX_NB_OUTSTANDING=6
```
# How-to: Intel Xeon Phi

This section describes both the newer KNL and older KNC hardware, in
reverse chronological order.

  - **Compiling NWChem on self-hosted Intel Xeon Phi Knights Landing
    processors**

NWChem 6.6 (and later versions) support OpenMP threading, which is
essential to obtaining good performance with NWChem on Intel Xeon Phi
many-core processors.  
As of November 2016, the development version of NWChem contains
threading support in the TCE coupled-cluster codes (primarily
non-iterative triples in e.g. CCSD(T)), semi-direct CCSD(T), and
plane-wave DFT (i.e. NWPW).

Required for compilation: Intel compilers, version 16+ (17+ is strongly
recommended).

Environmental variables required for compilation:
```
% setenv USE_KNL 1 
% setenv USE_OPENMP 1  
% setenv USE_F90_ALLOCATABLE T  
% setenv USE_FASTMEM T
```
The latter two options are required to allocate temporaries in MCDRAM
when running in flat mode. Please do not use cache mode for NWChem
CCSD(T) codes. Note that using Fortran heap allocations means the memory
statistics generated by MA are no longer accurate, but we doubt that
anyone has been relying on these anyways.


`USE_FASTMEM` requires the _memkind_ library to be installed.
An open source version of the memkind library can be downloaded from [Github](https://github.com/memkind/memkind)

Side note: With the exception of `USE_FASTMEM`, all of the options in
the KNL section apply to Intel Xeon processors as well. OpenMP is
certainly useful on multicore processors as a way to reduce the
communication overhead and memory footprint of NWChem.

When using MKL and Intel 16+, please use the following
settings
```
% setenv BLASOPT   "-mkl -qopenmp" 
% setenv SCALAPACK "-mkl -qopenmp -lmkl_scalapack_ilp64 -lmkl_blacs_intelmpi_ilp64"
```
The command require for compilation is
```
$ make FC=ifort CC=icc
```
Environmental variables recommended at runtime (assuming Intel OpenMP
and MPI):
```
% setenv I_MPI_PIN 1  
% setenv I_MPI_DEBUG 4  
% setenv KMP_BLOCKTIME 1 
% setenv KMP_AFFINITY scatter,verbose
```
Once you are comfortable with the affinity settings, you can use these
instead:
```
% setenv I_MPI_PIN 1
% setenv KMP_BLOCKTIME 1  
% setenv KMP_AFFINITY scatter
```
Please consult the Intel or similar documentation regarding MPI+OpenMP
affinity on your system. This is a complicated issue that depends on the
software you use; it is impossible to document all the different
combinations of MPI and OpenMP implementations that may be used with
NWChem.

If you encounter segfaults not related to ARMCI, you may need to set the
following or recompile with `-heap-arrays`. Please create thread in the
Forum if you observe this.
```
% ulimit -s unlimited  
% setenv OMP_STACKSIZE 32M
```
  - **Compiling NWChem on hosts equipped with Intel Xeon Phi Knights
    Corner coprocessors**

NWChem 6.5 (and later versions) offers the possibility of using Intel
Xeon Phi hardware to perform the most computationally intensive part of
the CCSD(T) calculations (non-iterative triples corrections).

Required for compilation: Intel Composer XE version 14.0.3 (or later
versions)

Environmental variables required for compilation:
```
% setenv USE_OPENMP 1 
% setenv USE_OFFLOAD 1
```
When using MKL and Intel Composer XE version 14 (or later versions),
please use the following
settings
```
% setenv BLASOPT   "-mkl -openmp   -lpthread -lm"  
% setenv SCALAPACK "-mkl -openmp -lmkl_scalapack_ilp64 -lmkl_blacs_intelmpi_ilp64 -lpthread -lm"
```
The command require for compilation is
```
$ make FC=ifort 
```
  - **Examples of recommended configurations**

From our experience using the CCSD(T) TCE module, we have determined
that the optimal configuration is to use a single Global Arrays ranks
for offloading work to each Xeon Phi card.

On the EMSL cascade system, each node is equipped with two coprocessors,
and NWChem can allocate one GA ranks per coprocessor. In the job
scripts, we recommend spawning just 6 GA ranks for each node, instead of
16 (number that would match the number of physical cores). Therefore, 2
out 6 GA ranks assigned to a particular compute node will offload to the
coprocessors, while the remaining 6 cores while be used for traditional
CPU processing duties. Since during offload the host core is idle, we
can double the number of OpenMP threads for the host
(`OMP_NUM_THREADS=4`) in order to fill the idle core with work from
another GA rank (4 process with 4 threads each will total 16 threads on
each node).

NWChem itself automatically detects the available coprocessors in the
system and properly partitions them for optimal use, therefore no action
is required other than specifying the number of processes on each node
(using the appropriate mpirun/mpiexec options) and setting the value of
`OMP_NUM_THREADS` as in the example above.

Environmental variables useful at run-time:

OMP\_NUM\_THREADS is needed for the thread-level parallelization on the
Xeon CPU hosts

`% setenv OMP_NUM_THREADS 4`

MIC\_USE\_2MB\_BUFFER greatly improve communication between host and
Xeon Phi card

`% setenv MIC_USE_2MB_BUFFER 16K`

**[Very important](Very_important "wikilink")**: when running on
clusters equipped with Xeon Phi and Infiniband network hardware
(requiring `ARMCI_NETWORK=OPENIB`), the following env. variable is
required, even [in the case when the Xeon Phi hardware is not
utilized](in_the_case_when_the_Xeon_Phi_hardware_is_not_utilized "wikilink")

`% setenv ARMCI_OPENIB_DEVICE mlx4_0`

# How-to: IBM platforms

  - **Compiling NWChem on BLUEGENE/L**

The following environment variables need to be
set

`  % setenv NWCHEM_TOP `<your path>`/nwchem`  
`  % setenv NWCHEM_TARGET BGL`  
`  % setenv ARMCI_NETWORK BGMLMPI`  
`  % setenv BGLSYS_DRIVER /bgl/BlueLight/ppcfloor`  
`  % setenv BGLSYS_ROOT ${BGLSYS_DRIVER}/bglsys`  
`  % setenv BLRTS_GNU_ROOT ${BGLSYS_DRIVER}/blrts-gnu`  
`  % setenv BGDRIVER ${BGLSYS_DRIVER}`  
`  % setenv BGCOMPILERS ${BLRTS_GNU_ROOT}/bin`  
`  % setenv USE_MPI y`  
`  % setenv LARGE_FILES TRUE`  
`  % setenv MPI_LIB ${BGLSYS_ROOT}/lib`  
`  % setenv MPI_INCLUDE ${BGLSYS_ROOT}/include`  
`  % setenv LIBMPI "-lfmpich_.rts -lmpich.rts -lmsglayer.rts -lrts.rts -ldevices.rts"`  
`  % setenv BGMLMPI_INCLUDE /bgl/BlueLight/ppcfloor/bglsys/include`  
`  % setenv BGMLLIBS /bgl/BlueLight/ppcfloor/bglsys/lib`

To compile, the following commands should be used:

` % cd $NWCHEM_TOP/src`  
  
` % make nwchem_config`  
  
` % make FC=blrts_xlf >& make.log`

  - **Compiling NWChem on BLUEGENE/P**

The following environment variables need to be
set

`  % setenv NWCHEM_TARGET BGP`  
`  % setenv ARMCI_NETWORK DCMFMPI`  
`  % setenv MSG_COMMS DCMFMPI`  
`  % setenv USE_MPI y`  
`  % setenv LARGE_FILES TRUE`  
`  % setenv BGP_INSTALLDIR /bgsys/drivers/ppcfloor`  
`  % setenv BGCOMPILERS /bgsys/drivers/ppcfloor/gnu-linux/bin`  
`  % setenv BGP_RUNTIMEPATH  /bgsys/drivers/ppcfloor/runtime`  
`  % setenv ARMCIDRV ${BGP_INSTALLDIR}`  
`  % setenv BGDRIVER ${ARMCIDRV}`  
`  % setenv MPI_LIB ${BGDRIVER}/comm/lib`  
`  % setenv MPI_INCLUDE ${BGDRIVER}/comm/include`  
`  % setenv LIBMPI "-L${MPI_LIB} -lfmpich_.cnk -lmpich.cnk -ldcmfcoll.cnk -ldcmf.cnk -lpthread -lrt -L${BGP_RUNTIMEPATH}/SPI -lSPI.cna"`  
`  % setenv BGMLMPI_INCLUDE ${MPI_INCLUDE}`

To compile, the following commands should be used:

` % cd $NWCHEM_TOP/src`  
  
` % make nwchem_config`  
  
` % make FC=bgxlf >& make.log`

  - **Compiling NWChem on BLUEGENE/Q**

The following environment variables need to be
set

`  % setenv NWCHEM_TARGET BGQ`  
`  % setenv USE_MPI y`  
`  % setenv USE_MPIF y`  
`  % setenv USE_MPIF4 y`  
`  % setenv MPI_INCLUDE /bgsys/drivers/ppcfloor/comm/xl/include`  
`  % setenv LIBMPI " "`  
`  % setenv BLASOPT "/opt/ibmmath/essl/5.1/lib64/libesslbg.a -llapack -lblas -Wl,-zmuldefs "`  
`  % setenv BLAS_LIB "/opt/ibmmath/essl/5.1/lib64/libesslbg.a -zmuldefs "`  
`  % setenv BLAS_SIZE 4`  
`  % setenv USE_64TO32 y`  
`  % set path=(/bgsys/drivers/ppcfloor/gnu-linux/bin/ $path)`  
`  % setenv ARMCI_NETWORK MPI-TS`  
`  % setenv DISABLE_GAMIRROR y`

To compile, the following commands should be used:

`   % module load bgq-xl`

`   % make nwchem_config `  
`  `  
`   % make 64_to_32 >& make6t3.log`

`   % make >& make.log`

**WARNING**: This is just a baseline port that we have tested and
validated against our QA suite. There is large room for improvement both
for serial performance (compiler options) and parallel performance (use
of alternative ARMCI\_NETWORKs other than MPI-TS)

  - **Compiling NWChem on IBM PowerPC architectures**

The following environment variables should be set:

`  % setenv NWCHEM_TOP `<your path>`/nwchem`  
`  % setenv NWCHEM_TARGET IBM64`  
`  % setenv ARMCI_NETWORK MPI-MT`  
`  % setenv OBJECT_MODE 64`  
`  % setenv USE_MPI y`  
`  % setenv LARGE_FILES TRUE`  
`  % setenv MPI_LIB /usr/lpp/ppe.poe/lib`  
`  % setenv MPI_INCLUDE /usr/lpp/ppe.poe/include`  
`  % setenv LIBMPI "-lmpi -lpthreads"`

To compile, the following commands should be used:

` % cd $NWCHEM_TOP/src`  
  
` % make nwchem_config`  
  
` % make FC=xlf >& make.log`

# How-to: Commodity clusters with Infiniband

Common environmental variables for building and running on most
Infiniband clusters are:
```
  % setenv NWCHEM_TOP <your path>/nwchem  
  % setenv NWCHEM_TARGET LINUX64 
  % setenv NWCHEM_MODULES "all"  
  % setenv USE_MPI y 
  % setenv USE_MPIF y 
  % setenv USE_MPIF4 y  
```
  - On Infiniband clusters with the OpenIB software stack, the following
    environment variables should be defined
```
  % setenv ARMCI_NETWORK OPENIB 
  % setenv IB_INCLUDE <Location of Infiniband libraries>/include  
```
  - On Infiniband clusters that do not support OpenIB, such as Myrinet
    MX, the MPI2 protocol can be used
```
  % setenv ARMCI_NETWORK MPI-MT
```
  - Compiling the code on an Infiniband cluster once all variables are
    set
```
  % cd $NWCHEM_TOP/src  
  
  % make nwchem_config  
  
  % make >& make.log
```
# How-to: Windows Platforms
## MingW
The current recommended approach for building a NWChem binary for a
Windows platform is to build with the
[MinGW/Mingw32](http://www.mingw.org/) environment. MinGW can be
installed using a semi-automatic tool mingw-get-setup.exe
(http://sourceforge.net/projects/mingw/files/Installer/). A basic MinGW
installation is required (Basic Setup), plus pthreads-32,
mingw32-gcc-fortran-dev of "All Packages" and the MSYS software.  
More detailed MinGW/MSYS installation tips can be found in the following
forum discussions

|                                                                 |
| --------------------------------------------------------------- |
| <http://www.nwchem-sw.org/index.php/Special:AWCforum/sp/id5124> |
| <http://www.nwchem-sw.org/index.php/Special:AWCforum/sp/id6628> |
|  |

Another essential prerequisite step is to install Mpich, which can be
found at the following
URL

<http://www.mpich.org/static/tarballs/1.4.1p1/mpich2-1.4.1p1-win-ia32.msi>

Once Mpich is installed, you should copy the installation files to a
different location to avoid the failure of the tools compilation. You
can use the following command
```
% cp -rp /c/Program\ Files\ \(x86\)/MPICH2/ ~/
```
You might want to install Python, too, by using the following
installation file

<https://www.python.org/ftp/python/2.7.8/python-2.7.8.msi>

Next, you need to set the env.
```
% export NWCHEM_TOP=~/nwchem-6.8  
% export NWCHEM_TARGET=LINUX
% export USE_MPI=y  
% export MPI_LOC=~/MPICH2  
% export MPI_INCLUDE=$MPI_LOC/include  
% export MPI_LIB=$MPI_LOC/lib  
% export LIBMPI="-lfmpich2g -lmpi"  
% export PYTHONHOME=/c/Python27/  
% export PYTHONVERSION=27  
% export DEPEND_CC=gcc
% export USE_INTERNALBLAS=y
% export NWCHEM_MODULES=all
```
Then, you can start the compilation by typing
```
% cd $NWCHEM_TOP/src  
% make nwchem_config  
% make FC=gfortran DEPEND_CC=gcc
```
## WSL on Windows 10
A good alternative only on Windows 10 is **Windows Subsystem for Linux** (WSL). 
**WSL** allows you to obtain a functional command line Linux 64-bit NWChem environment, either by compiling the NWChem code from scratch or by using the Ubuntu precompiled NWChem package. Here is a link to the install guide

https://msdn.microsoft.com/en-us/commandline/wsl/install_guide

Once Ubuntu is installed, the quickest method to install NWChem is by fetching the Ubuntu NWChem package by typing
```
sudo apt install nwchem
``` 
## Cygwin
As an unsupported alternative, Cygwin might be used with make, perl, and
gcc/gfortran version 4 installed (however several Cygwin versions are
not a good match for NWChem installation, for example cygwin version
1.7.32 -- current version as of September 2014 -- fails to compile
NWChem)

`  % setenv NWCHEM_TOP `*<your path>*`/nwchem`  
`  % setenv NWCHEM_TARGET CYGWIN`  
`  % setenv NWCHEM_MODULES all`

`  % cd $NWCHEM_TOP/src`  
  
`  % make nwchem_config`  
  
`  % make >& make.log`

It used to be possible to build a version for native Windows using the
Compaq Visual Fortran compiler. This has not been tested for the last
couple of releases as the NWChem.

`  % setenv NWCHEM_TOP `<your path>`/nwchem`  
`  % setenv NWCHEM_TARGET WIN32`  
`  % setenv NWCHEM_MODULES all`

To start the compilation, start the Microsoft makefile utility from the
top level source directory by typing "nmake". Reminder: For Compaq
visual fortran don't forget to execute the "dfvars" script.

# General site installation

The build procedures outlined above will allow use of NWChem within the
NWChem directory structure. The code will look for the basis set library
file in a default place within that directory structure. To install the
code in a general, public place (e.g., /usr/local/NWChem) the following
procedure can be applied:

  - Determine the local storage path for the install files. (e.g.,
    /usr/local/NWChem).
  - Make directories

`  mkdir /usr/local/NWChem`  
`  mkdir /usr/local/NWChem/bin`  
`  mkdir /usr/local/NWChem/data`

  - Copy binary

`  cp $NWCHEM_TOP/bin/${NWCHEM_TARGET}/nwchem /usr/local/NWChem/bin`  
`  cd /usr/local/NWChem/bin `  
`  chmod 755 nwchem`

  - Set links to data files (basis sets, force fields, etc.)

`  cd $NWCHEM_TOP/src/basis`  
`  cp -r libraries /usr/local/NWChem/data`  
  
`  cd $NWCHEM_TOP/src/`  
`  cp -r data /usr/local/NWChem`  
  
`  cd $NWCHEM_TOP/src/nwpw`  
`  cp -r libraryps /usr/local/NWChem/data`

  - Each user will need a .nwchemrc file to point to these default data
    files. A global one could be put in /usr/local/NWChem/data and a
    symbolic link made in each users $HOME directory is probably the
    best plan for new installs. Users would have to issue the following
    command prior to using NWChem: ln -s
    /usr/local/NWChem/data/default.nwchemrc $HOME/.nwchemrc

Contents of the default.nwchemrc file based on the above information
should be:

`  nwchem_basis_library /usr/local/NWChem/data/libraries/`  
`  nwchem_nwpw_library /usr/local/NWChem/data/libraryps/`  
`  ffield amber`  
`  amber_1 /usr/local/NWChem/data/amber_s/`  
`  amber_2 /usr/local/NWChem/data/amber_q/`  
`  amber_3 /usr/local/NWChem/data/amber_x/`  
`  amber_4 /usr/local/NWChem/data/amber_u/`  
`  spce    /usr/local/NWChem/data/solvents/spce.rst`  
`  charmm_s /usr/local/NWChem/data/charmm_s/`  
`  charmm_x /usr/local/NWChem/data/charmm_x/`

Of course users can copy this file instead of making the symbolic link
described above and change these defaults at their discretion.

It is can also be useful to use the NWCHEM\_BASIS\_LIBRARY environment
variable when testing a new installation when an old one exists. This
will allow you to overwrite the value of nwchem\_basis\_library in your
.nwchemrc file and point to the new basis library. For example:

`    % setenv NWCHEM_BASIS_LIBRARY "$NWCHEM/data-5.0/libraries/"`

Do not forget the trailing "/".
