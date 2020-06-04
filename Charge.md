# CHARGE

This is an optional top-level directive that allows the user to specify
the total charge of the system. The form of the directive is as follows:

```
CHARGE <real charge default 0>
```

The charge directive, in conjunction with the charges of atomic nuclei
(which can be changed via the geometry input, cf. Section [Geometry](Geometry)),
determines the total number of electrons in the chemical system.
Therefore, a charge n specification removes "n" electrons from the
chemical system. Similarly, charge -n adds "n" electrons. is zero if
this directive is omitted. An example of a case where the directive
would be needed is for a calculation on a doubly charged cation. In such
a case, the directive is simply,

```
charge 2
```

If centers with [fractional charge](Geometry) have been
specified the net charge of the system should be adjusted to ensure that
there are an integral number of electrons.

The charge may be changed between tasks, and is used by all wavefunction
types. For instance, in order to compute the first two vertical
ionization energies of \(LiH\), one might optimize the geometry of
\(LiH\) using a UHF SCF wavefunction, and then perform energy
calculations at the optimized geometry on LiH<sup>+</sup> and LiH<sup>2+</sup> in
turn. This is accomplished with the following
input:
```
geometry; Li 0 0 0; H 0 0 1.64; end basis; Li library 3-21g; H library 3-21g; end  
scf; uhf; singlet; end task scf optimize  
charge 1 scf; uhf; doublet; end task scf  
charge 2 scf; uhf; singlet; end task scf
```
The GEOMETRY, BASIS, and SCF directives are described below
([Geometry](Geometry), [Basis](Basis) and
[SCF](Hartree-Fock-Theory-for-Molecules) respectively) but
their intent should be clear. The TASK directive is described above
([TASK](TASK)).
