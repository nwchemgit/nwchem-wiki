# Properties

## Overview

Properties can be calculated for both the Hartree-Fock and DFT wave
functions. The properties that are available are:

  - Natural bond analysis
  - Dipole, quadrupole, and octupole moment
  - Mulliken population analysis and bond order analysis
  - Electrostatic potential (diamagnetic shielding) at nuclei
  - Electric field and field gradient at nuclei
  - Electric field gradients with relativistic effects
  - Electron and spin density at nuclei
  - NMR shielding (GIAO method)
  - NMR hyperfine coupling (Fermi-Contact and Spin-Dipole expectation
    values)
  - NMR indirect spin-spin coupling
  - Gshift
  - Response to electric and magnetic fields (static and dynamic)
  - Raman

The properties module is started when the task directive TASK <theory>
property is defined in the user input file. The input format has the
form:
```
 PROPERTY 
   [property keyword]  
   [CENTER ((com || coc || origin || arb <real x y z>) default coc)] 
 END
```
Most of the properties can be computed for Hartree-Fock (closed-shell
RHF, open-shell ROHF, and open-shell UHF), and DFT (closed-shell and
open-shell spin unrestricted) wavefunctions. The NMR hyperfine and
indirect spin-spin coupling require a UHF or ODFT wave function.

## Vectors keyword
```
 VECTORS [ (<string input_movecs >)]
```
The VECTORS directive allows the user to specify the input molecular
orbital vectors for the property calculation

## Property keywords

Each property can be requested by defining one of the following
keywords:
```
 NBOFILE  
 DIPOLE  
 QUADRUPOLE  
 OCTUPOLE  
 MULLIKEN  
 ESP  
 EFIELD  
 EFIELDGRAD  
 EFIELDGRADZ4  
 GSHIFT  
 ELECTRONDENSITY  
 HYPERFINE [<integer> number_of_atoms <integer> atom_list]  
 SHIELDING [<integer> number_of_atoms <integer> atom_list]  
 SPINSPIN [<integer> number_of_pairs <integer> pair_list]  
 RESPONSE [<integer> response_order <real> frequency]  
 AIMFILE  
 MOLDENFILE  
 ALL
```
The `ALL` keyword generates all currently available properties.

### NMR and EPR

Both the NMR shielding and spin-spin coupling have additional optional
parameters that can be defined in the input. For the shielding the user
can define the number of atoms for which the shielding tensor should be
calculated, followed by the list of specific atom centers. In the case
of spin-spin coupling the number of atom pairs, followed by the atom
pairs, can be defined (i.e., `spinspin 1 1 2` will calculate the coupling
for one pair, and the coupling will be between atoms 1 and 2).

For both the NMR spin-spin and hyperfine coupling the isotope that has
the highest abundance and has spin, will be chosen for each atom under
consideration.

**Calculating EPR and paramagnetic NMR parameters:** The following
[tutorial](EPR-pNMR.pdf) illustrates how to combine the
hyperfine, gshift and shielding to calculate the EPR and paramagnetic
NMR parameters of an open-shell system. All calculations are compatible 
with the ZORA model potential approach.

For theoretical and computational details, please refer to 
references[^11][^12][^13].

  
The user also has the option to choose the center of expansion for the
dipole, quadrupole, and octupole calculations.
```
   [CENTER ((com || coc || origin || arb <real x y z>) default coc)]
```
com is the center of mass, coc is the center of charge, origin is (0.0,
0.0, 0.0) and arb is any arbitrary point which must be accompanied by
the coordinated to be used. Currently the x, y, and z coordinates must
be given in the same units as UNITS in [GEOMETRY](Geometry).

### Response Calculations

Response calculations can be calculated as
follows:
```
property
 response  1 7.73178E-2   # response order and frequency in Hartree energy units  
 velocity                 # use modified velocity gauge for electric dipole  
 orbeta                   # calculate optical rotation 'beta' directly [^B2]  
 giao                     # GIAO optical rotation [^B1][^B3][^B6], forces orbeta  
 bdtensor                 # calculates B-tilde of Refs. [^B1][^B6] 
 analysis                 # analyze response in terms of MOs [^B6]  
 damping 0.007            # complex response functions with damping, Ref [^B5] 
 convergence 1e-4         # set CPKS convergence criterion (default 1e-4)  
end
```
Response calculations are currently supported only for   
  
  - order 1 (linear response),   
  - single frequency,   
  - electric field,
  - mixed electric-magnetic field perturbations.    

The output consists of the electric polarizability
and optical rotation tensors (alpha, beta for optical rotation) in
atomic units.  
The `response` keyword requires two arguments: response order and frequency in Hartree energy units
(the `aoresponse` keyword can be used with same effect as the `response` keyword).  
If the `velocity` or `giao` keywords are absent, the
dipole-length form will be used for the dipole integrals. This is a bit
faster.   
The isotropic optical rotation is origin independent when using
the velocity gauge (by means of `velocity` keyword) or with GIAOs [B1] (by means of the `giao` keyword).   
With the keyword `bdtensor`, a
fully origin-invariant optical rotation tensor is calculated [B1,B6].  
Note that `velocity` and `orbeta` are incompatible.   
The input line
```
set prop:newaoresp 0
```
outside of the `properties` block forces the use of an
older version of the response code, which has fewer features (in
particular, no working GIAO optical rotation) but which has been tested
more thoroughly. In the default newer version you may encounter
undocumented features (bugs).  
The keyword `analysis` triggers an analysis of the
response tensors in terms of molecular orbitals.  
If the property input block also contains the keyword `pmlocalization`, then the analysis is
performed in terms of Pipek-Mezey localized MOs, otherwise the canonical
set is used (this feature may currently not work, please check the sum
of the analysis carefully). See Ref. [6] for an example. Works with HF
and density functionals for which linear response kernels are
implemented in NWChem.

Please refer to papers[^B1][^B2][^B3][^B4][^B5][^B6] for further details:


### Raman

Raman calculations can be performed by specifying the Raman block. These
calculations are performed in conjunction with polarizability
calculations. Detailed description of input parameters at
[https://pubs.acs.org/doi/10.1021/jp411039m#notes-1](https://pubs.acs.org/doi/10.1021/jp411039m#notes-1)
```
RAMAN 
 [ (NORMAL | | RESONANCE) default NORMAL ]  
 [ (LORENTZIAN | | GAUSSIAN) default LORENTZIAN ]  
 [ LOW <double low default 0.0> ]  
 [ HIGH <double high default highest normal mode> ]  
 [ FIRST <integer first default 7> ]  
 [ LAST < integer last default number of normal modes > ]  
 [ WIDTH <double width default 20.0> ]  
 [ DQ <double dq default 0.01> ]  
END  
task dft raman
```
or
```
task dft raman numerical
```
Sample input block:
```
property
 response 1 8.8559E-2  
 damping 0.007  
end  
raman  
 normal  
 lorentzian  
end
```
#### Raman Keywords

  - `NORMAL` and `RESONANCE`: Type of Raman plot to make.
  - `LORENTZIAN` and `GAUSSIAN`: Generation of smoothed spectra (rather than
    sticks) using either a Lorentzian function or a Gaussian function.
    The default is `LORENTZIAN`.
  - `LOW` and `HIGH`: The default range in which to generate the Raman
    spectrum plot is (0.0, highest wavenumber normal mode) cm-1. The `LOW`
    and `HIGH` keywords modify the frequency range.
  - `FIRST` and `LAST`: The default range of indices of normal modes used in
    the plot is (7, number of normal modes). The `FIRST` and `LAST` keywords
    modify the range of indices.
  - `WIDTH`: Controls the width in the smoothed peaks, using Lorentzians or
    Gaussians, in the plot. The default value for `WIDTH` is 20.0.
  - `DQ`: Size of the steps along the normal modes. The default value for
    `DQ` is 0.01. It is related to the step size dR used in numerical
    evaluation of polarizability derivative

#### Raman Output

Raman spectrum in stick format and smoothed using Lorentzians or
Gaussians stored in a filename with format `[fname].normal`.  
The number of points is 1000 by default. This value can be changed by adding the following [SET](SET) directive to the input file
```
set raman:numpts <integer>
```

#### Raman References

Please refer to papers[^C1][^C2] for further details:


### Polarizability computed with the Sum over Orbitals method
  
As an alternative to the [linear response
method](#response-calculations), the Sum over Orbitals (SOO) method is
available to compute polarizabilities. Results of these method are
much less accurate than linear response calculations, with values off
by a factor of 2-4x. However, the qualitative nature of this results
can be used to compute Raman frequencies when coupled with
[QMD](Gaussian-Basis-AIMD.md#property-calculation-in-a-molecular-dynamics-simulation),
as described in references [^D1][^D2].
  
Sample input computing polarizability both with the SOO method and the linear response method:
```
property
 polfromsos
end

task dft property

property
 response 1 0
end
task dft property
```
  
  
### Nbofile

The keyword `NBOFILE` does not execute the Natural Bond Analysis code, but
simply creates an input file to be used as input to the stand-alone NBO
code. All other properties are calculated upon request.

Following the successful completion of an electronic structure
calculation, a Natural Bond Orbital (NBO) analysis may be carried out by
providing the keyword `NBOFILE` in the `PROPERTY` directive. NWChem will
query the rtdb and construct an ASCII file, *file_prefix*`.gen`, that may
be used as input to the stand alone version of the NBO program, GenNBO.
*file_prefix* is equal to string following the `START` directive. The
input deck may be edited to provide additional options to the NBO
calculation, (see the NBO user's manual for details.)

Users that have their own NBO version can compile and link the code into
the NWChem software. See the INSTALL file in the source for details.

## Gaussian Cube Files

Electrostatic potential (keyword `esp`) and the magnitude of the
electric field (keyword `efield`) on the grid can be generated in the
form of the Gaussian Cube File. This behavior is triggered by the
inclusion of grid keyword as shown
below
```
 grid [pad dx [dy dz]] [rmax x y z] [rmin x y z] [ngrid nx [ny nz]] [output filename]
```
where

  - `pad dx [dy dz]` - specifies amount of padding (in angstroms) in
    x,y, and z dimensions that will be applied in the automatic
    construction of the rectangular grid volume based on the geometry of
    the system. If only one number is provided then the same amount of
    padding will be applied in all dimensions. The default setting is 4
    angstrom padding in all dimensions.


  - `rmin x y z` - specifies the coordinates (in angstroms) of the minimum
    corner of the rectangular grid volume. This will override any
    padding in this direction.

  - `rmax x y z` - specifies the coordinates (in angstroms) of the maximum
    corner of the rectangular grid volume. This will override any
    padding in this direction.


  - `ngrid nx [ny nz]` - specifies number of grid points along each
    dimension. If only one number is provided then the same number of
    grid points are assumed all dimensions. In the absence of this
    directive the number of grid points would be computed such that grid
    spacing will be close to 0.2 angstrom, but not exceeding 50 grid
    points in either dimension.


  - `output filename` - specifies name of the output cube file. The
    default behavior is to use *prefix*`-elp.cube` or *prefix*`-elf.cube`
    file names for electrostatic potential or electric field
    respectively. Here *prefix* denotes the system name as specified in
    start directive. Note that Gaussian cube files will be written in
    the run directory (where the input file resides).

Example input file
```
  echo  
  start nacl  
    
   
  geometry nocenter noautoz noautosym  
   Na                   -0.00000000     0.00000000    -0.70428494  
   Cl                    0.00000000    -0.00000000     1.70428494  
  end  
    
    
  basis  
    * library 6-31g*  
  end  
    
  #electric field would be written out to nacl.elf.cube file  
  #with  
  #ngrid     : 20 20 20  
  #rmax      : 4.000     4.000     5.704  
  #rmin      :-4.000    -4.000    -4.704  
    
  property  
  efield  
  grid pad 4.0 ngrid 20  
  end  
    
  task dft property  
    
  #electrostatic potential would be written to esp-pad.cube file  
  # with the same parameters as above  
    
  property  
  esp  
  grid pad 4.0 ngrid 20 output esp-pad.cube  
  end  
    
  task dft property  
     
  #illustrating explicit specification of minumum box coordinates  
    
  property  
  esp  
  grid pad 4.0 rmax 4.000 4.000 5.704 ngrid 20  
  end  
    
  task dft property
```
## Aimfile

This keyword generates AIM Wavefunction files. The resulting AIM
wavefunction file (.wfn/.wfx) can be post-processed with a variety of
codes, e.g.

  - [XAIM](http://www.quimica.urv.es/XAIM/)
  - [NCIPLOT](https://github.com/aoterodelaroza/nciplot)
  - [Multiwfn](http://sobereva.com/multiwfn/)
  - [Postg](https://github.com/aoterodelaroza/postg)

**WARNING:** Since we have discovered issues in generating .WFN files with this module (e.g. systems with ECPs), the recommended method for generating .WFN file is to first generate a Molden file with the [Moldenfile](Properties.md#moldenfile) option, then convert the Molden file into a WFN file by using the [Molden2AIM](https://github.com/zorkzou/Molden2AIM) program.

## Moldenfile
```
MOLDENFILE
MOLDEN_NORM (JANPA | | NWCHEM || NONE)
```
This keyword generates files using the [Molden
format](https://www.theochem.ru.nl/molden/molden_format.html). The resulting
Molden file (.molden) should compatible with a variety of codes that can
input Molden files, e.g.

  - [Molden](https://www.theochem.ru.nl/molden/)
  - [JANPA](https://janpa.sf.net) (the nwchem2molden step is no longer
    required when using .molden files and the `MOLDEN_NORM JANPA`
    keyword)
  - [orbkit](http://orbkit.github.io/)
  - [Molden2qmc](http://github.com/Konjkov/molden2qmc)
  - [Molden2AIM](https://github.com/zorkzou/Molden2AIM)
  - [Multiwfn](http://sobereva.com/multiwfn/)

the `MOLDEN_NORM` option allows the renormalization of the basis set
coefficients. By default, the coefficient values from input are not
modified. Using the `JANPA` value coefficients are normalized following
[JANPA](https://janpa.sourceforge.net/)'s
convention (where basis coefficients are normalized to unity), while the `NWCHEM` will produce coefficients normalized
according to NWChem's convention. Using `MOLDEN_NORM` equal `NONE` will
leave the input coefficients unmodified.  
It is strongly recommended to use **spherical** [basis set](Basis) when using the NWChem Molden output for JANPA analysis

Example input file for a scf calculation. The resulting Molden file will
be named `h2o.molden`
```
 start heat
    
 geometry; he 0. 0. 0.; end  
 
 basis spherical; * library 6-31g ; end  
  
 task scf  
  
 property 
  vectors heat.movecs  
  moldenfile   
  molden_norm janpa 
 end
 
 task scf property
```
Then, the resulting `h2o.molden` file can be post processed by [Janpa](https://janpa.sourceforge.net/) with the following command
```
java -jar janpa.jar h2o.molden > h2o.janpa.txt
```

## Localization
```
property
   localization (( pm || boys || ibo) default pm)
 END
 ```

Localize molecular orbitals can be obtained with the `localization` keyword.
The following methods are available:
* Pipek-Mezey[^71], `pm` keyword (default)
* Foster-Boys[^72], `boys` keyword
* IAO/IBO[^73][^74], `ibo` keyword

## References 
///Footnotes Go Here///

[^11]:  J. Autschbach, S. Patchkovskii, B. Pritchard, "Calculation of
    Hyperfine Tensors and Paramagnetic NMR Shifts Using the Relativistic
    Zeroth-Order Regular Approximation and Density Functional Theory",
    Journal of Chemical Theory and Computation 7, 2175 (2011). [DOI:10.1021/ct200143w](https://dx.doi.org/10.1021/ct200143w)  
[^12]:  F. Aquino, B. Pritchard, J. Autschbach, "Scalar relativistic
    computations and localized orbital analysis of nuclear hyperfine
    coupling and paramagnetic NMR chemical shifts", J. Chem. Theory
    Comput. 2012, 8, 598–609. [DOI:10.1021/ct2008507](https://dx.doi.org/10.1021/ct2008507)    
[^13]:  F. Aquino, N. Govind, J. Autschbach, "Scalar relativistic
    computations of nuclear magnetic shielding and g-shifts with the
    zeroth-order regular approximation and range-separated hybrid
    density functionals", J. Chem. Theory Comput. 2011, 7, 3278–3292. [DOI:10.1021/ct200408j](https://dx.doi.org/10.1021/ct200408j)
[^B1]: J. Autschbach, ChemPhysChem 12 (2011), 3224-3235. [DOI:10.1002/cphc.201100225](https://dx.doi.org/10.1002/cphc.201100225)  
[^B2]: J. Autschbach, Comput. Lett. 3, (2007), 131. [DOI:10.1163/157404007782913327](https://dx.doi.org/10.1163/157404007782913327)  
[^B3]: M. Krykunov, J. Autschbach, J. Chem. Phys. 123 (2005), 114103. [DOI:10.1063/1.2032428](https://dx.doi.org/10.1063/1.2032428)  
[^B4]: J.R. Hammond, N. Govind, K. Kowalski, J. Autschbach, S.S. Xantheas,
    J. Chem. Phys. 131 (2009), 214103. [DOI:10.1063/1.3263604](https://dx.doi.org/10.1063/1.3263604)  
[^B5]: M. Krykunov, M. D. Kundrat, J. Autschbach, J. Chem. Phys. 125
    (2006), 194110. [DOI:10.1063/1.2363372](https://dx.doi.org/10.1063/1.2363372)  
[^B6]: B. Moore II, M. Srebro, J. Autschbach, J. Chem. Theory Comput. 8
    (2012), 4336-4346. [DOI:10.1021/ct300839y](https://dx.doi.org/10.1021/ct300839y)  
[^C1]: J. M. Mullin, J. Autschbach, G. C. Schatz, Computational and
    Theoretical Chemistry 987, 32 (2012). [DOI:10.1016/j.comptc.2011.08.027](https://dx.doi.org/10.1016/j.comptc.2011.08.027)  
[^C2]: Aquino, F. W.; Schatz, G. C. (2014). The Journal of Physical Chemistry A  118 , 517. [DOI:10.1021/jp411039m](https://dx.doi.org/10.1021/jp411039m)  
[^D1]: Fischer, S. A. ; Ueltschi, T. W.; El-Khoury, P. Z.; Mifflin, A. L.; Hess, W. P.; Wang,  H.-F.; Cramer, C. J.; Govind, N. (2016). The Journal of Physical Chemistry B 120 (8), 1429-1436. [DOI: 10.1021/acs.jpcb.5b03323](https://dx.doi.org/10.1021/acs.jpcb.5b03323)  
[^D2]:  E. Aprà, A. Bhattarai, E. Baxter, S. Wang, G. E. Johnson, N. Govind, and P. Z. El-Khoury, Applied Spectroscopy 174 (11), 1350-1357 (2020). [DOI:10.1177/0003702820923392](https://dx.doi.org/10.1177/0003702820923392)  
[^71]: Pipek, J; Mezey, P. G. (1989). "A fast intrinsic localization procedure applicable for ab initio and semiempirical linear combination of atomic orbital wave functions". The Journal of Chemical Physics. 90, 4916. [DOI:10.1063/1.456588](https://dx.doi.org/10.1063/1.456588)
[^72]: Boys, S. F. (1960). "Construction of Molecular orbitals to be minimally variant for changes from one molecule to another". Reviews of Modern Physics. 32, 296–299. [DOI:10.1103/RevModPhys.32.300](https://dx.doi.org/10.1103/RevModPhys.32.300)
[^73]: Knizia, G. (2013). "Intrinsic atomic orbitals: An unbiased bridge between quantum theory and chemical concepts". J. Chem. Theory Comput. 9, 4834 [DOI:10.1021/ct400687b](https://dx.doi.org/10.1021/ct400687b)
[^74]: Knizia, G; Klein, J. E. M. N. (2015). "Electron Flow in Reaction Mechanisms-Revealed from First Principles". Angew. Chem. Int. Ed., 54, 5518 [DOI:10.1002/anie.201410637](https://dx.doi.org/10.1002/anie.201410637)
