## Cartesian coordinate input

The default in NWChem is to specify the geometry information entirely in
Cartesian coordinates, and examples of this format have appeared above
(e.g, [Water Molecule
Input](Getting-Started#water-molecule-sample-input-file)).
Each center (usually an atom) is identified on a line of the following
form:

```
   <string tag> <real x y z> [vx vy vz] \
       [charge <real charge>] [mass <real mass>] \
       [(nuc || nucl || nucleus) <string nucmodel>]
```

The string `<tag>` is the name of the atom or center, and its case (upper
or lower) is important. The tag is limited to 16 characters and is
interpreted as follows:

  - If the entry for `<tag>` begins with either the symbol or name of an
    element (regardless of case), then the center is treated as an atom
    of that type. The default charge is the atomic number (adjusted for
    the presence of ECPs by the ECP NELEC directive ; see Section 8).
    Additional characters can be added to the string, to distinguish
    between atoms of the same element (For example, the tags `oxygen`, `O`,
    `o34`, `olonepair`, and `Oxygen-ether`, will all be interpreted as oxygen
    atoms.).
  - If the entry for `<tag>` begins with the characters `bq` or `x`
    (regardless of case), then the center is treated as a dummy center
    with a default zero charge (Note: a tag beginning with the
    characters xe will be interpreted as a xenon atom rather than as a
    dummy center.). Dummy centers may optionally have basis functions or
    non-zero charge.

It is important to be aware of the following points regarding the
definitions and usage of the values specified for the variable <tag> to
describe the centers in a system:

  - If the tag begins with characters that cannot be matched against an
    atom, and those characters are not BQ or X, then a fatal error is
    generated.
  - The tag of a center is used in the
    [BASIS](Basis) and
    [ECP](ECP) directives to associate functions
    with centers.
  - All centers with the same tag will have the same basis functions.
  - When using automatic symmetry detection, only centers with the same
    tag will be candidates for testing for symmetry equivalence.
  - The user-specified charges (of all centers, atomic and dummy) and
    any net [total charge](Charge) of the system
    are used to determine the number of electrons in the system.

The Cartesian coordinates of the atom in the molecule are specified as
real numbers supplied for the variables `x`, `y`, and `z` following the
characters entered for the tag. The values supplied for the coordinates
must be in the units specified by the value of the variable <units> on
the first line of the GEOMETRY directive input.

After the Cartesian coordinate input, optional velocities may be entered
as real numbers for the variables `vx`, `vy`, and `vz`. The velocities should
be given in atomic units and are used in QMD and PSPW calculations.

The Cartesian coordinate input line also contains the optional keywords
`charge`, `mass` and `nucleus`, which allow the user to specify the charge of
the atom (or center) and its mass (in atomic mass units), and the
nuclear model. The default charge for an atom is its atomic number,
adjusted for the presence of [ECPs](ECP). In order
to specify a different value for the charge on a particular atom, the
user must enter the keyword charge, followed by the desired value for
the variable <charge>.

The default mass for an atom is taken to be the mass of its most
abundant naturally occurring isotope or of the isotope with the longest
half-life. To model some other isotope of the element, its mass must be
defined explicitly by specifying the keyword mass, followed by the value
(in atomic mass units) for the variable <mass>.

The default nuclear model is a point nucleus. The keyword `nucleus` (or
`nucl` or `nuc`) followed by the model name `<nucmodel>` overrides this
default. Allowed values of `<nucmodel>` are `point` or `pt` and `finite` or `fi`.
The finite option is a nuclear model with a Gaussian shape. The RMS
radius of the Gaussian is determined by the atomic mass number via the
  formula r<sub>RMS</sub> = 0.836*A<sup>1/3</sup>+0.57 fm. The mass number A is
derived from the variable `<mass>`.

The geometry of the system can be specified entirely in Cartesian
coordinates by supplying a `<tag>` line of the type described above for
each atom or center. The user has the option, however, of supplying the
geometry of some or all of the atoms or centers using a Z-matrix
description. In such a case, the user supplies the input tag line
described above for any centers to be described by Cartesian
coordinates, and then specifies the remainder of the system using the
optional ZMATRIX directive described below in [Z-matrix
input](#ZMATRIX_--_Z-matrix_input).
