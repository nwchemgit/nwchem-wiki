# Solvation Models

## Overview

Two solvation models are available in NWChem: [COSMO](#cosmo) and [SMD](#smd).
Since some of the COSMO parameters are used for SMD, we suggest to read the COSMO section before the SMD one.

## COSMO

### Overview

COSMO is the continuum solvation 'COnductor-like Screening MOdel' of A.
Klamt and G. Schüürmann to describe dielectric screening effects in
solvents[@klamt1993]. This model has been enhanced by D.M. York and M.
Karplus[@york1999] to create a smooth potential energy surface. The latter
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
finite difference of the gradients.     
The non-electrostatic
contributions can be calculated by turning on the [SMD model](#smd). It should
be noted that one must in general take into account the standard state
correction besides the electrostatic and cavitation/dispersion
contribution to the solvation free energy, when a comparison to
experimental data is made.

### COSMO Input Parameters  

Invoking the COSMO solvation model is done by specifying the input COSMO
input block with the input options as:
```
cosmo  
  [off]  
  [dielec  <real dielec default 78.4>]  
  [parameters <filename>]  
  [radius  <real atom1>  
           <real atom2>  
      . . .  
           <real atomN>]  
  [iscren  <integer iscren default 0>]  
  [minbem  <integer minbem default 2>]  
  [ificos  <integer ificos default 0>]  
  [lineq   <integer lineq default 1>]  
  [zeta <real zeta default 0.98>]  
  [gamma_s <real gammas default 1.0>]  
  [sw_tol <real swtol default 1.0e-4>]  
  [do_gasphase  <logical do_gasphase default True>] 
  [do_cosmo_ks]
  [do_cosmo_yk]
  [do_cosmo_smd]
end
```
followed by the task directive specifying the wavefunction and type of
calculation, e.g., `task scf energy`, `task mp2 energy`, `task dft
optimize`, etc.

`off` can be used to turn off COSMO in a compound (multiple task) run.
By default, once the COSMO solvation model has been defined it will be
used in subsequent calculations. Add the keyword `off` if COSMO is not
needed in subsequent calculations.

`dielec` is the value of the dielectric constant of the medium, with a
default value of 78.4 (the dielectric constant for water).

`parameters` specifies COSMO radii parameters file that stores custom
setting for COSMO parameters. The format for such file consists of the
atom or element name followed by the radii. The program will first
attempt to match based on atom name and only then the element name.
Otherwise radius will be set based on default parameters. The file has
to present in one of the three location ( in the order of preference) -
directory specified by the environmental variable
`NWCHEM_COSMO_LIBRARY`, permanent directory, and run directory. 
  
`radius` is an array that specifies the radius of the spheres associated
with each atom and that make up the molecule-shaped cavity. These values
will override default radii setting including those specified in the
COSMO parameter file (if any) Default values are Van der Waals radii.
Values are in units of angstroms. The codes uses the following Van der
Waals radii by default:

Default radii provided by Andreas Klamt (Cosmologic)

vdw radii: 1.17 (± 0.02) * Bondi radius[@bondi1964]

optimal vdw radii for H, C, N, O, F, S, Cl, Br, I[@klamt1998]

for heavy elements: 1.17\*1.9
```
     data (vander(i),i=1,102)  
    1 / 1.300,1.638,1.404,1.053,2.0475,2.00,  
    2   1.830,1.720,1.720,1.8018,1.755,1.638,  
    3   1.404,2.457,2.106,2.160,2.05,2.223,  
    4   2.223,2.223,2.223,2.223,2.223,2.223,  
    5   2.223,2.223,2.223,2.223,2.223,2.223,  
    6   2.223,2.223,2.223,2.223,2.160,2.223,  
    7   2.223,2.223,2.223,2.223,2.223,2.223,  
    8   2.223,2.223,2.223,2.223,2.223,2.223,  
    9   2.223,2.223,2.223,2.223,2.320,2.223,  
    1   2.223,2.223,2.223,2.223,2.223,2.223,  
    2   2.223,2.223,2.223,2.223,2.223,2.223,  
    3   2.223,2.223,2.223,2.223,2.223,2.223,  
    4   2.223,2.223,2.223,2.223,2.223,2.223,  
    5   2.223,2.223,2.223,2.223,2.223,2.223,  
    6   2.223,2.223,2.223,2.223,2.223,2.223,  
    7   2.223,2.223,2.223,2.223,2.223,2.223,  
    7   2.223,2.223,2.223,2.223,2.223,2.223/
```
For examples see Stefanovich et al.[@stefanovich1995] and Barone et al.[@barone1997]

"Rsolv" is no longer used.

`iscren` is a flag to define the dielectric charge scaling option.
`iscren 1` implies the original scaling from Klamt and Schüürmann,
mainly "(&epsilon;-1)/(&epsilon;+1/2)", where &epsilon; is the
dielectric constant. `iscren 0` implies the modified scaling suggested
by Stefanovich and Truong[@stefanovich1995], mainly "(&epsilon;-1)/&epsilon;".
Default is to use the modified scaling. For high dielectric the
difference between the scaling is not significant.

The next two parameters define the tesselation of the unit sphere. The
approach still follows the original proposal by Klamt and Schüürmann to
some degree. Basically a tesselation is generated from `minbem` refining
passes starting from either an octahedron or an icosahedron. Each level
of refinement partitions the triangles of the current tesselation into
four triangles. This procedure is repeated recursively until the desired
granularity of the tesselation is reached. The induced point charges
from the polarization of the medium are assigned to the centers of the
tesselation. The default value is `minbem 2`. The flag `ificos` serves
to select the original tesselation, `ificos 0` for an octahedron
(default) and `ificos 1` for an icoshedron. Starting from an icosahedron
yields a somewhat finer tesselation that converges somewhat faster.
Solvation energies are not really sensitive to this choice for
sufficiently fine tesselations. The old "maxbem" directive is no longer
used.

The `lineq` parameter serves to select the numerical algorithm to solve
the linear equations yielding the effective charges that represent the
polarization of the medium. `lineq 0` selects a dense matrix linear equation solver
(default), `lineq 1` selects an iterative method. For
large molecules where the number of effective charges is large, the
code selects the iterative method.

`zeta` sets the width of the Gaussian charge distributions that were
suggested by York and Karplus to avoid singularities when two surface
charges coincide. The default value is `zeta 0.98` this value was chosen
to ensure that the results of the current implementation are as close as
possible to those of the original Klamt and Schüürmann based
implementation.

`gamma_s` modifies the width of the smooth switching function that
eliminates surface charges when their positions move into the sphere of
a neighboring atom. `gamma_s 0.0` leads to a heavyside or abrupt
switching function, whereas `gamma_s 1.0` maximizes the width of the
switching function. The default value is `gamma_s 1.0`.

`sw_tol` specifies the cutoff of the switching function below which a
surface charge at a particular point is eliminated. The values of the
switching function lie in the domain from 0 to 1. This value should not
be set too small as that leads to instabilities in the linear system
solvers. The default value is `sw_tol 1.0e-4`.

`do_gasphase` is a flag to control whether the calculation of the
solvation energy is preceded by a gas phase calculation. The default is
to always perform a gas phase calculation first and then calculate the
solvation starting from the converged gas phase electron density.
However, in geometry optimizations this approach can double the cost. In
such a case setting `do_gasphase false` suppresses the gas phase
calculations and only the solvated system calculations are performed.
This option needs to be used with care as in some cases starting the
COSMO solvation from an unconverged electron density can generate
unphysical charges that lock the calculation into strange electron
distributions.

`do_cosmo_ks` is a flag to turn on the Klamt-Schüürmann model  

`do_cosmo_yk` is a flag to turn on the York-Karplus model (default)  

`do_cosmo_smd` is a flag to turn on the SMD model. More details can be found
at the [SMD Model documentation](#smd)  

The following example is for a water molecule in 'water', using the
HF/6-31G** level of
theory:
```
start  
 
geometry  
 o                  .0000000000         .0000000000        -.0486020332  
 h                  .7545655371         .0000000000         .5243010666  
 h                 -.7545655371         .0000000000         .5243010666  
end  
basis
 o library 6-31g**  
 h library 6-31g**  
end  
cosmo  
 dielec 78.0  
 radius 1.40  
        1.16  
        1.16  
 lineq  0  
end  
task scf energy
```
Alternatively, instead of listing COSMO radii parameters in the input,
the former can be loaded using an external file through the `parameters`
directive
```
start  

geometry  
 ow                  .0000000000         .0000000000        -.0486020332  
 hw                  .7545655371         .0000000000         .5243010666  
 h                  -.7545655371         .0000000000         .5243010666  
end  
basis
 * library 6-31g**  
end

cosmo  
 dielec 78.0  
 lineq  0  
 parameters water.par  
end

task scf energy
```
where the `water.par` file has the following form:
```
O 1.40
H 1.16
```
This will set radii of all oxygen atoms to 1.4 and all hydrogen atoms to
1.16. More fine grained control may be achieved using specific atom
names. For example, the following parameter file
```
O    1.40
H    1.16
HW  1.06
```
will set a different radii of 1.06 to hydrogen atoms named HW. Note
that, as per general rule in NWChem, all names are case insensitive.

and placed in one of the these locations - directory specified by the
environmental variable `NWCHEM_COSMO_LIBRARY`, permanent directory, or
run directory.  


## SMD

### Overview

SMD denotes “solvation model based on density” and it is described in
detail in the 2009 paper by Marenich, Cramer and Truhlar[@marenich2009].  

The SMD model is a universal continuum solvation model where “universal”
denotes its applicability to any charged or uncharged solute in any
solvent or liquid medium for which a few key descriptors are known. The
word “continuum” denotes that the solvent is not represented explicitly
as a collection of discrete solvent molecules but rather as a dielectric
medium with surface tensions at the solute-solvent interface.

SMD directly calculates the free energy of solvation of an ideal
solvation process that occurs at fixed concentration (for example, from
an ideal gas at a concentration of 1 mol/L to an ideal solution at a
liquid-phase concentration of 1 mol/L) at 298 K, but this may converted
by standard thermodynamic formulas to a standard-state free energy of
solvation, which is defined as the transfer of molecules from an ideal
gas at 1 bar to an ideal 1 molar solution.

The SMD model separates the fixed-concentration free energy of solvation
into two components. The first component is the bulk-electrostatic
contribution arising from a self-consistent reaction field (SCRF)
treatment. The SCRF treatment involves an integration of the
nonhomogeneous-dielectric Poisson equation for bulk electrostatics in
terms of the [COSMO model](#cosmo)
of Klamt and Schüürmann with the modified [COSMO scaling factor](#cosmo-input-parameters) 
suggested by Stefanovich and Truong and by using the SMD
intrinsic atomic Coulomb radii. These radii have been optimized for H,
C, N, O, F, Si, P, S, Cl, and Br. For any other atom the current
implementation of the SMD model uses scaled values of the van der Waals
radii of Mantina et al[@mantina2013].

The scaling factor equals 1.52 for group 17 elements heavier than Br
(i.e., for I and At) and 1.18 for all other elements for which there are
no optimized SMD radii.

The second contribution to the fixed-concentration free energy of
solvation is the contribution arising from short-range interactions
between the solute and solvent molecules in the first solvation shell.
This contribution is called the cavity–dispersion–solvent-structure
(CDS) term, and it is a sum of terms that are proportional (with
geometry-dependent proportionality constants called atomic surface
tensions) to the solvent-accessible surface areas (SASAs) of the
individual atoms of the solute.

### SMD Input Parameters

The SMD model requires additional parameters in the [COSMO input block](#cosmo-input-parameters)

```
cosmo  
  [do_cosmo_smd <logical>]
  [solvent (keyword)]
  [icds <integer>]
  [sola <real>]
  [solb <real>]
  [solc <real>]
  [solg <real>]
  [solh <real>]
  [soln <real>]
end  
```
At the moment the SMD model is available in NWChem only with the DFT
block

The SMD input options are as follows:

```
do_cosmo_smd <logical>
```
The `do_cosmo_smd` keyword instructs NWChem to perform a ground-state SMD calculation
when set to a `true` value.

```
solvent (keyword)
```
a `solvent` keyword from the short name entry in the
[list of available SMD solvent names](#solvents-list-solvent-keyword).

When a solvent is specified by name, the descriptors for the solvent are
based on the Minnesota Solvent Descriptor Database[@winget1999].  

The user can specify a solvent that is not on the list by omitting the
solvent keyword and instead introducing user-provided values for the
following solvent
descriptors:

```
dielec (real input)
```
dielectric constant at 298 K  

```
sola (real input) 
```
Abraham’s hydrogen bond acidity   

```
solb (real input) 
```
Abraham’s hydrogen bond basicity  

```
solc (real input)
```
aromaticity as a fraction of non-hydrogenic solvent atoms that are aromatic carbon atoms  

```
solg (real input)
```
macroscopic surface tension of the solvent at an air/solvent interface at 298 K in units of
cal mol<sup>–1</sup> Å<sup>–2</sup>  
(note that 1 dyne/cm = 1.43932 cal mol<sup>–1</sup> Å<sup>–2</sup>)  
  
```
solh (real input)
```
electronegative halogenicity as the fraction of non-hydrogenic solvent atoms that are F, Cl, or Br  
  
```
soln (real input)
```
index of refraction at optical frequencies at 293 K

```
icds (integer input)
```
`icds` should have a value of 1 for water.
`icds` should have a value of 2  for any nonaqueous solvent.  
If icds=2 you need to provide the following solvent descriptors
(see the [MN solvent descriptor database](https://comp.chem.umn.edu/solvation/mnsddb.pdf) ):

* `sola` 
* `solb` 
* `solc` 
* `solg` 
* `solh` 
* `soln` 

### SMD Examples

An example of an SMD input file is as
follows:

```
echo 
title 'SMD/M06-2X/6-31G(d) solvation free energy for CF3COO- in water'
start
charge -1
geometry nocenter
C    0.512211   0.000000  -0.012117
C   -1.061796   0.000000  -0.036672
O   -1.547400   1.150225  -0.006609
O   -1.547182  -1.150320  -0.006608
F    1.061911   1.087605  -0.610341
F    1.061963  -1.086426  -0.612313
F    0.993255  -0.001122   1.266928
symmetry c1
end
basis
* library 6-31G*
end
dft
 XC m06-2x
end
cosmo
 do_cosmo_smd true
 solvent water
end
task dft energy
```
## Solvents List - Solvent keyword

The short name for the solvent from the table can be used  with the `solvent` keyword to define the solvent.  
Example with acetonitrile.
```
cosmo
  solvent acetntrl
end
```

| Long name                       | short name| dielec |
|---------------------------------|----------|-------:|
| acetic acid                     | acetacid |  6.2528|
| acetone                         | acetone  |  20.493|
| acetonitrile                    | acetntrl |  35.688|
| acetophenone                    | acetphen |  17.440|
| aniline                         | aniline  |  6.8882|
| anisole                         | anisole  |  4.2247|
| benzaldehyde                    | benzaldh |  18.220|
| benzene                         | benzene  |  2.2706|
| benzonitrile                    | benzntrl |  25.592|
| benzyl chloride                 | benzylcl |  6.7175|
| 1-bromo-2-methylpropane         | brisobut |  7.7792|
| bromobenzene                    | brbenzen |  5.3954|
| bromoethane                     | brethane |  9.01  |
| bromoform                       | bromform |  4.2488|
| 1-bromooctane                   | broctane |  5.0244|
| 1-bromopentane                  | brpentan |  6.269 |
| 2-bromopropane                  | brpropa2 |  9.3610|
| 1-bromopropane                  | brpropan |  8.0496|
| butanal                         | butanal  |  13.450|
| butanoic acid                   | butacid  |  2.9931|
| 1-butanol                       | butanol  |  17.332|
| 2-butanol                       | butanol2 |  15.944|
| butanone                        | butanone |  18.246|
| butanonitrile                   | butantrl |  24.291|
| butyl acetate                   | butile   |  4.9941|
| butylamine                      | nba      |  4.6178|
| n-butylbenzene                  | nbutbenz |  2.360 |
| sec-butylbenzene                | sbutbenz |  2.3446|
| tert-butylbenzene               | tbutbenz |  2.3447|
| carbon disulfide                | cs2      |  2.6105|
| carbon tetrachloride            | carbntet |  2.2280|
| chlorobenzene                   | clbenzen |  5.6968|
| sec-butyl chloride              | secbutcl |  8.3930|
| chloroform                      | chcl3    |  4.7113|
| 1-chlorohexane                  | clhexane |  5.9491|
| 1-chloropentane                 | clpentan |  6.5022|
| 1-chloropropane                 | clpropan |  8.3548|
| o-chlorotoluene                 | ocltolue |  4.6331|
| m-cresol                        | m-cresol |  12.440|
| o-cresol                        | o-cresol |  6.760 |
| cyclohexane                     | cychexan |  2.0165|
| cyclohexanone                   | cychexon |  15.619|
| cyclopentane                    | cycpentn |  1.9608|
| cyclopentanol                   | cycpntol |  16.989|
| cyclopentanone                  | cycpnton |  13.58 |
| cis-decalin                     | declncis |  2.2139|
| trans-decalin                   | declntra |  2.1781|
| decalin (cis/trans mixture)     | declnmix |  2.196 |
| n-decane                        | decane   |  1.9846|
| 1-decanol                       | decanol  |  7.5305|
| 1,2-dibromoethane               | edb12    |  4.9313|
| dibromomethane                  | dibrmetn |  7.2273|
| dibutyl ether                   | butyleth |  3.0473|
| o-dichlorobenzene               | odiclbnz |  9.9949|
| 1,2-dichloroethane              | edc12    |  10.125|
| cis-dichloroethylene            | c12dce   |  9.200 |
| trans-dichloroethylene          | t12dce   |  2.140 |
| dichloromethane                 | dcm      |  8.930 |
| diethyl ether                   | ether    |  4.2400|
| diethyl sulfide                 | et2s     |  5.723 |
| diethylamine                    | dietamin |  3.5766|
| diiodomethane                   | mi       |  5.320 |
| diisopropyl ether               | dipe     |  3.380 |
| dimethyl disulfide              | dmds     |  9.600 |
| dimethylsulfoxide               | dmso     |  46.826|
| N,N-dimethylacetamide           | dma      |  37.781|
| cis-1,2-dimethylcyclohexane     | cisdmchx |  2.060 |
| N,N-dimethylformamide           | dmf      |  37.219|
| 2,4-dimethylpentane             | dmepen24 |  1.8939|
| 2,4-dimethylpyridine            | dmepyr24 |  9.4176|
| 2,6-dimethylpyridine            | dmepyr26 |  7.1735|
| 1,4-dioxane                     | dioxane  |  2.2099|
| diphenyl ether                  | phoph    |  3.730 |
| dipropylamine                   | dproamin |  2.9112|
| n-dodecane                      | dodecan  |  2.0060|
| 1,2-ethanediol                  | meg      |  40.245|
| ethanethiol                     | etsh     |  6.667 |
| ethanol                         | ethanol  |  24.852|
| ethyl acetate                   | etoac    |  5.9867|
| ethyl formate                   | etome    |  8.3310|
| ethylbenzene                    | eb       |  2.4339|
| ethylphenyl ether               | phenetol |  4.1797|
| fluorobenzene                   | c6h5f    |  5.420 |
| 1-fluorooctane                  | foctane  |  3.890 |
| formamide                       | formamid |  108.94|
| formic acid                     | formacid |  51.100|
| n-heptane                       | heptane  |  1.9113|
| 1-heptanol                      | heptanol |  11.321|
| 2-heptanone                     | heptnon2 |  11.658|
| 4-heptanone                     | heptnon4 |  12.257|
| n-hexadecane                    | hexadecn |  2.0402|
| n-hexane                        | hexane   |  1.8819|
| hexanoic acid                   | hexnacid |  2.600 |
| 1-hexanol                       | hexanol  |  12.51 |
| 2-hexanone                      | hexanon2 |  14.136|
| 1-hexene                        | hexene   |  2.0717|
| 1-hexyne                        | hexyne   |  2.615 |
| iodobenzene                     | c6h5i    |  4.5470|
| 1-iodobutane                    | iobutane |  6.173 |
| iodoethane                      | c2h5i    |  7.6177|
| 1-iodohexadecane                | iohexdec |  3.5338|
| iodomethane                     | ch3i     |  6.8650|
| 1-iodopentane                   | iopentan |  5.6973|
| 1-iodopropane                   | iopropan |  6.9626|
| isopropylbenzene                | cumene   |  2.3712|
| p-isopropyltoluene              | p-cymene |  2.2322|
| mesitylene                      | mesityln |  2.2650|
| methanol                        | methanol |  32.613|
| 2-methoxyethanol                | egme     |  17.200|
| methyl acetate                  | meacetat |  6.8615|
| methyl benzoate                 | mebnzate |  6.7367|
| methyl butanoate                | mebutate |  5.5607|
| methyl formate                  | meformat |  8.8377|
| 4-methyl-2-pentanone            | mibk     |  12.887|
| methyl propanoate               | mepropyl |  6.0777|
| 2-methyl-1-propanol             | isobutol |  16.777|
| 2-methyl-2-propanol             | terbutol |  12.470|
| N-methylaniline                 | nmeaniln |  5.9600|
| methylcyclohexane               | mecychex |  2.024 |
| N-methylformamide (E/Z mixture) | nmfmixtr |  181.56|
| 2-methylpentane                 | isohexan |  1.890 |
| 2-methylpyridine                | mepyrid2 |  9.9533|
| 3-methylpyridine                | mepyrid3 |  11.645|
| 4-methylpyridine                | mepyrid4 |  11.957|
| nitrobenzene                    | c6h5no2  |  34.809|
| nitroethane                     | c2h5no2  |  28.290|
| nitromethane                    | ch3no2   |  36.562|
| 1-nitropropane                  | ntrprop1 |  23.730|
| 2-nitropropane                  | ntrprop2 |  25.654|
| o-nitrotoluene                  | ontrtolu |  25.669|
| n-nonane                        | nonane   |  1.9605|
| 1-nonanol                       | nonanol  |  8.5991|
| 5-nonanone                      | nonanone |  10.600|
| n-octane                        | octane   |  1.9406|
| 1-octanol                       | octanol  |  9.8629|
| 2-octanone                      | octanon2 |  9.4678|
| n-pentadecane                   | pentdecn |  2.0333|
| pentanal                        | pentanal |  10.000|
| n-pentane                       | npentane |  1.8371|
| pentanoic acid                  | pentacid |  2.6924|
| 1-pentanol                      | pentanol |  15.130|
| 2-pentanone                     | pentnon2 |  15.200|
| 3-pentanone                     | pentnon3 |  16.780|
| 1-pentene                       | pentene  |  1.9905|
| E-2-pentene                     | e2penten |  2.051 |
| pentyl acetate                  | pentacet |  4.7297|
| pentylamine                     | pentamin |  4.2010|
| perfluorobenzene                | pfb      |  2.029 |
| phenylmethanol                  | benzalcl |  12.457|
| propanal                        | propanal |  18.500|
| propanoic acid                  | propacid |  3.440 |
| 1-propanol                      | propanol |  20.524|
| 2-propanol                      | propnol2 |  19.264|
| propanonitrile                  | propntrl |  29.324|
| 2-propen-1-ol                   | propenol |  19.011|
| propyl acetate                  | propacet |  5.5205|
| propylamine                     | propamin |  4.9912|
| pyridine                        | pyridine |  12.978|
| tetrachloroethene               | c2cl4    |  2.268 |
| tetrahydrofuran                 | thf      |  7.4257|
| tetrahydrothiophene-S,S-dioxide | sulfolan |  43.962|
| tetralin                        | tetralin |  2.771 |
| thiophene                       | thiophen |  2.7270|
| thiophenol                      | phsh     |  4.2728|
| toluene                         | toluene  |  2.3741|
| tributyl phosphate              | tbp      |  8.1781|
| 1,1,1-trichloroethane           | tca111   |  7.0826|
| 1,1,2-trichloroethane           | tca112   |  7.1937|
| trichloroethene                 | tce      |  3.422 |
| triethylamine                   | et3n     |  2.3832|
| 2,2,2-trifluoroethanol          | tfe222   |  26.726|
| 1,2,4-trimethylbenzene          | tmben124 |  2.3653|
| 2,2,4-trimethylpentane          | isoctane |  1.9358|
| n-undecane                      | undecane |  1.9910|
| m-xylene                        | m-xylene |  2.3478|
| o-xylene                        | o-xylene |  2.5454|
| p-xylene                        | p-xylene |  2.2705|
| xylene (mixture)                | xylenemx |  2.3879|
| water                           | h2o      |  78.400|

## Usage Tips

Authors of paper [@marenich2009] report that  
" ... *the SMD/COSMO/NWChem calculations we employed finer grids (options minbem=3, maxbem=4, ificos=1) because the default NWChem tessellation parameters (options: minbem=2, maxbem=3, ificos=0) produced very large errors in solvation free energies*."  
Since the `maxbem` keyword is no longer in use, this paper's recommended input translate into
```
cosmo
 minbem 3
 ificos 1
end
```

## References
///Footnotes Go Here///


