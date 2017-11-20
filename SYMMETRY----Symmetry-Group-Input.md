SYMMETRY -- Symmetry Group Input
--------------------------------

The SYMMETRY directive is used (optionally) within the compound GEOMETRY directive to specify the point group for the molecular geometry or space group for the crystal structure. The general form of the directive, as described above within the general form of the GEOMETRY directive, is as follows:

`   [SYMMETRY [group] `<string group_name>`|`<integer group number>` [setting `<integer setting>`] [print]   [tol `<real tol default 1d-2>`]]`

The keyword group is optional, and can be omitted without affecting how the input for this directive is processed. However, if the SYMMETRY directive is used, a group name must be specified by supplying an entry for the string variable <group_name> or <group number>. The latter is useful for the space groups discussed in the section below. The group name should be specified as the standard Schöflies symbol. Examples of expected input for the variable group_name include such entries as:

-   c2v - for molecular symmetry \(C<sub>2v</sub>)\)
-   d2h - for molecular symmetry \(D<sub>2h</sub>_\)
-   Td - for molecular symmetry \(T<sub>d</sub>\)
-   d6h - for molecular symmetry \(D<sub>6h</sub>)\)

The SYMMETRY directive is optional. The default is no symmetry (i.e., \(C_1\) point group). Automatic detection of point group symmetry is available through the use of autosym in the GEOMETRY directive main line (discussed in [Keywords on the GEOMETRY directive](/#Keywords_on_the_GEOMETRY_directive "wikilink")). Note: if the SYMMETRY directive is present the autosym keyword is ignored.

If only symmetry-unique atoms are specified, the others will be generated through the action of the point group operators, but the user if free to specify all atoms. The user must know the symmetry of the molecule being modeled, and be able to specify the coordinates of the atoms in a suitable orientation relative to the rotation axes and planes of symmetry. Appendix C lists a number of examples of the GEOMETRY directive input for specific molecules having symmetry patterns recognized by NWChem. The exact point group symmetry will be forced upon the molecule, and atoms within \(10^{-3}\) A.U. of a symmetry element (e.g., a mirror plane or rotation axis) will be forced onto that element. Thus, it is not necessary to specify to a high precision those coordinates that are determined solely by symmetry.

The keyword print gives information concerning the point group generation, including the group generators, a character table, the mapping of centers, and the group operations.

The keyword tol relates to the accuracy with which the symmetry-unique atoms should be specified. When the atoms are generated, those that are within the tolerance, tol, are considered the same.