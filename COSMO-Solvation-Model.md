# COSMO Solvation Model

COSMO is the continuum solvation \`COnductor-like Screening MOdel' of A.
Klamt and G. Schüürmann to describe dielectric screening effects in
solvents\[1\]. This model has been enhanced by D.M. York and M.
Karplus\[2\] to create a smooth potential energy surface. The latter
facilitates geometry optimization and dynamics and the implementation
has been adapted to take advantage of those ideas.

The NWChem COSMO module implements algorithm for calculation of the
energy for the following methods:

1.  Restricted Hartree-Fock (RHF),
2.  Restricted open-shell Hartree-Fock (ROHF),
3.  Restricted Kohn-Sham DFT (DFT),
4.  Unrestricted Kohn-Sham DFT (ODFT),

by determining the solvent reaction field self-consistently with the
solute charge distribution from the respective methods. Note that COSMO
for unrestricted Hartree-Fock (UHF) method can also be performed by
invoking the DFT module with appropriate keywords.

Correlation energy of solvent molecules may also be evaluated at

1.  MP2,
2.  CCSD,
3.  CCSD+T(CCSD),
4.  CCSD(T),

levels of theory. It is cautioned, however, that these correlated COSMO
calculations determine the solvent reaction field using the HF charge
distribution of the solute rather than the charge distribution of the
correlation theory and are not entirely self consistent in that respect.
In other words, these calculations assume that the correlation effect
and solvation effect are largely additive, and the combination effect
thereof is neglected. COSMO for MCSCF has not been implemented yet.

In the current implementation the code calculates the gas-phase energy
of the system followed by the solution-phase energy, and returns the
electrostatic contribution to the solvation free energy. At the present
gradients are calculated analytically, but frequencies are calculated by
finite difference of the gradients. Known problems include that the code
does not work with spherical basis functions. The non-electrostatic
contributions can be calculated by turning on the SMD model. It should
be noted that one must in general take into account the standard state
correction besides the electrostatic and cavitation/dispersion
contribution to the solvation free energy, when a comparison to
experimental data is made.

Invoking the COSMO solvation model is done by specifying the input COSMO
input block with the input options as:
```
cosmo  
  [off]  
  [dielec  <real dielec default 78.4>]  
  [parameters <filename>]  
  [radius  <real atom1>  
           <real atom2>  
      . . .  
           <real atomN>]  
  [iscren  <integer iscren default 0>]  
  [minbem  <integer minbem default 2>]  
  [ificos  <integer ificos default 0>]  
  [lineq   <integer lineq default 1>]  
  [zeta <real zeta default 0.98>]  
  [gamma_s <real gammas default 1.0>]  
  [sw_tol <real swtol default 1.0e-4>]  
  [do_gasphase `<logical do_gasphase default True>] 
  [do_cosmo_ks]  
end
```
followed by the task directive specifying the wavefunction and type of
calculation, e.g., "task scf energy", "task mp2 energy", "task dft
optimize", etc.

"off' can be used to turn off COSMO in a compound (multiple task) run.
By default, once the COSMO solvation model has been defined it will be
used in subsequent calculations. Add the keyword "off" if COSMO is not
needed in subsequent calculations.

"Dielec" is the value of the dielectric constant of the medium, with a
default value of 78.4 (the dielectric constant for water).

"parameters" specifies COSMO radii parameters file that stores custom
setting for COSMO parameters. The format for such file consists of the
atom or element name followed by the radii. The program will first
attempt to match based on atom name and only then the element name.
Otherwise radius will be set based on default parameters. The file has
to present in one of the three location ( in the order of preference) -
directory specified by the environmental variable
NWCHEM\_COSMO\_LIBRARY, permanent directory, and run directory. This
directive is replacing previous facility of loading COSMO radii
parameters through "set cosmo:map cosmo.par" directive. See example at
the end of this section.

"Radius" is an array that specifies the radius of the spheres associated
with each atom and that make up the molecule-shaped cavity. These values
will override default radii setting including those specified in the
COSMO parameter file (if any) Default values are Van der Waals radii.
Values are in units of angstroms. The codes uses the following Van der
Waals radii by default:

Default radii provided by Andreas Klamt (Cosmologic)

vdw radii: 1.17 (+/- 0.02) \* Bondi radius\[3\]

optimal vdw radii for H, C, N, O, F, S, Cl, Br, I\[4\]

for heavy elements: 1.17\*1.9
```
     data (vander(i),i=1,102)  
    1 / 1.300,1.638,1.404,1.053,2.0475,2.00,  
    2   1.830,1.720,1.720,1.8018,1.755,1.638,  
    3   1.404,2.457,2.106,2.160,2.05,2.223,  
    4   2.223,2.223,2.223,2.223,2.223,2.223,  
    5   2.223,2.223,2.223,2.223,2.223,2.223,  
    6   2.223,2.223,2.223,2.223,2.160,2.223,  
    7   2.223,2.223,2.223,2.223,2.223,2.223,  
    8   2.223,2.223,2.223,2.223,2.223,2.223,  
    9   2.223,2.223,2.223,2.223,2.320,2.223,  
    1   2.223,2.223,2.223,2.223,2.223,2.223,  
    2   2.223,2.223,2.223,2.223,2.223,2.223,  
    3   2.223,2.223,2.223,2.223,2.223,2.223,  
    4   2.223,2.223,2.223,2.223,2.223,2.223,  
    5   2.223,2.223,2.223,2.223,2.223,2.223,  
    6   2.223,2.223,2.223,2.223,2.223,2.223,  
    7   2.223,2.223,2.223,2.223,2.223,2.223,  
    7   2.223,2.223,2.223,2.223,2.223,2.223/
```
For examples see Stefanovich et al.\[5\] and Barone et al.\[6\]

"Rsolv" is no longer used.

"Iscren" is a flag to define the dielectric charge scaling option.
"iscren 1" implies the original scaling from Klamt and Schüürmann,
mainly "\((\epsilon-1)/(\epsilon+1/2)\)", where \(\epsilon\) is the
dielectric constant. "iscren 0" implies the modified scaling suggested
by Stefanovich and Truong\[7\], mainly "\((\epsilon-1)/\epsilon\)".
Default is to use the modified scaling. For high dielectric the
difference between the scaling is not significant.

The next two parameters define the tesselation of the unit sphere. The
approach still follows the original proposal by Klamt and Schüürmann to
some degree. Basically a tesselation is generated from "minbem" refining
passes starting from either an octahedron or an icosahedron. Each level
of refinement partitions the triangles of the current tesselation into
four triangles. This procedure is repeated recursively until the desired
granularity of the tesselation is reached. The induced point charges
from the polarization of the medium are assigned to the centers of the
tesselation. The default value is "minbem 2". The flag +ificos+ serves
to select the original tesselation, "ificos 0" for an octahedron
(default) and "ificos 1" for an icoshedron. Starting from an icosahedron
yields a somewhat finer tesselation that converges somewhat faster.
Solvation energies are not really sensitive to this choice for
sufficiently fine tesselations. The old "maxbem" directive is no longer
used.

The "lineq" parameter serves to select the numerical algorithm to solve
the linear equations yielding the effective charges that represent the
polarization of the medium. "lineq 0" selects an iterative method
(default), "lineq 1" selects a dense matrix linear equation solver. For
large molecules where the number of effective charges is large, the
codes selects the iterative method.

"zeta" sets the width of the Gaussian charge distributions that were
suggested by York and Karplus to avoid singularities when two surface
charges coincide. The default value is "zeta 0.98" this value was chosen
to ensure that the results of the current implementation are as close as
possible to those of the original Klamt and Schuurmann based
implementation.

"gamma\_s" modifies the width of the smooth switching function that
eliminates surface charges when their positions move into the sphere of
a neighboring atom. "gamma\_s 0.0" leads to a heavyside or abrupt
switching function, whereas "gamma\_s 1.0" maximizes the width of the
switching function. The default value is "gamma\_s 1.0".

"sw\_tol" specifies the cutoff of the switching function below which a
surface charge at a particular point is eliminated. The values of the
switching function lie in the domain from 0 to 1. This value should not
be set too small as that leads to instabilities in the linear system
solvers. The default value is "sw\_tol 1.0e-4".

"do\_gasphase" is a flag to control whether the calculation of the
solvation energy is preceded by a gas phase calculation. The default is
to always perform a gas phase calculation first and then calculate the
solvation starting from the converged gas phase electron density.
However, in geometry optimizations this approach can double the cost. In
such a case setting "do\_gasphase false" suppresses the gas phase
calculations and only the solvated system calculations are performed.
This option needs to be used with care as in some cases starting the
COSMO solvation from an unconverged electron density can generate
unphysical charges that lock the calculation into strange electron
distributions.

"do\_cosmo\_ks" is a flag to turn on the Klamt-Schuurmann model

"do\_cosmo\_yk" is a flag to turn on the York-Karplus model (default)

The following example is for a water molecule in \`water', using the
HF/6-31G\*\* level of
theory:
```
start  
echo  
 title "h2o"  
geometry  
 o                  .0000000000         .0000000000        -.0486020332  
 h                  .7545655371         .0000000000         .5243010666  
 h                 -.7545655371         .0000000000         .5243010666  
end  
basis segment cartesian  
 o library 6-31g**  
 h library 6-31g**  
end  
cosmo  
 dielec 78.0  
 radius 1.40  
        1.16  
        1.16  
 lineq  0  
end  
task scf energy
```
Alternatively, instead of listing COSMO radii parameters in the input,
the former can be loaded using an external file through the "parameters"
directive
```
start  
echo  
 title "h2o"  
geometry  
 ow                  .0000000000         .0000000000        -.0486020332  
 hw                  .7545655371         .0000000000         .5243010666  
 h                  -.7545655371         .0000000000         .5243010666  
end  
basis segment cartesian  
 * library 6-31g**  
end

cosmo  
 dielec 78.0  
 lineq  0  
 parameters water.par  
end

task scf energy
```
where "water.par" may the following form:
```
O 1.40
H 1.16
```
This will set radii of all oxygen atoms to 1.4 and all hydrogen atoms to
1.16. More fine grained control may be achieved using specific atom
names. For example, the following parameter file
```
O    1.40
H    1.16
HW  1.06
```
will set a different radii of 1.06 to hydrogen atoms named HW. Note
that, as per general rule in NWChem, all names are case insensitive.

and placed in one of the these locations - directory specified by the
environmental variable NWCHEM\_COSMO\_LIBRARY, permanent directory, or
run directory.

## References

<references/>

1.  Klamt, A; Schuurmann, G (1993). "COSMO: A new approach to dielectric screening in solvents with explicit expressions for the screening energy and its gradient". Journal of the Chemical Society, Perkin Transactions 2: 799-805. doi:10.1039/P29930000799. 
2. York, D.M.; Karplus, M. (1999). "A smooth solvation potential based on the conductor-like screening model". Journal of physical chemistry A 103: 11060-11079. doi:10.1021/jp992097l. 
3. A. Bondi (1964). "van der Waals volums and radii". Journal of Physical Chemistry 68: 441-451. doi:10.1021/j100785a001. 
4. A. Klamt, V. Jonas (1998). "Refinement and parametrization of COSMO-RS". Journal of physical chemistry A 102: 5074-5085. doi:10.1021/jp980017s. 
5. E. V. Stefanovich, T. N. Truong (1995). "Optimized atomic radii for quantum dielectric continuum solvation models". Chemical Physics Letters 244: 65-74. doi:10.1016/0009-2614(95)00898-E. 
6. V. Barone, M. Cossi (1997). "A new definition of cavities for the computation of solvation free energies by the polarizable continuum model". Journal of Chemical Physics 107: 3210-3221. doi:10.1063/1.474671. 
7. E. V. Stefanovich, T. N. Truong (1995). "Optimized atomic radii for quantum dielectric continuum solvation models". Chemical Physics Letters 244: 65-74. doi:10.1016/0009-2614(95)00898-E. 
