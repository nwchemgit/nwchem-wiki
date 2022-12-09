# DPLOT

## Overview

```
 DPLOT  
   ...  
 END
```
This directive is used to obtain the plots of various types of electron
densities (or orbitals) of the molecule. The electron density is
calculated on a specified set of grid points using the molecular
orbitals from SCF or DFT calculation. The output file is either in MSI
Insight II contour format (default) or in the [Gaussian Cube format](http://paulbourke.net/dataformats/cube/).
DPLOT is not executed until the `task dplot` directive is given.
Different sub-directives are described below.

The implementation of the dplot functionality uses mostly local memory.
The quantities stored in local memory are:

  - the positions of the grid points
  - the property of interest expressed at the grid points

The stack memory setting in the input file must be sufficient to hold
these quantities in local memory on a processor.

## GAUSSIAN: Gaussian Cube format
```
 GAUSSIAN
```
A outputfile is generate in Gaussian Cube format. You can visualize this
file using gOpenMol (after converting the Gaussian Cube file with
gcube2plt), Molden or Molekel.

## TITLE: Title directive
```
 TITLE <string Title default Unknown Title>
```
This sub-directive specifies a title line for the generated input to the
Insight program or for the Gaussian cube file. Only one line is allowed.

## LIMITXYZ: Plot limits
```
 LIMITXYZ [units <string Units default angstroms>]  
  <real X_From> <real X_To> <integer No_Of_Spacings_X>  
   <real Y_From> <real Y_To> <integer No_Of_Spacings_Y>  
   <real Z_From> <real Z_To> <integer No_Of_Spacings_Z>
```
This sub-directive specifies the limits of the cell to be plotted. The
grid is generated using No_Of_Spacings + 1 points along each
direction. The known names for Units are angstroms, au and bohr.

## SPIN: Density to be plotted
```
 SPIN <string Spin default total>
```
This sub-directive specifies what kind of density is to be computed.
The known names for Spin are `total`, `alpha`, `beta` and `spindens`, the last
being computed as the difference between α and β electron densities.

## OUTPUT: Filename
```
 OUTPUT <string File_Name default dplot>
```
This sub-directive specifies the name of the generated input to the
Insight program or the generated Gaussian cube file. The name `OUTPUT` is
reserved for the standard NWChem output.

## VECTORS: MO vector file name
```
 VECTORS <string File_Name default movecs> [<string File_Name2>]
```
This sub-directive specifies the name of the molecular orbital file. If
the second file is optionally given the density is computed as the
difference between the corresponding electron densities. The vector
files have to match.

## WHERE: Density evaluation
```
 WHERE <string Where default grid>
```
This sub-directive specifies where the density is to be computed. The
known names for `where` are `grid` (the calculation of the density is
performed on the set of a grid points specified by the sub-directive
`LimitXYZ` and the file specified by the sub-directive Output is
generated), `nuclei` (the density is computed at the position of the
nuclei and written to the NWChem output) and `g+n` (both).

## ORBITAL: Orbital sub-space
```
 ORBITALS [<string Option default density>]
 <integer No_Of_Orbitals>  
 <integer Orb_No_1 Orb_No_2 ...>
```
This sub-directive specifies the subset of the orbital space for the
calculation of the electron density. The density is computed using the
occupation numbers from the orbital file modified according to the `spin`
directive. If the contours of the orbitals are to be plotted Option
should be set to `view` (instead of the implicit default value
`density`). Note, that in this case No_Of_Orbitals should be set to 1
and sub-directive `where` is automatically set to `grid`. Also specification
of two orbital files conflicts with the view option. alpha orbitals are
always plotted unless `spin` is set to `beta`.

## CIVECS: CI vectors
```
CIVECS [<string Name of civecs file>]
```
## DENSMAT: Density matrix
```
DENSMAT [<string Name of density matrix file>]
```
## Examples

### Charge Density

### Example of HF charge density plot (with Gaussian Cube output)
```
start n2  
geometry  
  n  0 0   0.53879155 
  n  0 0  -0.53879155  
end  
basis;  n library cc-pvdz;end 
scf  
vectors  output n2.movecs  
end  
dplot  
  TITLE HOMO  
  vectors n2.movecs  
   LimitXYZ  
 -3.0 3.0 10    
 -3.0 3.0 10   
 -3.0  3.0  10  
  spin total 
  gaussian  
  output chargedensity.cube  
end  
task scf       
task dplot
```

### Example of CCSD charge density plot (with Gaussian Cube output)
```
start n2
geometry
 n 0 0  0.53879155
 n 0 0 -0.53879155
 symmetry c2v
end
basis; n library cc-pvdz;end
tce
 ccsd
 densmat n2.densmat
end
task tce energy
dplot
 TITLE HOMO
 LimitXYZ
 -3.0 3.0 10
 -3.0 3.0 10
 -3.0 3.0 10
 spin total
 gaussian
 densmat n2.densmat
 output ccsddensity.cube
end
task dplot
```
### Molecular Orbital

Example of orbital plot (with Insight II contour output):
```
start n2  
geometry 
  n  0 0   0.53879155  
  n  0 0  -0.53879155  
end  
basis;  n library cc-pvdz;end 
scf 
vectors  output n2.movecs  
end  
dplot  
  TITLE HOMO  
  vectors n2.movecs  
   LimitXYZ  
 -3.0 3.0 10    
 -3.0 3.0 10   
 -3.0  3.0  10  
  spin total  
  orbitals view; 1; 7  
  output homo.grd  
end  
task scf       
task dplot
```
### Transition Density

TDDFT calculation followed by a calculation of the transition density
for a specific excited state using the DPLOT block
```
echo  
start h2o-td  
title h2o-td  
memory stack 400 mb heap 50 mb global 350 mb  
charge 0  
geometry units au noautoz nocenter  
symmetry group c1  
 O    0.00000000000000      0.00000000000000      0.00000000000000  
 H    0.47043554760291      1.35028113274600      1.06035416576826  
 H   -1.74335410533480     -0.23369304784300      0.27360785442967  
end  
basis "ao basis" print  
 H    S  
    13.0107010              0.19682158E-01  
     1.9622572              0.13796524  
     0.44453796             0.47831935  
 H    S  
     0.12194962             1.0000000  
 H    P  
     0.8000000              1.0000000  
 O    S  
  2266.1767785             -0.53431809926E-02  
   340.87010191            -0.39890039230E-01  
    77.363135167           -0.17853911985  
    21.479644940           -0.46427684959  
     6.6589433124          -0.44309745172  
 O    S  
     0.80975975668          1.0000000  
 O    S  
     0.25530772234          1.0000000  
 O    P  
    17.721504317            0.43394573193E-01  
     3.8635505440           0.23094120765  
     1.0480920883           0.51375311064  
 O    P  
     0.27641544411          1.0000000  
 O    D  
     1.2000000              1.0000000  
end  
dft  
 xc bhlyp  
 grid fine  
 direct  
 convergence energy 1d-5  
end  
tddft  
 rpa  
 nroots 5  
 thresh 1d-5  
 singlet  
 notriplet  
 civecs  
end  
task tddft energy  
dplot  
 civecs h2o-td.civecs_singlet  
 root 2  
 LimitXYZ  
  -3.74335 2.47044 50  
  -2.23369 3.35028 50  
  -2 3.06035 50  
   gaussian  
   output root-2.cube  
end  
task dplot
```
### Plot the excited state density
```
echo  
start tddftgrad_co_exden  
geometry  
 C     0.00000000     0.00000000    -0.64628342  
 O     0.00000000     0.00000000     0.48264375  
 symmetry c1  
end  
basis spherical  
 * library "3-21G"  
end  
dft  
 xc pbe0  
 direct  
end  
tddft  
 nroots 3  
 notriplet  
 target 1  
 civecs  
 grad  
  root 1  
 end  
end  
task tddft gradient  
dplot  
 densmat tddftgrad_co_exden.dmat  
 LimitXYZ  
-4.0 4.0 50  
-4.0 4.0 50  
-4.0 4.0 50  
 gaussian  
 output co_exden.cube  
end  
task dplot
```
