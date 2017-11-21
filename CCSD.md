# Coupled Cluster Calculations

The NWChem coupled cluster energy module is primarily the work of
Alistair Rendell and Rika Kobayashi\[1\]\[2\], with contributions from
Bert de Jong, David Bernholdt and Edoardo Aprà\[3\].

The coupled cluster code can perform calculations with full iterative
treatment of single and double excitations and non-iterative inclusion
of triple excitation effects. It is presently limited to closed-shell
(RHF) references.

Note that symmetry is not used within most of the CCSD(T) code. This can
have a profound impact on performance since the speed-up from symmetry
is roughly the square of the number of irreducible representations. In
the absence of symmetry, the performance of this code is competitive
with other programs.

The operation of the coupled cluster code is controlled by the input
block

` CCSD`  
`   [MAXITER <integer maxiter default 20>]`  
`   [THRESH  <real thresh default 10e-6>]`  
`   [TOL2E <real tol2e default min(10e-12 , 0.01*<img alt="$thresh$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/90da5188eee4f5cf91f54c113b9d9b7b.svg?invert_in_darkmode&sanitize=true" align=middle width="47.93283pt" height="22.74591pt"/>)>]`  
`   [DIISBAS  <integer diisbas default 5>]`  
`   [FREEZE [[core] (atomic || <integer nfzc default 0>)] \`  
`           [virtual <integer nfzv default 0>]]`  
`   [NODISK]`  
`   [IPRT  <integer IPRT default 0>]`  
`   [PRINT ...]`  
`   [NOPRINT ...]`  
` END`

Note that the keyword CCSD is used for the input block regardless of the
actual level of theory desired (specified with the TASK directive). The
following directives are recognized within the CCSD group.

## MAXITER -- Maximum number of iterations

The maximum number of iterations is set to 20 by default. This should be
quite enough for most calculations, although particularly troublesome
cases may require more.

` MAXITER  <integer maxiter default 20>`

## THRESH -- Convergence threshold

Controls the convergence threshold for the iterative part of the
calculation. Both the RMS error in the amplitudes and the change in
energy must be less than thresh.

` THRESH  <real thresh default 10e-6>`

## TOL2E -- integral screening threshold

` TOL2E <real tol2e default min(10e-12 , 0.01*`*`thresh`*`)>`

The variable tol2e is used in determining the integral screening
threshold for the evaluation of the energy and related quantities.

CAUTION\! At the present time, the tol2e parameter only affects the
three- and four-virtual contributions, and the triples, all of which are
done "on the fly". The transformations used for the other parts of the
code currently have a hard-wired threshold of <img alt="$10^{-12}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/aeab78344f8b0fe0d6b7163980cf8ff1.svg?invert_in_darkmode&sanitize=true" align=middle width="39.668805pt" height="26.70657pt"/>. The default
for tol2e is set to match this, and since user input can only make the
threshold smaller, setting this parameter can only make calculations
take longer.

## DIISBAS -- DIIS subspace dimension

Specifies the maximum size of the subspace used in DIIS convergence
acceleration. Note that DIIS requires the amplitudes and errors be
stored for each iteration in the subspace. Obviously this can
significantly increase memory requirements, and could force the user to
reduce DIISBAS for large calculations.

Measures to alleviate this problem, including more compact storage of
the quantities involved, and the possibility of disk storage are being
considered, but have not yet been implemented.

` DIISBAS  <integer diisbas default 5>`

## FREEZE -- Freezing orbitals

`   [FREEZE [[core] (atomic || <integer nfzc default 0>)] \`  
`           [virtual <integer nfzv default 0>]]`

This directive is idential to that used in the [MP2](MP2 "wikilink")
module.

## NODISK -- On-the-fly computation of integrals

The CCSD modules by default computes once and stores on disk the
integrals. To avoid this kind of I/O operations, specify the keyword
`NODISK`

## IPRT -- Debug printing

This directive controls the level of output from the code, mostly to
facilitate debugging and the like. The larger the value, the more output
printed. From looking at the source code, the interesting values seem to
be IPRT \> 5, 10, and 50.

` IPRT  <integer IPRT default 0>`

## PRINT and NOPRINT

The coupled cluster module supports the standard NWChem print control
keywords, although very little in the code is actually hooked into this
mechanism
yet.

<center>

|                           |             |                               |
| ------------------------- | ----------- | ----------------------------- |
| Item                      | Print Level | Description                   |
| "reference"               | high        | Wavefunction information      |
| "guess pair energies"     | debug       | MP2 pair energies             |
| "byproduct energies"      | default     | Intermediate energies         |
| "term debugging switches" | debug       | Switches for individual terms |

</center>

## Methods (Tasks) Recognized

Currently available methods
are

`   * CCSD - Full iterative inclusion of single and double excitations`  
`   * CCSD+T(CCSD) - The fourth order triples contribution computed with converged singles and doubles amplitudes`  
`   * CCSD(T) - The linearized triples approximation due to Raghavachari.`

The calculation is invoked using the the TASK directive, so to perform a
CCSD+T(CCSD) calculation, for example, the input file should include the
directive

` TASK CCSD+T(CCSD)`

Lower-level results which come as by-products (such as MP3/MP4) of the
requested calculation are generally also printed in the output file and
stored on the run-time database, but the method specified in the TASK
directive is considered the primary result.

## Debugging and Development Aids

The information in this section is intended for use by experts (both
with the methodology and with the code), primarily for debugging and
development work. Messing with stuff in listed in this section will
probably make your calculation quantitatively wrong\! Consider yourself
warned\!

### Switching On and Off Terms

The /DEBUG/ common block contains a number of arrays which control the
calculation of particular terms in the program. These are 15-element
integer arrays (although from the code only a few elements actually
effect anything) which can be set from the input deck. See the code for
details of how the arrays are interpreted.

Printing of this data at run-time is controlled by the "term debugging
switches" print option. The values are checked against the defaults at
run-time and a warning is printed to draw attention to the fact that the
calculation does not correspond precisely to the requested method.

` DOA  <integer array default 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2>`  
` DOB  <integer array default 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2>`  
` DOG  <integer array default 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>`  
` DOH  <integer array default 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>`  
` DOJK <integer array default 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2>`  
` DOS  <integer array default 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>`  
` DOD  <integer array default 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>`

## Alternative Implementations of Triples

There are four customized versions of the CCSD(T) triples driver that
may improve performance on some architectures. These are not the default
implementation and are not tested regularly. The burden is on the user
to evaluate their correctness in comparison to the default triples
driver. The triples driver only affects how the (T) energy contribution
is evaluated; the CCSD code is the same in all cases.

All of the non-standard triples drivers are activated using RTDB set
directives, which are specified outside of the CCSD input block.

### Nonblocking

The nonblocking variant of the triples driver uses nonblocking Global
Arrays get operations. It may improve communication overlap at large
node code, provided that nonblocking communication makes asynchronous
progress.

` set ccsd:use_trpdrv_nb T`

### OpenMP

As of November 2016, the development version of semidirect CCSD(T) uses
OpenMP extensively. The OpenMP variant of the triples driver includes
OpenMP threaded kernels and attempts to run multiple DGEMM calls
simultaneously. The CCSD iteration uses OpenMP threading in kernels with
a relatively small number of parallel regions. It also uses nonblocking
Global Arrays get operations.

` set ccsd:use_ccsd_omp T`  
` set ccsd:use_trpdrv_omp T`

If one runs with only the (T) portion of the code using threads, the
CCSD code will run slower when using fewer cores. Thus, it may be
prudent to run the CCSD portion with a larger number of processes and
then run a second job for (T) that restarts the computation on a smaller
number of processes and a larger number of threads.

Preliminary evaluation of this implementation indicates that a small
number of threads (2 to 4) is optimal, with the assumption that
single-threaded execution can utilize all of the cores. It is expected
that nodes with a large number of cores may not be able to support
process-only parallelism due to memory-capacity constraints, in which
case the OpenMP implementation allows the user to make use of more cores
than otherwise possible.

Because of the extensive refactoring of the code to maximize OpenMP
performance and the intrinsic non-associativity of floating-point
arithmetic, the OpenMP variant may not produce the exact same answer as
the default one. If there is concern about the numerical fidelity of
results, a more stringent numerical threshold for the CCSD equations may
be required.

### Offload

The offload variant of the triples driver supports Intel Xeon Phi
coprocessors (Knights Corner family), in addition to the aforementioned
OpenMP and nonblocking features. This implementation has not been tested
extensively and a recommendation concerning the right number of
processes and threads is not available.

` set ccsd:use_trpdrv_offload T`

## References

<references/>

1.  Rendell, A.P., Lee, T.J., Komornicki, A., and Wilson, S. (1992)
    "Evaluation of the contribution from triply excited intermediates to
    the fourth-order perturbation theory energy on Intel distributed
    memory supercomputers", *Theor. Chem. Acc.*, **84**, 271-287, doi:
    [10.1007/BF01113267](http://dx.doi.org/10.1007/BF01113267)
2.  Kobayashi, R. and Rendell, A.P. (1997) "A direct coupled cluster
    algorithm for massively parallel computers", *Chem. Phys. Lett.*,
    **265**, 1-11, doi:
    [10.1016/S0009-2614(96)01387-5](http://dx.doi.org/10.1016/S0009-2614$96$01387-5)
3.  Aprà, E., Harrison, R.J., de Jong, W.A., Rendell, A.P., Tipparaju,
    V. and Xantheas, S.S. (2009) "Liquid Water: Obtaining the Right
    Answer for the Right Reasons", *Proc. SC'09*, doi:
    [10.1145/1654059.1654127](http://dx.doi.org/10.1145/1654059.1654127)
