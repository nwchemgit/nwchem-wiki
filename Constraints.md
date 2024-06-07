# Constraints

The constraints directive allows the user to specify which constraints
should be imposed on the system during the analysis of potential energy
surface. Currently such constraints are limited to fixed atom positions
and harmonic restraints (springs) on the distance between the two atoms.
The general form of constraints block is presented
below:
```
CONSTRAINTS [string name ] \  
          [clear] \  
          [enable||disable] \  
          [fix atom <integer list>] \  
          [spring bond <integer atom1> <integer atom2> <real k> <real r0> ]  
          [spring dihedral <integer atom1> <integer atom2> <integer atom3> <integer atom4> <real k> <real phi0 in degrees> ] 
          [spring bondings <real K0> <real gamma0> [<real ca> <integer atom1a> <integer atom2a> 
                                             <real cb> <integer atom1b> <integer atom2b>
                                             ...]]
          [penalty pbondings <real K0> <real gcut0> <real gamma0> [<real ca> <integer atom1a> <integer atom2a> 
                                                           <real cb> <integer atom1b> <integer atom2b>
                                                           ...]]
 END
```
The keywords are described below

  - `name` - optional keyword that associates a name with a given set of
    constraints. Any unnamed set of constraints will be given a name
    *default* and will be automatically loaded prior to a calculation.
    Any constraints with the name other than *default* will have to be
    loaded manually using the [SET](SET) directive. For example,
```
 CONSTRAINTS one  
   spring bond 1 3 5.0 1.3
   fix atom 1  
 END 
```  
the above constraints can be loaded using the following set directive that assigns the name `one` as the current constraint  
```
 set constraints one  
 ....  
 task ....
```
  - `clear` - destroys any prior constraint information. This may be
    useful when the same constraints have to be redefined or completely
    removed from the runtime database.

<!-- end list -->

  - `enable||disable` - enables or disables 
    without actually removing the information from the runtime database.
<!-- end list -->

  - `fix atom` - fixes atom positions during geometry optimization. This
    directive requires an integer list that specifies which atoms are to
    be fixed. This directive can be repeated within a given constraints
    block. To illustrate the use `fix atom` directive let us consider a
    situation where we would like to fix atoms 1, 3, 4, 5, 6 while
    performing an optimization on some hypothetical system. There are
    actually several ways to enter this particular constraint.

<!-- end list -->

  - There is a straightforward option which requires the most
        typing:
```
       constraints  
         fix atom 1 3 4 5 6 
       end
```
  - Second method uses list input:
```
       constraints  
         fix atom 1 3:6  
       end
```
  - Third approach illustrates the use of multiple `fix atom`
        directives:
```
       constraints 
         fix atom 1 
         fix atom 3:6 
       end
```
  - the `spring bond` *< i j k r<sub>0</sub> >* - places a spring with a spring constant
    *k* and equilibrium length *r<sub>0</sub>* between atoms *i* and *j* (all in
    atomic units). Please note that this type of constraint adds an
    additional term to the total energy expression

*E = E<sub>total</sub> + &frac12; k (r<sub>ij</sub> - r<sub>0</sub>)<sup>2</sup>*  

This additional term forces the distance between atoms *i* and *j* to be
in the vicinity of *r<sub>0</sub>* but never exactly that. In general the spring
energy term will always have some nonzero residual value, and this has
to be accounted for when comparing total energies. The `spring bond`
directive can be repeated within a given constraints block. If the
spring between the same pair of atoms is defined more than once, it will
be replaced by the latest specification in the order it appears in the
input block.

- spring dihedral places a spring with....

- spring bondings places a spring with....

- penalty pbondings places a penalty function with....
