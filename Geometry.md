The GEOMETRY directive is a compound directive that allows the user to
define the geometry to be used for a given calculation. The directive
allows the user to specify the geometry with a relatively small amount
of input, but there are a large number of optional keywords and
additional subordinate directives that the user can specify, if needed.
The directive therefore appears to be rather long and complicated when
presented in its general form, as
follows:

```
 GEOMETRY [<string name default geometry>] \  
          [units <string units default angstroms>] \  
          [(angstrom_to_au || ang2au) \  
                 <real angstrom_to_au default 1.8897265>] \  
          [print [xyz] || noprint] \  
          [center || nocenter] \  
          [bqbq] \  
          [autosym [real tol default 1d-2] || noautosym] \  
          [autoz || noautoz] \  
          [adjust] \  
          [(nuc || nucl || nucleus) <string nucmodel>]  
   [SYMMETRY [group] <string group_name> [print] \  
          [tol <real tol default 1d-2>]]  
   [ [LOAD] [format xyz||pdb]  [frame <int frame>] \  
          [select [not] \  
               [name <string atomname>] \  
               [rname <string residue-name>]  
               [id  <int atom-id>|<int range atom-id1:atom-id2> ... ]  
               [resi <int residue-id>|<int range residue-id1:residue-id2> ... ]  
         ]  
   <string filename> ]  
    
   <string tag> <real x y z> [vx vy vz] [charge <real charge>] \  
          [mass <real mass>] \  
          [(nuc || nucl || nucleus) <string nucmodel>]  
   ... ]  
   [ZMATRIX || ZMT || ZMAT  
        <string tagn> <list_of_zmatrix_variables>  
        ...   
        [VARIABLES  
             <string symbol> <real value>  
             ... ]  
        [CONSTANTS  
             <string symbol> <real value>  
             ... ]  
    (END || ZEND)]  
    [ZCOORD  
         CVR_SCALING <real value>  
         BOND    <integer i> <integer j> \  
                 [<real value>] [<string name>] [constant]  
         ANGLE   <integer i> <integer j> \  
                     [<real value>] [<string name>] [constant]  
         TORSION <integer i> <integer j> <integer k> <integer l> \  
                 [<real value>] [<string name>] [constant]  
     END]  
           
     [SYSTEM surface  <molecule polymer surface crystal default molecule>  
          lat_a <real lat_a> lat_b <real lat_b> lat_c <real lat_c>  
          alpha <real alpha> beta <real beta> gamma <real gamma>  
     END]  
  END
```

The three main parts of the GEOMETRY directive are:

- keywords on the first line of the directive (to specify such
    optional input as the geometry name, input units, and print level
    for the output)
- symmetry information
- Cartesian coordinates or Z-matrix input to specify the locations of
    the atoms and centers
- lattice parameters (needed only for periodic systems)

The following sections present the input for this compound directive in
detail, describing the options available and the usages of the various
keywords in each of the three main parts.

- [Keywords on the GEOMETRY
    directive](Keywords-on-the-GEOMETRY-directive.md)

- [SYMMETRY -- Symmetry Group
    Input](SYMMETRY----Symmetry-Group-Input.md)

- [Names of 3-dimensional space
    groups](Names-of-3-dimensional-space-groups.md)

- [Cartesian coordinate
    input](Cartesian-coordinate-input.md)

- [ZMATRIX -- Z-matrix
    input](ZMATRIX-Z-matrix-input.md)

- [ZCOORD -- Forcing internal
    coordinates](ZCOORD-Forcing-internal-coordinates.md)

- [SYSTEM -- Lattice parameters for periodic
    systems](SYSTEM----Lattice-parameters-for-periodic-systems.md)

- [LOAD -- Load geometry from
     XYZ file](Geometry-load.md)

<!-- end list -->
