## LOAD
```
   [ LOAD [format xyz||pdb]  [frame <int frame>] \  
          [select [not] \  
               [name <string atomname>] \  
               [rname <string residue-name>]  
               [id  <int atom-id>|<int range atom-id1:atom-id2> ... ]  
               [resi <int residue-id>|<int range residue-id1:residue-id2> ... ]  
         ]  
    
   <string filename> ]
```
LOAD directive allows users to load Cartesian coordinates from external
pdb or xyz files with the name <filename>. This directive works in
addition to the explicit Cartesian coordinate declaration and can be
repeated and mixed with the latter. This allows for complex coordinate
assemblies where some coordinates are loaded from external files and
some specified explicitly in the input file. The ordering of coordinates
in the final geometry will follow the order in which LOAD statements and
explicit coordinates are specified.

  - The actual file from which coordinates will be loaded is presumed to
    be located in the run directory (the same place where input file
    resides). Its name cannot coincide with any of the keywords in the
    LOAD statement. To keep things simple it is advised to specify it
    either at the beginning or the end of the LOAD directive.

<!-- end list -->

  - **format** xyz || pdb - specifies format of the input file. The only
    formats that are supported at this point are pdb and xyz. Either one
    can contain multiple structures, which can be selected using the
    frame directive. Note that in case of PDB file multiple structures
    are expected to be separated by END keyword. If the format directive
    is not provided the format will be inferred from file extension -
    .xyz for xyz files and .pdb for pdb files

<!-- end list -->

  - **frame** <int frame> - specifies which frame/structure to load from
    multiple structure xyz or pdb files. In the absence of this
    directive the 1st frame/structure will be loaded

<!-- end list -->

  - ''' select ''' ... - this directive allows to selectively load parts
    of the geoemtry in the file within aspecified frame. Selections can
    be based on atom index (**id**), atom name (**name**), and for pdb
    files can also include residue index (**resi**) and residue name
    (**rname**). Atom and residue name selection are based on an *exact*
    single name match. Atom and residue index allow both multiple single
    number and multiple range selection. For example

```
 select id 2 4:6 9
```

will result in the selection of atom id's 2 4 5 6 9.

Multiple selection criteria are always combined as **AND** selections.
For example

```
  select name O  id 2:4
```

will select atoms that are named **O** *and* whose id/index is between 2
and 4. Each selection criteria can be inverted by prepending **not**
keyword. For example

```
  select not name O  id 2:4
```

will select all atoms that are *not* named **O** *and* whose id/index is
between 2 and 4.
