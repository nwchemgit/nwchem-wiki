# Constraints

The constraints directive allows the user to specify which constraints
should be imposed on the system during the analysis of potential energy
surface. Currently such constraints are limited to fixed atom positions
and harmonic restraints (springs) on the distance between the two atoms.
The general form of constraints block is presented
below:
```
CONSTRAINTS [string name ] \  
          [clear] \  
          [enable||disable] \  
          [fix atom <integer list>] \  
          [spring bond <integer atom1> <integer atom2> <real k> <real r0> ]  
          [spring dihedral <integer atom1> <integer atom2> <integer atom3> <integer atom4> <real k> <real phi0 in degrees> ] 
          [spring bondings <real K0> <real gamma0> [<real ca> <integer atom1a> <integer atom2a> 
                                             <real cb> <integer atom1b> <integer atom2b>
                                             ...]]
          [penalty pbondings <real K0> <real gcut0> <real gamma0> [<real ca> <integer atom1a> <integer atom2a> 
                                                           <real cb> <integer atom1b> <integer atom2b>
                                                           ...]]
 END
```
The keywords are described below

  - name - optional keyword that associates a name with a given set of
    constraints. Any unnamed set of constraints will be given a name
    *default* and will be automatically loaded prior to a calculation.
    Any constraints with the name other than *default* will have to be
    loaded manually using SET directive. For example,
```
 CONSTRAINTS one  
   spring bond 1 3 5.0 1.3
   fix atom 1  
 END 
  
 #the above constraints can be loaded using the set directive`  
 set constraints one  
 ....  
 task ....
```
  - clear - destroys any prior constraint information. This may be
    useful when the same constraints have to be redefined or completely
    removed from the runtime database.

<!-- end list -->

  - enable||disable - enables or disables particular set of constraints
    without actually removing the information from the runtime database.

<!-- end list -->

  - fix atom - fixes atom positions during geometry optimization. This
    directive requires an integer list that specifies which atoms are to
    be fixed. This directive can be repeated within a given constraints
    block. To illustrate the use "fix atom" directive let us consider a
    situation where we would like to fix atoms 1, 3, 4, 5, 6 while
    performing an optimization on some hypothetical system. There are
    actually several ways to enter this particular constraint.

<!-- end list -->

  - There is a straightforward option which requires the most
        typing:
```
       constraints  
         fix atom 1 3 4 5 6 
       end
```
  - Second method uses list input:
```
       constraints  
         fix atom 1 3:6  
       end
```
  - Third approach illustrates the use of multiple fix atom
        directives:
```
       constraints 
         fix atom 1 
         fix atom 3:6 
       end
```
  - spring bond <img alt="$&lt;i j k r_0&gt;$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/424902055502ece4201b8adbfaa6ef95.svg?invert_in_darkmode&sanitize=true" align=middle width="71.741175pt" height="22.74591pt"/> - places a spring with a spring constant
    *k* and equilibrium length <img alt="$r_0$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/1db75c795ab2c794f72bbe79b8113be1.svg?invert_in_darkmode&sanitize=true" align=middle width="13.91676pt" height="14.10255pt"/> between atoms *i* and *j* (all in
    atomic units). Please note that this type of constraint adds an
    additional term to the total energy expression

<img alt="$E=E_{total}+ \,\!\frac{1}{2} k(r_{ij}-r_0)^2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2f6a0c2ad3fa444503a3d7e314f3f89f.svg?invert_in_darkmode&sanitize=true" align=middle width="188.214345pt" height="27.72033pt"/>

This additional term forces the distance between atoms *i* and *j* to be
in the vicinity of <img alt="$r_0$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/1db75c795ab2c794f72bbe79b8113be1.svg?invert_in_darkmode&sanitize=true" align=middle width="13.91676pt" height="14.10255pt"/> but never exactly that. In general the spring
energy term will always have some nonzero residual value, and this has
to be accounted for when comparing total energies. The "spring bond"
directive can be repeated within a given constraints block. If the
spring between the same pair of atoms is defined more than once, it will
be replaced by the latest specification in the order it appears in the
input block.
