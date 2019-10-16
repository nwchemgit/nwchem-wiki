# MCSCF

The NWChem multiconfiguration SCF (MCSCF) module can currently perform
complete active space SCF (CASSCF) calculations with at most 20 active
orbitals and about 500 basis
functions.
```
 MCSCF  
   STATE <string state>  
   ACTIVE <integer nactive>  
   ACTELEC <integer nactelec>  
   MULTIPLICITY `<integer multiplicity>  
   [SYMMETRY <integer symmetry default 1>]  
   [VECTORS [[input] <string input_file default file_prefix.movecs>]   
          [swap <integer vec1 vec2> ...] \  
          [output <string output_file default input_file>] \  
          [lock]  
   [HESSIAN (exact||onel)]  
   [MAXITER <integer maxiter default 20>]  
   [THRESH  <real thresh default 1.0e-4>]  
   [TOL2E <real tol2e default 1.0e-9>] 
   [LEVEL <real shift default 0.1d0>]  
 END
```
Note that the ACTIVE, ACTELEC, and MULTIPLICITY directives are required.
The symmetry and multiplicity may alternatively be entered using the
STATE directive.

## ACTIVE -- Number of active orbitals

The number of orbitals in the CASSCF active space must be specified
using the ACTIVE directive.

E.g.,
```
 active 10
```
The input molecular orbitals (see the vectors directive in [MCSCF
Vectors](#VECTORS_--_Input/output_of_MO_vectors "wikilink") and [SCF
Vectors](Hartree-Fock-Theory-for-Molecules#vectors----inputoutput-of-mo-vectors "wikilink"))
must be arranged in order

1.  doubly occupied orbitals,
2.  active orbitals, and
3.  unoccupied orbitals.

## ACTELEC -- Number of active electrons

The number of electrons in the CASSCF active space must be specified
using the the ACTELEC directive. An error is reported if the number of
active electrons and the multiplicity are inconsistent.

The number of closed shells is determined by subtracting the number of
active electrons from the total number of electrons (which in turn is
derived from the sum of the nuclear charges minus the total system
charge).

## MULTIPLICITY

The spin multiplicity must be specified and is enforced by projection of
the determinant wavefunction.

E.g., to obtain a triplet state
```
 multiplicity 3
```
## SYMMETRY -- Spatial symmetry of the wavefunction

This species the irreducible representation of the wavefunction as an
integer in the range 1--8 using the same numbering of representations as
output by the SCF program. Note that only Abelian point groups are
supported.

E.g., to specify a <img alt="$B_1$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/fe468915e44d9e34d437fbf99b371809.svg?invert_in_darkmode&sanitize=true" align=middle width="18.95025pt" height="22.38192pt"/> state when using the <img alt="$C_{2v}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/fbae2e8884819f6fd147d3039ef3a9bc.svg?invert_in_darkmode&sanitize=true" align=middle width="25.19517pt" height="22.38192pt"/> group
```
 symmetry 3
```
## STATE -- Symmetry and multiplicity

The electronic state (spatial symmetry and multiplicity) may
alternatively be specified using the conventional notation for an
electronic state, such as <img alt="$^3B_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/6e2161ad2ba92369ce803c5813cce493.svg?invert_in_darkmode&sanitize=true" align=middle width="26.324595pt" height="26.70657pt"/> for a triplet state of <img alt="$B_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2b7de9b9b655b068f97484efba8812fb.svg?invert_in_darkmode&sanitize=true" align=middle width="18.95025pt" height="22.38192pt"/>
symmetry. This would be accomplished with the input
```
 state 3b2
```
which is equivalent to
```
 symmetry 4 
 multiplicity 3
```
## VECTORS -- Input/output of MO vectors

Calculations are best started from RHF/ROHF molecular orbitals (see
[SCF](Hartree-Fock-Theory-for-Molecules "wikilink")), and by
default vectors are taken from the previous MCSCF or SCF calculation. To
specify another input file use the VECTORS directive. Vectors are by
default output to the input file, and may be redirected using the output
keyword. The swap keyword of the
[VECTORS](Hartree-Fock-Theory-for-Molecules#vectors----inputoutput-of-mo-vectors "wikilink")
directive may be used to reorder orbitals to obtain the correct active
space.

The
[LOCK](Hartree-Fock-Theory-for-Molecules#vectors----inputoutput-of-mo-vectors "wikilink")
keyword allows the user to specify that the ordering of orbitals will be
locked to that of the initial vectors, insofar as possible. The default
is to order by ascending orbital energies within each orbital space. One
application where locking might be desirable is a calculation where it
is necessary to preserve the ordering of a previous geometry, despite
flipping of the orbital energies. For such a case, the LOCK directive
can be used to prevent the SCF calculation from changing the ordering,
even if the orbital energies change.

Output orbitals of a converged MCSCF calculation are canonicalized as
follows:

  - Doubly occupied and unoccupied orbitals diagonalize the
    corresponding blocks of an effective Fock operator. Note that in the
    case of degenerate orbital energies this does not fully determine
    the orbtials.
  - Active-space orbitals are chosen as natural orbitals by
    diagonalization of the active space 1-particle density matrix. Note
    that in the case of degenerate occupations that this does not fully
    determine the orbitals.

## HESSIAN -- Select preconditioner

The MCSCF will use a one-electron approximation to the orbital-orbital
Hessian until some degree of convergence is obtained, whereupon it will
attempt to use the exact orbital-orbital Hessian which makes the micro
iterations more expensive but potentially reduces the total number of
macro iterations. Either choice may be forced throughout the calculation
by specifying the appropriate keyword on the HESSIAN directive.

E.g., to specify the one-electron approximation throughout
```
 hessian onel
```
## LEVEL -- Level shift for convergence

The [Hessian](Hessians-and-Vibrational-Frequencies "wikilink")
used in the MCSCF optimization is by default level shifted by 0.1 until
the orbital gradient norm falls below 0.01, at which point the level
shift is reduced to zero. The initial value of 0.1 may be changed using
the LEVEL directive. Increasing the level shift may make convergence
more stable in some instances.

E.g., to set the initial level shift to 0.5
```
 level 0.5
```
## PRINT and NOPRINT

Specific output items can be selectively enabled or disabled using the
[print control
mechanism](Top-level#PRINT_.2F_NOPRINT "wikilink") with the
available print options listed in the table
below.

<center>

|                     |         |                                        |          |
| ------------------- | ------- | -------------------------------------- | -------- |
| MCSCF Print Options | Option  | Class                                  | Synopsis |
| ci energy           | default | CI energy eigenvalue                   |
| fock energy         | default | Energy derived from Fock matrices      |
| gradient norm       | default | Gradient norm                          |
| movecs              | default | Converged occupied MO vectors          |
| trace energy        | high    | Trace Energy                           |
| converge info       | high    | Convergence data and monitoring        |
| precondition        | high    | Orbital preconditioner iterations      |
| microci             | high    | CI iterations in line search           |
| canonical           | high    | Canonicalization information           |
| new movecs          | debug   | MO vectors at each macro-iteration     |
| ci guess            | debug   | Initial guess CI vector                |
| density matrix      | debug   | One- and Two-particle density matrices |

</center>
