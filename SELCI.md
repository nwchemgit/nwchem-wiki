# Selected CI

The selected CI module is integrated into NWChem but as yet no input
module has been written [1]. The input thus consists of setting the
appropriate variables in the database.

It is assumed that an initial SCF/MCSCF calculation has completed, and
that MO vectors are available. These will be used to perform a
four-index transformation, if this has not already been performed.

## Background

This is a general spin-adapted, configuration-driven CI program which
can perform arbitrary CI calculations, the only restriction being that
all spin functions are present for each orbital occupation. CI
wavefunctions may be specified using a simple configuration generation
program, but the prime usage is intended to be in combination with
perturbation correction and selection of new configurations. The
second-order correction (Epstein-Nesbet) to the CI energy may be
computed, and at the same time configurations that interact greater than
a certain threshold with the current CI wavefunction may be chosen for
inclusion in subsequent calculations. By repeating this process
(typically twice is adequate) with the same threshold until no new
configurations are added, the CI expansion may be made consistent with
the selection threshold, enabling tentative extrapolation to the full-CI
limit.

A typical sequence of calculations is as follows:

1.  Pick as an initial CI reference the previously executed SCF/MCSCF.
2.  Define an initial selection threshold.
3.  Determine the roots of interest in the current reference space.
4.  Compute the perturbation correction and select additional
    configurations that interact greater than the current threshold.
5.  Repeat steps 3 and 4.
6.  Lower the threshold (a factor of 10 is common) and repeat steps 3,
    4, and 5. The first pass through step 4 will yield the approximately
    self-consistent CI and CI+PT energies from the previous selection
    threshold.

To illustrate this, below is some abbreviated output from a calculation
on water in an augmented cc-PVDZ basis set with one frozen core orbital.
The SCF was converged to high precision in \(C_{2v}\) symmetry with the
following input
```
 start h2o  
 geometry; symmetry c2v  
   O 0 0 0; H 0 1.43042809 -1.10715266  
 end  
 basis  
   H library aug-cc-pvdz; O library aug-cc-pvdz  
 end  
 task scf  
 scf; thresh 1d-8; end
```
The following input restarts from the SCF to perform a sequence of
selected CI calculations with the specified tolerances, starting with
the SCF reference.
```
 restart h2o  
 set fourindex:occ_frozen 1  
 set selci:mode select  
 set "selci:selection thresholds" \  
     0.001 0.001 0.0001 0.0001 0.00001 0.00001 0.000001  
 task selci
```
The table below summarizes the output from each of the major
computational steps that were
performed.

<center>

|       |                                |           |                                       |
| ----- | ------------------------------ | --------- | ------------------------------------- |
|       |                                | CI        |                                       |
| Step  | Description                    | dimension | Energy                                |
|       |                                |           |                                       |
| 1     | Four-index, one frozen-core    |           |                                       |
| 2     | Config. generator, SCF default | 1         |                                       |
| 3+4   | CI diagonalization             | 1         | \(E_{CI} = -76.041983\)               |
| 5     | PT selection T=0.001           | 1         | \(E_{CI+PT} = -76.304797\)            |
| 6+7   | CI diagonalization             | 75        | \(E_{CI} = -76.110894\)               |
| 8     | PT selection T=0.001           | 75        | \(E_{CI+PT} = -76.277912\)            |
| 9+10  | CI diagonalization             | 75        | \(E_{CI}(T=0.001) = -76.110894\)      |
| 11    | PT selection T=0.0001          | 75        | \(E_{CI+PT}(T=0.001) = -76.277912\)   |
| 12+13 | CI diagonalization             | 823       | \(E_{CI} = -76.228419\)               |
| 14    | PT selection T=0.0001          | 823       | \(E_{CI+PT} = -76.273751\)            |
| 15+16 | CI diagonalization             | 841       | \(E_{CI}(T=0.0001) = -76.2300544\)    |
| 17    | PT selection T=0.00001         | 841       | \(E_{CI+PT}(T=0.0001) = -76.274073\)  |
| 18+19 | CI diagonalization             | 2180      | \(E_{CI} = -76.259285\)               |
| 20    | PT selection T=0.00001         | 2180      | \(E_{CI+PT} = -76.276418\)            |
| 21+22 | CI diagonalization             | 2235      | \(E_{CI}(T=0.00001) = -76.259818\)    |
| 23    | PT selection T=0.000001        | 2235      | \(E_{CI+PT}(T=0.00001) = -76.276478\) |
| 24    | CI diagonalization             | 11489     |                                       |

Summary of steps performed in a selected CI calculation on water.

</center>

## Files

Currently, no direct control is provided over filenames. All files are
prefixed with the standard file-prefix, and any files generated by all
nodes are also postfixed with the processor number. Thus, for example
the molecular integrals file, used only by process zero, might be called
h2o.moints whereas the off-diagonal Hamiltonian matrix element file used
by process number eight would be called h2o.hamil.8.

  - ciconf -- the CI configuration file, which holds information about
    the current CI expansion, indexing vectors, etc. This is the most
    important file and is required for all restarts. Note that the CI
    configuration generator is only run if this file does not exist.
    Referenced only by process zero.
  - moints -- the molecular integrals, generated by the four-index
    transformation. As noted above these must currently be manually
    deleted, or the database entry selci:moints:force set, to force
    regeneration. Referenced only by process zero.
  - civecs -- the CI vectors. Referenced only by process zero.
  - wmatrx -- temporary file used to hold coupling coefficients. Deleted
    at calculation end. Referenced only by process zero.
  - rtname, roname -- restart information for the PT selection. Should
    be automatically deleted if no restart is necessary. Referenced only
    by process zero.
  - hamdg -- diagonal elements of the Hamiltonian. Deleted at
    calculation end. Referenced only by process zero.
  - hamil -- off-diagonal Hamiltonian matrix elements. All processes
    generate a file containing a subset of these elements. These files
    can become very large. Deleted at calculation end.

## Configuration Generation

If no configuration is explicitly specified then the previous SCF/MCSCF
wavefunction is used, adjusting for any orbitals frozen in the
four-index transformation. The four-index transformation must have
completed successfully before this can execute. Orbital configurations
for use as reference functions may also be explicitly specified.

Once the default/user-input reference configurations have been
determined additional reference functions may be generated by applying
multiple sets of creation-annihilation operators, permitting for
instance, the ready specification of complete or restricted active
spaces.

Finally, a uniform level of excitation from the current set of
configurations into all orbitals may be applied, enabling, for instance,
the simple creation of single or single+double excitation spaces from an
MCSCF reference.

### Specifying the reference occupation

A single orbital configuration or occupation is specified by
```
 ns  (socc(i),i=1,ns)  (docc(i),i=1,nd)
```
where ns specifies the number of singly occupied orbitals, socc() is the
list of singly occupied orbitals, and docc() is the list of doubly
occupied orbitals (the number of doubly occupied orbitals, nd, is
inferred from ns and the total number of electrons). All occupations may
be strung together and inserted into the database as a single integer
array with name "selci:conf". For example, the input
```
 set "selci:conf" \  
   0                1  2  3  4 \  
   0                1  2  3 27 \  
   0                1  3  4 19 \  
   2   11 19        1  3  4 \  
   2    8 27        1  2  3 \  
   0                1  2  4 25 \  
   4   3  4 25 27   1  2 \  
   4   2  3 19 20   1 4 \  
   4   2  4 20 23   1 3
```
specifies the following nine orbital configurations
```
  1(2)  2(2)  3(2)  4(2)  
  1(2)  2(2)  3(2) 27(2)  
  1(2)  3(2)  4(2) 19(2)  
  1(2)  3(2)  4(2) 11(1) 19(1)  
  1(2)  2(2)  3(2)  8(1) 27(1)  
  1(2)  2(2)  4(2) 25(2)  
  1(2)  2(2)  3(1)  4(1) 25(1) 27(1)  
  1(2)  2(1)  3(1)  4(2) 19(1) 20(1)  
  1(2)  2(1)  3(2)  4(1) 20(1) 23(1)
```
The optional formatting of the input is just to make this arcane
notation easier to read. Relatively few configurations can be currently
specified in this fashion because of the input line limit of 1024
characters.

### Applying creation-annihilation operators

Up to 10 sets of creation-annihilation operator pairs may be specified,
each set containing up to 255 pairs. This suffices to specify complete
active spaces with up to ten electrons.

The number of sets is specified as follows,

` set selci:ngen 4`

which indicates that there will be four sets. Each set is then specified
as a separate integer array
```
 set "selci:refgen  1" 5 4    6 4   5 3   6 3    
 set "selci:refgen  2" 5 4    6 4   5 3   6 3    
 set "selci:refgen  3" 5 4    6 4   5 3   6 3    
 set "selci:refgen  4" 5 4    6 4   5 3   6 3
```
In the absence of friendly, input note that the names "selci:refgen n"
must be formatted with n in I2 format. Each set specifies a list of
creation-annihilation operator pairs (in that order). So for instance,
in the above example each set is the same and causes the excitations
```
 4->5   4->6   3->5   3->6
```
If orbitals 3 and 4 were initially doubly occupied, and orbitals 5 and 6
initially unoccupied, then the application of this set of operators four
times in succession is sufficient to generate the four electron in four
orbital complete active space.

The precise sequence in which operators are applied is

1.  loop through sets of operators
2.  loop through reference configurations
3.  loop through operators in the set
4.  apply the operator to the configuration, if the result is new add it
    to the new list
5.  end the loop over operators
6.  end the loop over reference configurations
7.  augment the configuration list with the new list
8.  end the loop over sets of operators

### Uniform excitation level

By default no excitation is applied to the reference configurations. If,
for instance, you wanted to generate a single excitation CI space from
the current configuration list, specify
```
 set selci:exci 1
```
Any excitation level may be applied, but since the list of
configurations is explicitly generated, as is the CI Hamiltonian matrix,
you will run out of disk space if you attempt to use more than a few
tens of thousands of configurations.

## Number of roots

By default, only one root is generated in the CI diagonalization or
perturbation selection. The following requests that 2 roots be generated
```
 set selci:nroot 2
```
There is no imposed upper limit. If many roots are required, then, to
minimize root skipping problems, it helps to perform an initial
approximate diagonalization with several more roots than required, and
then resetting this parameter once satisfied that the desired states are
obtained.

## Accuracy of diagonalization

By default, the CI wavefunctions are converged to a residual norm of
\(10^{-6}\) which provides similar accuracy in the perturbation
corrections to the energy, and much higher accuracy in the CI
eigenvalues. This may be adjusted with
```
set "selci:diag tol" 1d-3
```
the example setting much lower precision, appropriate for the
approximate diagonalization discussed in the preceding section.

## Selection thresholds

When running in the selected-CI mode the program will loop through a
list of selection thresholds (*T*), performing the CI diagonalization,
computing the perturbation correction, and augmenting the CI expansion
with configurations that make an energy lowering to any root greater
than *T*. The list of selection thresholds is specified as follows
```
 set "selci:selection thresholds" \  
     0.001 0.001 0.0001 0.0001 0.00001 0.00001 0.000001
```
There is no default for this parameter.

## Mode

By default the program runs in "ci+davids" mode and just determines the
CI eigenvectors/values in the current configuration space. To perform a
selected-CI with perturbation correction use the following
```
 set selci:mode select
```
and remember to define the selection thresholds.

## Memory requirements

No global arrays are used inside the selected-CI, though the four-index
transformation can be automatically invoked and it does use GAs. The
selected CI replicates inside each
process  

   * all unique two-electron integrals in the MO basis that are non-zero by symmetry, and   
   * all CI information, including the CI vectors.

These large data structures are allocated on the local stack. A fatal
error will result if insufficient memory is available.

## Forcing regeneration of the MO integrals

When scanning a potential energy surface or optimizing a geometry the MO
integrals need to be regenerated each time. Specify
```
 set selci:moints:force logical .true.
```
to accomplish this.

## Disabling update of the configuration list

When computing CI+PT energy the reference configuration list is normally
updated to reflect all configurations that interact more than the
specified threshold. This is usually desirable. But when scanning a
potential energy surface or optimizing a geometry the reference list
must be kept fixed to keep the potential energy surface continuous and
well defined. To do this specify
```
 set selci:update logical .false.
```
## Orbital locking in CI geometry optimization

The selected CI wavefunction is not invariant to orbital rotations or to
swapping two or more orbitals. Orbitals could be swapped or rotated when
the geometry is changed in a geometry optimization step. The keyword
lock has to be set in the SCF/MCSCF (vectors) input block to keep the
orbitals in the same order throughout the geometry optimization.

## References


1.   R. J. Harrison (1991). "Approximating full configuration interaction with selected configuration interaction and perturbation theory". Journal of Chemical Physics 94: 5021-5031. doi:10.1063/1.460537. 
