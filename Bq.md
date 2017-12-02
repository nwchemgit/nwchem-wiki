Bq module provides a way to perform QM calculations in the presence of point charges or Bq's,  (as typically referred to in quantum chemistry community). 
Using Bq module versus  geometry block is a recommended way to include point charges in your calculations, in particular if number of charges are big.

The format for including external point charges using the Bq module is shown below, supporting both explicit charge definition in the body of the block and/or loading from external files.

 bq [units au|nm|pm|'''ang'''|...] [namespace]
   [clear]
   [force|noforce]
   [load <file> [charges <chargefile>] [format ix iy iz iq] [units au|nm|pm|'''ang'''|...] [ scale <factor> ]]
   x  y  z  q
   ...
 end

* '''units''' - specify the global units for the coordinates of point charges. Allowed values are au, bohr, nanometers, nm, pm, picometers, angstrom (note that only first 3 characters are important). The default units are angstrom
* '''namespace''' - an optional name that can be used to distinguish between potentially several point charge sets. The default value for namespace is "default", and only the set that has this namespace value will be actually used in the calculation. If for example different namespace is used, this point charge set will be processed into the run time database but not actually used unless the following set directive is encountered
 set bq <namespace>
Here is an example that illustrates this 
 ...
 #store point charge in namespace ''foo''
 bq ''foo''
  ...
 end
 
 #perform calculation without actually loading charges in foo
 task dft energy
 
 #activate charges in foo
 set bq foo
 # now DFT calculation will performed in the presence of charges in foo
 task dft energy

* '''clear''' - this directive erases all the previously specified point charges in a given namespace, prior to new setup (if any).
* '''force''' <output_file> | '''noforce''' this directive triggers|disables calculation of forces on Bq charges. Default value is '''noforce''', which disables force calculation. The forces will be written to <output_file> if provided or to <prefix>.bqforce.dat file. The format of the file is
 #comment line
 fx fy fz
 ...

* '''load''' <file> [charges <chargefile> ] [format ix iy iz iq] [units au|nm|pm|'''ang'''|...] [ scale <factor> ] - this directive allows to load point charges from external file(s). You can load charges and their coordinates from a single file, or from separate files. The files do not have to follow any specific format, but blank lines and comments (starting with #) will be ignored. The actual specification of how the coordinates/charges are laid out in in the file is given by format keyword. Multiple load directives are a supported. 
** <file> - the name of the file where Bq coordinates and charges are stored. 
** charges <chargefile> - this optional keyword allows to load charges (NOT the coordinates) from a separate <chargefile>. In this case, only coordinates would be loaded from <file>

** format ix iy iz iq - this optional keyword allows to set the fields (separated by blanks) where x,y,z coordinates and respective charge values are to be found. If a specified field doe nor exist or contains no numerical value, the processing will skip to the next line. The default value for format is '''2 3 4 5''', which will work for the following example (note that the second line will not be processed here)
 #this is a comment
 coordinates are in fields 2,3,4 and charge is field 5
 O  2.384   1.738   1.380  -0.9     
 H  2.448   1.608   0.416   0.45    
 H  1.560   1.268   1.608   0.45    

** units au|nm|pm|ang|... - this optional keyword sets the local coordinate units valid only for this particular load directive. Otherwise global unit definition will apply (see above)

** scale <factor> - this optional keyword allows to scale loaded charge values by some factor

* x y z q  - explicit definition of coordinates and charge values of point charges. These can be mixed in with load directive at will. 


  start w1
  
  BASIS "ao basis" PRINT
  * library "3-21G"
  END
  
  dft
   mult 1
   XC b3lyp
   iterations 5000
  end
   
  geometry nocenter noautosym units angstrom noautoz print
  O          2.045   1.011  -1.505
  H1         1.912   0.062  -1.314
  H2         1.119   1.318  -1.544
  end
  
  #example of explicit Bq input
  bq
  2.384   1.738   1.380  -0.9
  2.448   1.608   0.416   0.45
  1.560   1.268   1.608   0.45
  end
  
  task dft energy
  
  #example of implicit Bq input using load directive
  bq
  load bq.xyz format 1 2 3 4
  end
  task dft energy
  
  #example of loading coordinates and charges separately
  bq
  load   bq.xyz charges bq.xyz format 1 2 3 4
  end
  task dft energy
  
  #example of loading Bq's with default format (1 2 3 4) and scaling charges (to zero)
  bq
  load bq.xyz scale 0.0
  end
  task dft energy
  
  #example of mixed Bq input
  bq
  load bqO.xyz format 2 3 4 6
  2.448   1.608   0.416   0.45
  1.560   1.268   1.608   0.45
  end
  task dft energy
  
  #example of erasing Bq's
  bq
  clear
  end
  task dft energy
  
  #example of storing Bq's in custom namespace (not activated)
  bq marat
  load bq.xyz format 1 2 3 4
  end
  task dft energy
  
  #example of activating Bq's stored in custom namespace
  set bq marat
  
  task dft energy

* '''Increasing the limit on the number of bq  charges'''
  There is an internal limit of 25000 bq charges. To increase this use the following set directive in the input file
  set bq:max_nbq 30000
