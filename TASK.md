## TASK

The TASK directive is used to tell the code what to do. The input
directives are parsed sequentially until a TASK directive is
encountered, as described in [Input File
Structure](Getting-Started#input-file-structure "wikilink"). At that
point, the calculation or operation specified in the TASK directive is
performed. When that task is completed, the code looks for additional
input to process until the next TASK directive is encountered, which is
then executed. This process continues to the end of the input file.
NWChem expects the last directive before the end-of-file to be a TASK
directive. If it is not, a warning message is printed. Since the
database is persistent, multiple tasks within one job behave exactly the
same as multiple restart jobs with the same sequence of input.

There are four main forms of the the TASK directive. The most common
form is used to tell the code at what level of theory to perform an
electronic structure calculation, and which specific calculations to
perform. The second form is used to specify tasks that do not involve
electronic structure calculations or tasks that have not been fully
implemented at all theory levels in NWChem, such as simple property
evaluations. The third form is used to execute UNIX commands on machines
having a Bourne shell. The fourth form is specific to combined
quantum-mechanics and molecular-mechanics (QM/MM) calculations.

By default, the program terminates when a task does not complete
successfully. The keyword ignore can be used to prevent this
termination, and is recognized by all forms of the TASK directive. When
a TASK directive includes the keyword ignore, a warning message is
printed if the task fails, and code execution continues with the next
task. An example of this feature is given in the [sample input
file](Density-Functional-Theory-for-Molecules#sample-input-file "wikilink").

The input options, keywords, and defaults for each of these four forms
for the TASK directive are discussed in the following sections.

### TASK Directive for Electronic Structure

This is the most commonly used version of the TASK directive, and it has
the following form:

`TASK `<string theory>` [`<string operation default energy>`] [ignore]`

The string <theory> specifies the level of theory to be used in the
calculations for this task. NWChem currently supports ten different
options. These are listed below, with the corresponding entry for the
variable <theory>:

  - scf - Hartree-Fock
  - dft - Density functional theory for molecules
  - sodft - Spin-Orbit Density functional theory
  - mp2 - MP2 using a semi-direct algorithm
  - direct\_mp2 - MP2 using a full-direct algorithm
  - rimp2 - MP2 using the RI approximation
  - ccsd - Coupled-cluster single and double excitations
  - ccsd(t) - Coupled-cluster linearized triples approximation
    1.  ccsd+t(ccsd)\# - Fourth order triples contribution
  - mcscf - Multiconfiguration SCF
  - selci - Selected configuration interaction with perturbation
    correction
  - md - Classical molecular dynamics simulation
  - pspw - Pseudopotential plane-wave density functional theory for
    molecules and insulating solids using NWPW
  - band - Pseudopotential plane-wave density functional theory for
    solids using NWPW
  - tce - Tensor Contraction Engine

The string <operation> specifies the calculation that will be performed
in the task. The default operation is a single point energy evaluation.
The following list gives the selection of operations currently available
in NWChem:

  - energy - Evaluate the single point energy.
  - gradient - Evaluate the derivative of the energy with respect to
    nuclear coordinates.
  - optimize - Minimize the energy by varying the molecular structure.
    By default, this geometry optimization is presently driven by the
    [Driver
    module](Hessians-and-Vibrational-Frequencies#geometry-optimization-with-DRIVER "wikilink"),
    but the [Stepper
    module](Hessians-and-Vibrational-Frequencies#geometry-optimization-with-STEPPER "wikilink")
    may also be used.
  - saddle - Conduct a search for a transition state (or saddle point)
    using either [Driver
    module](Hessians-and-Vibrational-Frequencies#geometry-optimization-with-DRIVER "wikilink")
    (the default) or
    [Stepper](Hessians-and-Vibrational-Frequencies#geometry-optimization-with-STEPPER "wikilink").
  - hessian - Compute second derivatives. See [hessian
    section](Hessians-and-Vibrational-Frequencies#hessians "wikilink") for
    analytic hessians.
  - frequencies or freq - Compute second derivatives and print out an
    analysis of molecular vibrations. See [vibration
    section](Hessians-and-Vibrational-Frequencies#vibrational-frequencies "wikilink")
    for controls for vibration calculations.
  - vscf - Compute anharmonic contributions to the vibrational modes.
    See the [vibrational SCF section](VSCF "wikilink") for options.
  - property - Calculate the properties for the wave function.
  - dynamics - Perform classical molecular dynamics.
  - thermodynamics - Perform multi-configuration thermo-dynamic
    integration using classical MD

NOTE: See [PSPW
Tasks](Plane-Wave-Density-Functional-Theory#pspw-tasks---gamma-point-calculations "wikilink") for
the complete list of operations that accompany the NWPW module.

The user should be aware that some of these operations (gradient,
optimize, dynamics, thermodynamics) require computation of derivatives
of the energy with respect to the molecular coordinates. If analytical
derivatives are not available ([Capabilities](Capabilities "wikilink")),
they must be computed numerically, which can be very computationally
intensive.

Here are some examples of the TASK directive, to illustrate the input
needed to specify particular calculations with the code. To perform a
single point energy evaluation using any level of theory, the directive
is very simple, since the energy evaluation is the default for the
string operation. For an SCF energy calculation, the input line is
simply

`task scf`

Equivalently, the operation can be specified explicitly, using the
directive

`task scf energy`

Similarly, to perform a geometry optimization using density functional
theory, the TASK directive is

`task dft optimize`

The optional keyword ignore can be used to allow execution to continue
even if the task fails, as discussed above. An example with the keyword
ignore can be found in the [DFT
example](Density-Functional-Theory-for-Molecules#sample-input-file "wikilink").

### TASK Directive for Special Operations

This form of the TASK directive is used in instances where the task to
be performed does not fit the model of the previous version (such as
execution of a [Python program](Python "wikilink")), or if the operation
has not yet been implemented in a fashion that applies to a wide range
of theories (e.g., property evaluation). Instead of requiring theory and
operation as input, the directive needs only a string identifying the
task. The form of the directive in such cases is as follows:

`TASK `<string task>` [ignore]`

The supported tasks that can be accessed with this form of the TASK
directive are listed below, with the corresponding entries for string
variable

<task>

.

  - python - Execute a [Python program](Python "wikilink").
  - rtdbprint - Print the contents of the database.
  - cphf - Invoke the CPHF module.
  - property - Perform miscellaneous property calculations.
  - dplot - Execute a [DPLOT run](DPLOT "wikilink").

This directive also recognizes the keyword ignore, which allows
execution to continue after a task has failed.

### TASK Directive for Bourne Shell

This form of the TASK directive is supported only on machines with a
fully UNIX-style operating system. This directive causes specified
processes to be executed using the Bourne shell. This form of the task
directive is:

`TASK shell [(`<integer-range process = 0>`||all)]  `<string command>

The keyword shell is required for this directive. It specifies that the
given command will be executed in the Bourne shell. The user can also
specify which process(es) will execute this command by entering values
for process on the directive. The default is for only process zero to
execute the command. A range of processes may be specified, using
Fortran triplet notation. Alternatively, all processes can be specified
simply by entering the keyword all. The input entered for command must
form a single string, and must consist of valid UNIX command(s). If the
string includes white space, it must be enclosed in double quotes.

For example, the TASK directive to tell process zero to copy the
molecular orbitals file to a backup location /piofs/save can be input as
follows:

`task shell "cp *.movecs /piofs/save"`

The TASK directive to tell all processes to list the contents of their
/scratch directories is as follows:

`task shell all "ls -l /scratch"`

The TASK directive to tell processes 0 to 10 to remove the contents of
the current directory is as follows:

`task shell 0:10:1 "/bin/rm -f *"`

Note that NWChem's ability to quote special input characters is very
limited when compared with that of the Bourne shell. To execute all but
the simplest UNIX commands, it is usually much easier to put the shell
script in a file and execute the file from within NWChem.

### TASK Directive for QM/MM simulations

This is very similar to the most commonly used version of the [TASK
directive](TASK "wikilink"),
and it has the following
form:

`TASK QMMM `<string theory>` [`<string operation default energy>`] [ignore]`

The string <theory> specifies the QM theory to be used in the QM/MM
simulation. If theory is "md" this is not a QM/MM simulation and will
result in an appropriate error. The level of theory may be any QM method
that can compute gradients but those algorithms in NWChem that do not
support analytic gradients should be avoided (see
[Functionality](Functionality "wikilink")).

The string <operation> is used to specify the calculation that will be
performed in the QM/MM task. The default operation is a single point
energy evaluation. The following list gives the selection of operations
currently available in the NWChem QM/MM module;

  - energy - single point energy evaluation
  - optimize - minimize the energy by variation of the molecular
    structure.
  - dynamics - molecular dynamics using nwARGOS

Here are some examples of the TASK directive for QM/MM simulations. To
perform a single point energy of a QM/MM system using any QM level of
theory, the directive is very simple. As with the general task
directive, the QM/MM energy evaluation is the default. For a DFT energy
calculation the task directive input is,

`task qmmm dft`

or completely as

`task qmmm dft energy`

To do a molecular dynamics simulation of a QM/MM system using the SCF
level of theory the task directive input would be

`task qmmm scf dynamics`

The optional keyword ignore can be used to allow execution to continue
even if the task fails, as discussed above.

### TASK Directive for BSSE calculations

NWChem computes the basis set superposition error (BSSE) when two or
more fragments are interacting by using the counterpoise method. This
directive is performed if the BSSE section is present. Single point
energies, energy gradients, geometry optimizations, Hessians and
frequencies, at the level of theory that allows these tasks, can be
obtained with the BSSE correction. The input options for the BSSE
section are:
```
BSSE   
 MON <string monomer name> <integer natoms>  
 [INPUT [<string input>]]    
 [INPUT_WGHOST[<string input>]]    
 [CHARGE [<real charge>]]    
 [ MULT <integer mult>]  
 [OFF]    
 [ON]  
END
```
MON defines the monomer's name and its atoms; <string monomer name>
defines the name of the monomer, <integer atoms> is the list of atoms
corresponding to the monomer (where such a list is relative to the
initial geometry). This information is needed for each monomer. With the
tag INPUT the user can modify any calculation attributes for each
monomer without ghost. For example, the iterations number and the grid
can be changed in a DFT calculation (see the example of the interaction
between \(Zn^{2+}\) and water). INPUT\_WGHOST is the same than INPUT but
for the monomer with ghost. The input changes will be applied within
this and for the following calculations, you should be cautious
reverting the changes for the next monomers. CHARGE assigns a charge to
a monomer and it must be consistent with the total charge in the whole
system (see Section -sec:charge-). The options OFF and ON turns off and
on any BSSE calculation.

The energy evaluation involves 1 + 2N calculations, i.e. one for the
supermolecule and two for the N monomers. \[S. Simon, M. Duran, J. J.
Dannenberg, J. Chem. Phys., 105, 11024 (1996)\] NWChem stores the vector
files for each calculation (<string monomer name>.bsse.movecs), and one
hessian file (<string monomer name>.bsse.hess). The code does not assign
automatically the basis set for the ghost atoms, you must assign the
corresponding bqX for each element, instead.

### Examples

The dimer (FH)<sub>2</sub>

```
title dimer  
start dimer  
geometry units angstrom  
  symmetry c1   
  F 1.47189 2.47463 -0.00000   
  H 1.47206 3.29987 0.00000    
  F 1.46367 -0.45168 0.00000   
  H 1.45804 0.37497 -0.00000  
end  
basis "ao basis"   
  F library 6-31G   
  H library 6-31G   
  bqF library F 6-31G   
  bqH library H 6-31G 
end
dft; xc slater 1.0 vwn_5 1.0; direct; end 
bsse 
 mon first 1 2   
 mon second 3 4  
end
task dft energy
```
Changing maxiter for a specific monomer: (Zn<sup>2+</sup>(H<sub>2</sub>O))

`title znwater`  
`start znwater`  
`echo`  
`geometry noautoz units angstrom`  
`  symmetry c1 `  
`  Zn -1.89334 -0.72741 -0.00000 `  
`  O -0.20798 0.25012 0.00000  `  
`  H -0.14200 1.24982 -0.00000 `  
`  H 0.69236 -0.18874 -0.00000`  
`end`  
`basis "ao basis" `  
`  O library 6-31G `  
`  Zn library 6-31G `  
`  H library 6-31G `  
`  bqO library O 6-31G `  
`  bqZn library Zn 6-31G `  
`  bqH library H 6-31G`  
`end`  
`charge 2`  
`scf; direct; end`  
`mp2; end`  
`bsse `  
` mon metal 1 `  
` charge 2 `  
` input_wghost "scf\; maxiter 200\; end" `  
` mon water 2 3 4`  
`end`  
`task mp2 optimize`
