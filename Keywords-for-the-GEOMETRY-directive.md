## Keywords for the GEOMETRY directive

This section presents the options that can be specified using the
keywords and optional input on the main line of the GEOMETRY directive.
As described above, the first line of the directive has the general
form,
```
 GEOMETRY [<string name default geometry>] \  
          [units <string units default angstroms>] \  
          [bqbq] \  
          [print [xyz] || noprint] \ 
          [center || nocenter] \
          [autosym [real tol default 1d-2] || noautosym]  
          [autoz || noautoz] \  
          [adjust] \  
          [(nuc || nucl || nucleus) <string nucmodel>]
```
All of the keywords and input on this line are optional. The following
list describes all options and their defaults.

### NAME  
`<name>` is a user-supplied name for the geometry; the default name is
    geometry, and all NWChem modules look for a geometry with this name.
    However, multiple geometries may be specified by using a different
    name for each. Subsequently, the user can direct a module to a named
    geometry by using the [SET](SET.md) directive (see the example in the [SET Section](SET.md))
    to associate the default name of geometry with the alternate name.
  
### UNITS  
The `units`  keyword specifies what value will be entered by the user
    for the string variable `<units>`. The default units for the geometry
    input are Angstrøms (Note: atomic units or Bohr are used within the
    code, regardless of the option specified for the input units. The
    default conversion factor used in the code to convert from Angstrøms
    to Bohr is 1.8897265 which may be overidden with the
    `angstrom_to_au` keyword described below).    
 The code recognizes the following possible values for the string variable `<units>`:  
  
* `angstroms` or `an`: Angstrøms , the default (converts to A.U. using the Angstrøm to A.U. conversion factor)  
* `au` or `atomic` or `bohr`: Atomic units (A.U.)  
* `nm` or `nanometers`: nanometers (converts to A.U. using a conversion factor computed as 10.0 times the Angstrøm to A.U. conversion factor)   
* `pm` or `picometers`: `picometers` (converts to A.U. using a conversion factor computed as 0.01 times the Angstrøm to A.U. conversion factor)     
    
### ANGSTROM_TO_AU
  The  `angstrom_to_au` option may also be specified as `ang2au`. This enables the
    user to modify the conversion factors used to convert between
    Angstrøm and A.U.. The default value is 1.8897265.
  
### BQBQ
  The `bqbq`  keyword specifies the treatment of interactions between
    dummy centers. The default in NWChem is to ignore such interactions
    when computing energies or energy derivatives. These interactions
    will be included if the keyword `bqbq` is specified.
  
### PRINT/NOPRINT
   `print` and `noprint` is a complementary keyword pair to enable or disable
    printing of the geometry. The default is to print the output
    associated with the geometry. In addition, the keyword print may be
    qualified by the additional keyword xyz, which specifies that the
    coordinates should be printed in the XYZ format of molecular
    graphics program XMol
  
### CENTER/NOCENTER  
  `center` and `nocenter` is a complementary keyword pair to enable or
    disable translation of the center of nuclear charge to the origin.
    With the origin at this position, all three components of the
    nuclear dipole are zero. The default is to move the center of
    nuclear charge to the origin.
  
### AUTOSYM/NOAUTOSYM   
  `autosym` and `noautosym` are keywords to specify that the symmetry of the
    geometric system should be automatically determined. This option is
    on by default, but can be turned off with noautosym. Only groups up
    to and including O<sub>h</sub> are recognized. Occasionally NWChem will
    be unable to determine the full symmetry of a molecular system, but
    will find a proper subgroup of the full symmetry. The default
    tolerance is set to work for most cases, but may need to be
    decreased to find the full symmetry of a geometry. Note that autosym
    will be turned off if the SYMMETRY group input is given (See
    [Symmetry Group
    Input](SYMMETRY----Symmetry-Group-Input)). Also note
    that if symmetry equivalent atoms have different tags in the
    geometry they will not be detected as symmetry equivalent by the
    `autosym` capability. The reason for this is that atoms with different
    tags might be assigned different basis sets, for example, after
    which they are no longer symmetry equivalent. Therefore autosym
    chooses to make the save choice.
  
### AUTOZ/NOAUTOZ
By default NWChem will generate
    redundant internal coordinates from user input Cartesian
    coordinates. The internal coordinates will be used in geometry
    optimizations. The `noautoz` keyword disables use of internal
    coordinates. The `autoz` keyword is provided only for backward
    compatibility. See [Forcing internal
    coordinates](ZCOORD-Forcing-internal-coordinates) for
    a more detailed description of redundant internal coordinates,
    including how to force the definition of specific internal variables
    in combination with automatically generated variables.
  
### ADJUST  
  Use of the `adjust` keyword indicates that an existing geometry is to be adjusted.
    Only new input for the redundant internal coordinates may be
    provided ([ZCOORD: Forcing internal
    coordinates](ZCOORD-Forcing-internal-coordinates.md)). It
    is not possible to define new centers or to modify the point group
    using this keyword. See  the section [use of the adjust keyword](ZCOORD-Forcing-internal-coordinates.md#how-to-use-the-adjust-keyword) for
    an example of its usage.
  
### NUCLEUS  
The `nucleus`  keyword to specifies the default model for the nuclear
    charge distribution. The following values are recognized:  

* `point` or `pt`: point nuclear charge distribution. This is the default.  
* `finite` or `fi`: finite nuclear charge distribution with a Gaussian shape.
The RMS radius of the Gaussian is determined from the nuclear mass number A by the expression
  
        <pre>r<sub> RMS</sub> = 0.836*A<sup>1/3</sup>+0.57 fm</pre>
  	
NOTE: If you specify a finite nuclear size, you should ensure that the
[basis set](Basis) you use is contracted for a finite nuclear
size.

The following examples illustrate some of the various options that the
user can specify on the first input line of the GEOMETRY directive,
using the keywords and input options described above.

The following directives all specify the same geometry for  H<sub>2</sub> (a
bond length of 0.732556 Å):
```
 geometry                           geometry units nm     
   h 0 0 0                            h 0 0 0             
   h 0 0 0.732556                     h 0 0 0.0732556     
 end                                end                  

 geometry units pm                  geometry units atomic  
   h 0 0 0                            h 0 0 0               
   h 0 0 73.2556                      h 0 0 1.3843305       
 end                                end
```
