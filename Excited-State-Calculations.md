# CIS, TDHF, TDDFT

## Overview

NWChem supports a spectrum of single excitation theories for vertical
excitation energy calculations, namely, configuration interaction
singles (CIS), time-dependent Hartree-Fock (TDHF or also known as
random-phase approximation RPA), time-dependent density functional
theory (TDDFT),\[ref\] and Tamm-Dancoff approximation to TDDFT. These
methods are implemented in a single framework that invokes Davidson's
trial vector algorithm (or its modification for a non-Hermitian
eigenvalue problem). The capabilities of the module are summarized as
follows:

  - Vertical excitation energies (valence and core),
  - Spin-restricted singlet and triplet excited states for closed-shell
    systems,
  - Spin-unrestricted doublet, etc., excited states for open-shell
    systems,
  - Tamm-Dancoff and full time-dependent linear response theories,
  - Davidson's trial vector algorithm,
  - Symmetry (irreducible representation) characterization and
    specification,
  - Spin multiplicity characterization and specification,
  - Transition moments and oscillator strengths,
  - Analytical first derivatives of vertical excitation energies with a
    selected set of exchange-correlation functionals (see TDDFT
    gradients documentation for further information),
  - Numerical second derivatives of vertical excitation energies,
  - Disk-based and fully incore algorithms,
  - Multiple and single trial-vector processing algorithms,
  - Frozen core and virtual approximation,
  - Asymptotically correct exchange-correlation potential by van Leeuwen
    and Baerends (R. van Leeuwen and E. J. Baerends, Phys. Rev. A 49,
    2421 (1994)),
  - Asymptotic correction by Casida and Salahub (M. E. Casida, C.
    Jamorski, K. C. Casida, and D. R. Salahub, J. Chem. Phys. 108, 4439
    (1998)),
  - Asymptotic correction by Hirata, Zhan, Aprà, Windus, and Dixon (S.
    Hirata, C.-G. Zhan, E. Aprà, T. L. Windus, and D. A. Dixon, J. Phys.
    Chem. A 107, 10154 (2003)).

These are very effective way to rectify the shortcomings of TDDFT when
applied to Rydberg excited states (see below).

## Performance of CIS, TDHF, and TDDFT methods

The accuracy of CIS and TDHF for excitation energies of closed-shell
systems are comparable to each other, and are normally considered a
zeroth-order description of the excitation process. These methods are
particularly well balanced in describing Rydberg excited states, in
contrast to TDDFT. However, for open-shell systems, the errors in the
CIS and TDHF excitation energies are often excessive, primarily due to
the multi-determinantal character of the ground and excited state wave
functions of open-shell systems in a HF reference.\[ref\] The scaling of
the computational cost of a CIS or TDHF calculation per state with
respect to the system size is the same as that for a HF calculation for
the ground state, since the critical step of the both methods are the
Fock build, namely, the contraction of two-electron integrals with
density matrices. It is usually necessary to include two sets of diffuse
exponents in the basis set to properly account for the diffuse Rydberg
excited states of neutral species.

The accuracy of TDDFT may vary depending on the exchange-correlation
functional. In general, the exchange-correlation functionals that are
widely used today and are implemented in NWChem work well for low-lying
valence excited states. However, for high-lying diffuse excited states
and Rydberg excited states in particular, TDDFT employing these
conventional functionals breaks down and the excitation energies are
substantially underestimated. This is because of the fact that the
exchange-correlation potentials generated from these functionals decay
too rapidly (exponentially) as opposed to the slow <img alt="$-1/r$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/3053de24294b49c2329426a84757d7d1.svg?invert_in_darkmode&sanitize=true" align=middle width="36.958185pt" height="24.56553pt"/> asymptotic
decay of the true potential. A rough but useful index is the negative of
the highest occupied KS orbital energy; when the calculated excitation
energies become close to this threshold, these numbers are most likely
underestimated relative to experimental results. It appears that TDDFT
provides a better-balanced description of radical excited states. This
may be traced to the fact that, in DFT, the ground state wave function
is represented well as a single KS determinant, with less
multi-determinantal character and less spin contamination, and hence the
excitation thereof is described well as a simple one electron
transition. The computational cost per state of TDDFT calculations
scales as the same as the ground state DFT calculations, although the
prefactor of the scaling may be much greater in the former.

A very simple and effecive way to rectify the TDDFT's failure for
Rydberg excited states has been proposed by Tozer and Handy (D. J. Tozer
and N. C. Handy, J. Chem. Phys. 109, 10180 (1998)) and by Casida and
Salahub (see previous reference). They proposed to splice a <img alt="$-1/r$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/3053de24294b49c2329426a84757d7d1.svg?invert_in_darkmode&sanitize=true" align=middle width="36.958185pt" height="24.56553pt"/>
asymptotic tail to an exchange-correlation potential that does not have
the correct asymptotic behavior. Because the approximate
exchange-correlation potentials are too shallow everywhere, a negative
constant must be added to them before they can be spliced to the
<img alt="$-1/r$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/3053de24294b49c2329426a84757d7d1.svg?invert_in_darkmode&sanitize=true" align=middle width="36.958185pt" height="24.56553pt"/> tail seamlessly in a region that is not sensitive to chemical
effects or to the long-range behavior. The negative constant or the
shift is usually taken to be the difference of the HOMO energy from the
true ionization potential, which can be obtained either from experiment
or from a ΔSCF calculation. Recently, we proposed a new, expedient, and
self-contained asymptotic correction that does not require an ionization
potential (or shift) as an external parameter from a separate
calculation. In this scheme, the shift is computed by a semi-empirical
formula proposed by Zhan, Nichols, and Dixon (C.-G. Zhan, J. A. Nichols,
and D. A. Dixon, J. Phys. Chem. A 107, 4184 (2003)). Both Casida-Salahub
scheme and this new asymptotic correction scheme give considerably
improved (Koopmans type) ionization potentials and Rydberg excitation
energies. The latter, however, supply the shift by itself unlike to
former.

## Input syntax

The module is called TDDFT as TDDFT employing a hybrid HF-DFT functional
encompasses all of the above-mentioned methods implemented. To use this
module, one needs to specify TDDFT on the task directive, e.g.,

`     TASK TDDFT ENERGY`

for a single-point excitation energy calculation, and

`     TASK TDDFT OPTIMIZE`

for an excited-state geometry optimization (and perhaps an adiabatic
excitation energy calculation), and

`     TASK TDDFT FREQUENCIES`

for an excited-state vibrational frequency calculation. The TDDFT module
first invokes DFT module for a ground-state calculation (regardless of
whether the calculations uses a HF reference as in CIS or TDHF or a DFT
functional), and hence there is no need to perform a separate
ground-state DFT calculation prior to calling a TDDFT task. When no
second argument of the task directive is given, a single-point
excitation energy calculation will be assumed. For geometry
optimizations, it is usually necessary to specify the target excited
state and its irreducible representation it belongs to. See the
subsections TARGET and TARGETSYM for more detail.

Individual parameters and keywords may be supplied in the TDDFT input
block. The syntax is:

` TDDFT`  
`   [(CIS||RPA) default RPA]`  
`   [NROOTS <integer nroots default 1>]`  
`   [MAXVECS <integer maxvecs default 1000>]`  
`   [(SINGLET||NOSINGLET) default SINGLET]`  
`   [(TRIPLET||NOTRIPLET) default TRIPLET]`  
`   [THRESH <double thresh default 1e-4>]`  
`   [MAXITER <integer maxiter default 100>]`  
`   [TARGET <integer target default 1>]`  
`   [TARGETSYM <character targetsym default 'none'>]`  
`   [SYMMETRY]`  
`   [ECUT] <-cutoff energy>`  
`   [EWIN] <-lower cutoff energy>  <-higher cutoff energy>`  
`   [alpha] `<integer lower orbital>` `<integer upper orbital>  
`   [beta] `<integer lower orbital>` `<integer upper orbital>  
`   [CIVECS]`  
`   [GRAD, END]`  
`   [CDSPECTRUM]`  
`   [VELOCITY]`  
`   [ALGORITHM <integer algorithm default 0>]`  
`   [FREEZE [[core] (atomic || <integer nfzc default 0>)] \`  
`            [virtual <integer nfzv default 0>]]`  
`   [PRINT (none||low||medium||high||debug)`  
`     <string list_of_names ...>]`  
` END`

The user can also specify the reference wave function in the DFT input
block (even when CIS and TDHF calculations are requested). See the
section of Sample input and output for more details.

Since each keyword has a default value, a minimal input file will be

` GEOMETRY`  
` Be 0.0 0.0 0.0`  
` END`  
` BASIS`  
` Be library 6-31G**`  
` END`  
` TASK TDDFT ENERGY`

Note that the keyword for the asymptotic correction must be given in the
DFT input block, since all the effects of the correction (and also
changes in the computer program) occur in the SCF calculation stage. See
[DFT](DFT "wikilink") (keyword CS00 and LB94) for details.

## Keywords of TDDFT input block

### CIS and RPA -- the Tamm-Dancoff approximation

These keywords toggle the Tamm-Dancoff approximation. CIS means that the
Tamm-Dancoff approximation is used and the CIS or Tamm-Dancoff TDDFT
calculation is requested. RPA, which is the default, requests TDHF (RPA)
or TDDFT calculation.

The performance of CIS (Tamm-Dancoff TDDFT) and RPA (TDDFT) are
comparable in accuracy. However, the computational cost is slightly
greater in the latter due to the fact that the latter involves a
non-Hermitian eigenvalue problem and requires left and right
eigenvectors while the former needs just one set of eigenvectors of a
Hermitian eigenvalue problem. The latter has much greater chance of
aborting the calculation due to triplet near instability or other
instability problems.

### NROOTS -- the number of excited states

One can specify the number of excited state roots to be determined. The
default value is 1. It is advised that the users request several more
roots than actually needed, since owing to the nature of the trial
vector algorithm, some low-lying roots can be missed when they do not
have sufficient overlap with the initial guess vectors.

### MAXVECS -- the subspace size

This keyword limits the subspace size of Davidson's algorithm; in other
words, it is the maximum number of trial vectors that the calculation is
allowed to hold. Typically, 10 to 20 trial vectors are needed for each
excited state root to be converged. However, it need not exceed the
product of the number of occupied orbitals and the number of virtual
orbitals. The default value is 1000.

### SINGLET and NOSINGLET -- singlet excited states

SINGLET (NOSINGLET) requests (suppresses) the calculation of singlet
excited states when the reference wave function is closed shell. The
default is SINGLET.

### TRIPLET and NOTRIPLET -- triplet excited states

TRIPLET (NOTRIPLET) requests (suppresses) the calculation of triplet
excited states when the reference wave function is closed shell. The
default is TRIPLET.

### THRESH -- the convergence threshold of Davidson iteration

This keyword specifies the convergence threshold of Davidson's iterative
algorithm to solve a matrix eigenvalue problem. The threshold refers to
the norm of residual, namely, the difference between the left-hand side
and right-hand side of the matrix eigenvalue equation with the current
solution vector. With the default value of 1e-4, the excitation energies
are usually converged to 1e-5 hartree.

### MAXITER -- the maximum number of Davidson iteration

It typically takes 10-30 iterations for the Davidson algorithm to get
converged results. The default value is 100.

### TARGET and TARGETSYM-- the target root and its symmetry

At the moment, excited-state first geometry derivatives can be
calculated analytically for a set of functionals, while excited-state
second geometry derivatives are obtained by numerical differentiation.
These keywords may be used to specify which excited state root is being
used for the geometrical derivative calculation. For instance, when
TARGET 3 and TARGETSYM a1g are included in the input block, the total
energy (ground state energy plus excitation energy) of the third lowest
excited state root (excluding the ground state) transforming as the
irreducible representation a1g will be passed to the module which
performs the derivative calculations. The default values of these
keywords are 1 and none, respectively.

The keyword TARGETSYM is essential in excited state geometry
optimization, since it is very common that the order of excited states
changes due to the geometry changes in the course of optimization.
Without specifying the TARGETSYM, the optimizer could (and would likely)
be optimizing the geometry of an excited state that is different from
the one the user had intended to optimize at the starting geometry. On
the other hand, in the frequency calculations, TARGETSYM must be none,
since the finite displacements given in the course of frequency
calculations will lift the spatial symmetry of the equilibrium geometry.
When these finite displacements can alter the order of excited states
including the target state, the frequency calculation is not be
feasible.

### SYMMETRY -- restricting the excited state symmetry

By adding this keyword to the input block, the user can request the
module to generate the initial guess vectors transforming as the same
irreducible representation as TARGETSYM. This causes the final excited
state roots be (exclusively) dominated by those with the specified
irreducible representation. This may be useful, when the user is
interested in just the optically allowed transitions, or in the geometry
optimization of an excited state root with a particular irreducible
representation. By default, this option is not set. TARGETSYM must be
specified when SYMMETRY is invoked.

### ECUT -- energy cutoff

This keyword enables restricted excitation window TDDFT (REW-TDDFT).
This is an approach best suited for core excitations. By specifying this
keyword only excitations from occupied states below the energy cutoff
will be considered.

### EWIN -- energy window

This keyword enables a restricted energy window between a lower energy
cutoff and a higher energy cutoff. For example, ewin -20.0 -10.0 will
only consider excitations from occupied orbitals within the specified
energy window

### Alpha, Beta -- alpha, beta orbital windows

Orbital windows can be specified using the following keywords:

  - alpha 1 4
  - beta 2 5

Here alpha excitations will be considered from orbitals 1 through 4
depending on the number of roots requested and beta excitations will be
considered from orbitals 2 through 5 depending on the number of roots
requested.

### CIVECS -- CI vectors

This keyword will result in the CI vectors being written out. By default
this is off. Please note this can be a very large file, so avoid turning
on this keyword if you are calculating a very large number of roots. CI
vectors are needed for excited-state gradient and transition density
calculations.

### GRAD -- TDDFT gradients

Analytical TDDFT gradients can be calculated by specifying a grad block
within the main TDDFT block

For example, the following will perform a TDDFT optimization on the
first singlet excited state (S1). Note that the civecs keyword must be
specified. To perform a single TDDFT gradient, replace the optimize
keyword with gradient in the task line. A complete TDDFT optimization
input example is given the Sample Inputs section. A TDDFT gradients
calculation allows one to calculate the excited state density of a
specific excited state. This is written to a file with the dmat suffix.

` tddft`  
`  nroots 2`  
`  algorithm 1`  
`  notriplet`  
`  target 1`  
`  targetsym a`  
`  civecs`  
`  grad`  
`    root 1`  
`  end`  
` end`  
` task tddft optimize`

At the moment the following exchange-correlation functionals are
supported with TDDFT
gradients

`LDA, BP86, PBE, BLYP, B3LYP, PBE0, BHLYP, CAM-B3LYP, LC-PBE, LC-PBE0, BNL, LC-wPBE, LC-wPBEh, LC-BLYP`

### CDSpectrum -- optical rotation calculations

Perform optical rotation calculations.

### VELOCITY -- velocity gauge

Perform CD spectrum calculations with the velocity gauge.

### ALGORITHM -- algorithms for tensor contractions

There are four distinct algorithms to choose from, and the default value
of 0 (optimal) means that the program makes an optimal choice from the
four algorithms on the basis of available memory. In the order of
decreasing memory requirement, the four algorithms are:

  - ALGORITHM 1 : Incore, multiple tensor contraction,
  - ALGORITHM 2 : Incore, single tensor contraction,
  - ALGORITHM 3 : Disk-based, multiple tensor contraction,
  - ALGORITHM 4 : Disk-based, single tensor contraction.

The incore algorithm stores all the trial and product vectors in memory
across different nodes with the GA, and often decreases the MAXITER
value to accommodate them. The disk-based algorithm stores the vectors
on disks across different nodes with the DRA, and retrieves each vector
one at a time when it is needed. The multiple and single tensor
contraction refers to whether just one or more than one trial vectors
are contracted with integrals. The multiple tensor contraction algorithm
is particularly effective (in terms of speed) for CIS and TDHF, since
the number of the direct evaluations of two-electron integrals is
diminished substantially.

### FREEZE -- the frozen core/virtual approximation

Some of the lowest-lying core orbitals and/or some of the highest-lying
virtual orbitals may be excluded in the CIS, TDHF, and TDDFT
calculations by this keyword (this does not affect the ground state HF
or DFT calculation). No orbitals are frozen by default. To exclude the
atom-like core regions altogether, one may request

` FREEZE atomic`

To specify the number of lowest-lying occupied orbitals be excluded, one
may use

` FREEZE 10`

which causes 10 lowest-lying occupied orbitals excluded. This is
equivalent to writing

` FREEZE core 10`

To freeze the highest virtual orbitals, use the virtual keyword. For
instance, to freeze the top 5 virtuals

` FREEZE virtual 5`

### PRINT -- the verbosity

This keyword changes the level of output verbosity. One may also request
some particular items in the table
below.

<center>

|                       |             |                                                    |
| --------------------- | ----------- | -------------------------------------------------- |
| Item                  | Print Level | Description                                        |
| "timings"             | high        | CPU and wall times spent in each step              |
| "trial vectors"       | high        | Trial CI vectors                                   |
| "initial guess"       | debug       | Initial guess CI vectors                           |
| "general information" | default     | General information                                |
| "xc information"      | default     | HF/DFT information                                 |
| "memory information"  | default     | Memory information                                 |
| "convergence"         | debug       | Convergence                                        |
| "subspace"            | debug       | Subspace representation of CI matrices             |
| "transform"           | debug       | MO to AO and AO to MO transformation of CI vectors |
| "diagonalization"     | debug       | Diagonalization of CI matrices                     |
| "iteration"           | default     | Davidson iteration update                          |
| "contract"            | debug       | Integral transition density contraction            |
| "ground state"        | default     | Final result for ground state                      |
| "excited state"       | low         | Final result for target excited state              |

Printable items in the TDDFT modules and their default print levels.

</center>

## Sample input

The following is a sample input for a spin-restricted TDDFT calculation
of singlet excitation energies for the water molecule at the
B3LYP/6-31G\*.

`START h2o`  
`TITLE "B3LYP/6-31G* H2O"`  
`GEOMETRY`  
` O     0.00000000     0.00000000     0.12982363`  
` H     0.75933475     0.00000000    -0.46621158`  
` H    -0.75933475     0.00000000    -0.46621158`  
`END`  
`BASIS`  
` * library 6-31G*`  
`END`  
`DFT`  
` XC B3LYP`  
`END`  
`TDDFT`  
` RPA`  
` NROOTS 20`  
`END`  
`TASK TDDFT ENERGY`

To perform a spin-unrestricted TDHF/aug-cc-pVDZ calculation for the CO+
radical,

`START co`  
`TITLE "TDHF/aug-cc-pVDZ CO+"`  
`CHARGE 1`  
`GEOMETRY`  
` C  0.0  0.0  0.0`  
` O  1.5  0.0  0.0`  
`END`  
`BASIS`  
` * library aug-cc-pVDZ`  
`END`  
`DFT`  
` XC HFexch`  
` MULT 2`  
`END`  
`TDDFT`  
` RPA`  
` NROOTS 5`  
`END`  
`TASK TDDFT ENERGY`

A geometry optimization followed by a frequency calculation for an
excited state is carried out for BF at the CIS/6-31G\* level in the
following sample input.

`START bf`  
`TITLE "CIS/6-31G* BF optimization frequencies"`  
`GEOMETRY`  
` B 0.0 0.0 0.0`  
` F 0.0 0.0 1.2`  
`END`  
`BASIS`  
` * library 6-31G*`  
`END`  
`DFT`  
` XC HFexch`  
`END`  
`TDDFT`  
` CIS`  
` NROOTS 3`  
` NOTRIPLET`  
` TARGET 1`  
`END`  
`TASK TDDFT OPTIMIZE`  
`TASK TDDFT FREQUENCIES`

TDDFT with an asymptotically corrected SVWN exchange-correlation
potential. Casida-Salahub scheme has been used with the shift value of
0.1837 a.u. supplied as an input parameter.

`START tddft_ac_co`  
`GEOMETRY`  
` O 0.0 0.0  0.0000`  
` C 0.0 0.0  1.1283`  
`END`  
`BASIS SPHERICAL`  
` C library aug-cc-pVDZ`  
` O library aug-cc-pVDZ`  
`END`  
`DFT`  
` XC Slater VWN_5`  
` CS00 0.1837`  
`END`  
`TDDFT`  
` NROOTS 12`  
`END`  
`TASK TDDFT ENERGY`

TDDFT with an asymptotically corrected B3LYP exchange-correlation
potential. Hirata-Zhan-Apra-Windus-Dixon scheme has been used (this is
only meaningful with B3LYP functional).

`START tddft_ac_co`  
`GEOMETRY`  
` O 0.0 0.0  0.0000`  
` C 0.0 0.0  1.1283`  
`END`  
`BASIS SPHERICAL`  
` C library aug-cc-pVDZ`  
` O library aug-cc-pVDZ`  
`END`  
`DFT`  
` XC B3LYP`  
` CS00`  
`END`  
`TDDFT`  
` NROOTS 12`  
`END`  
`TASK TDDFT ENERGY`

TDDFT for core states. The following example illustrates the usage of an
energy cutoff and energy and orbital windows.

K. Lopata, B. E. Van Kuiken, M. Khalil, N. Govind, "Linear-Response and    
Real-Time Time-Dependent Density Functional Theory Studies of Core-Level   
Near-Edge X-Ray Absorption", J. Chem. Theory Comput., 2012, 8 (9), pp 3284–3292

`echo`  
`start h2o_core`  
`memory 1000 mb`  
`geometry units au noautosym noautoz`  
`  O 0.00000000     0.00000000     0.22170860`  
`  H 0.00000000     1.43758081    -0.88575430`  
`  H 0.00000000    -1.43758081    -0.88575430`  
`end`  
`basis`  
` O library 6-31g*`  
` H library 6-31g*`  
`end`  
`dft`  
` xc beckehandh`  
` print "final vector analysis"`  
`end`  
`task dft`  
`tddft`  
` ecut -10`  
` nroots 5`  
` notriplet`  
` thresh 1d-03`  
`end`  
`task tddft`  
`tddft`  
` ewin -20.0 -10.0`  
` cis`  
` nroots 5`  
` notriplet`  
` thresh 1d-03`  
`end`  
`task tddft`  
`dft`  
` odft`  
` mult 1`  
` xc beckehandh`  
` print "final vector analysis"`  
`end`  
`task dft`  
`tddft`  
` alpha 1 1`  
` beta 1 1`  
` cis`  
` nroots 10`  
` notriplet`  
` thresh 1d-03`  
`end`  
`task tddft`

TDDFT optimization with LDA of Pyridine with the 6-31G basis

`echo`  
`start tddftgrad_pyridine_opt`  
`title "TDDFT/LDA geometry optimization of Pyridine with 6-31G"`  
`geometry nocenter`  
` N     0.00000000    0.00000000    1.41599295`  
` C     0.00000000   -1.15372936    0.72067272`  
` C     0.00000000    1.15372936    0.72067272`  
` C     0.00000000   -1.20168790   -0.67391011`  
` C     0.00000000    1.20168790   -0.67391011`  
` C     0.00000000    0.00000000   -1.38406147`  
` H     0.00000000   -2.07614628    1.31521089`  
` H     0.00000000    2.07614628    1.31521089`  
` H     0.00000000    2.16719803   -1.19243296`  
` H     0.00000000   -2.16719803   -1.19243296`  
` H     0.00000000    0.00000000   -2.48042299`  
` symmetry c1`  
`end`  
`basis spherical`  
`* library "6-31G"`  
`end`  
`driver`  
`  clear`  
`  maxiter 100`  
`end`  
`dft`  
`  iterations 500`  
`  xc slater 1.0 vwn_5 1.0`  
`  grid xfine`  
`  grid euler`  
`  direct`  
`end`  
`tddft`  
`  nroots 2`  
`  algorithm 1`  
`  notriplet`  
`  target 1`  
`  targetsym a`  
`  civecs`  
`  grad`  
`    root 1`  
`  end`  
`end`  
`task tddft optimize`

TDDFT calculation followed by a calculation of the transition density
for a specific excited state using the DPLOT block

`echo`  
`start h2o-td`  
`title h2o-td`  
`memory total 800 stack 400 heap 50 global 350 mb`  
`charge 0`  
`geometry units au noautoz nocenter`  
`symmetry group c1`  
` O    0.00000000000000      0.00000000000000      0.00000000000000`  
` H    0.47043554760291      1.35028113274600      1.06035416576826`  
` H   -1.74335410533480     -0.23369304784300      0.27360785442967`  
`end`  
`basis "ao basis" print`  
` H    S`  
`    13.0107010              0.19682158E-01`  
`     1.9622572              0.13796524`  
`     0.44453796             0.47831935`  
` H    S`  
`     0.12194962             1.0000000`  
` H    P`  
`     0.8000000              1.0000000`  
` O    S`  
`  2266.1767785             -0.53431809926E-02`  
`   340.87010191            -0.39890039230E-01`  
`    77.363135167           -0.17853911985`  
`    21.479644940           -0.46427684959`  
`     6.6589433124          -0.44309745172`  
` O    S`  
`     0.80975975668          1.0000000`  
` O    S`  
`     0.25530772234          1.0000000`  
` O    P`  
`    17.721504317            0.43394573193E-01`  
`     3.8635505440           0.23094120765`  
`     1.0480920883           0.51375311064`  
` O    P`  
`     0.27641544411          1.0000000`  
` O    D`  
`     1.2000000              1.0000000`  
`end`  
`dft`  
` xc bhlyp`  
` grid fine`  
` direct`  
` convergence energy 1d-5`  
`end`  
`tddft`  
` rpa`  
` nroots 5`  
` thresh 1d-5`  
` singlet`  
` notriplet`  
` civecs`  
`end`  
`task tddft energy`  
`dplot`  
` civecs h2o-td.civecs_singlet`  
` root 2`  
` LimitXYZ`  
`  -3.74335 2.47044 50`  
`  -2.23369 3.35028 50`  
`  -2 3.06035 50`  
`   gaussian`  
`   output root-2.cube`  
`end`  
`task dplot`

TDDFT protocol for calculating the valence-to-core (1s) X-ray emission spectrum 

Y. Zhang, S. Mukamel, M. Khalil, N. Govind, "Simulating Valence-to-Core X-ray Emission    
Spectroscopy of Transition Metal", J. Chem. Theory Comput., 2015, 11 (12), pp 5804–5809  
DOI: 10.1021/acs.jctc.5b00763

1.  Calculate the neutral ground state.   
2.  Calculate a full core hole (FCH) ionized state self-consistently, where the  
1s core orbital of the absorbing center is swapped with a virtual orbital. Use the   
maximum overlap constraint to prevent core hole collapse during the FCH calculation.
3.  Perform a LR-TDDFT calculation within the TDA is performed with the FCH ionized    
state as reference. 
4.  Final spectra is produced by taking the absolute value of the negative eigenvalues.