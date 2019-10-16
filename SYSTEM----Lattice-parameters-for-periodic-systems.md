## SYSTEM -- Lattice parameters for periodic systems

This keyword is needed only for for 1-, 2-, and 3-dimensional periodic
systems.

The system keyword can assume the following values

  - polymer -- system with 1-d translational symmetry (not currently
    available with NWPW module).
  - surface -- system with 2-d translational symmetry (not currently
    available with NWPW module).
  - crystal -- system with 3-d translational symmetry.
  - molecule -- no translational symmetry (this is the default)

When the system possess translational symmetry, fractional coordinates
are used in the directions where translational symmetry exists. This
means that for crystals x, y and z are fractional, for surfaces x and y
are fractional, whereas for polymers only z is fractional. For example,
in the following <img alt="$H_{2}O$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d7fc8f229a929f93c03b951b7fe40bf0.svg?invert_in_darkmode&sanitize=true" align=middle width="33.934725pt" height="22.38192pt"/> layer input (a 2-d periodic system), x and y
coordinates are fractional, whereas z is expressed in Angstroms.
```
geometry units angstrom

 O     0.353553    0.353553         2.100000000  
 H     0.263094    0.353553         2.663590000  
 H     0.444007    0.353553         2.663590000
```
Since no space group symmetry is available yet other than P1, input of
cell parameters is relative to the primitive cell. For example, this is
the input required for the cubic face-centered type structure of bulk
MgO.
```
 system crystal  
  lat_a 2.97692  
  lat_b 2.97692  
  lat_c 2.97692  
  alpha 60.00   
  beta 60.00   
  gamma 60.00  
 end
```