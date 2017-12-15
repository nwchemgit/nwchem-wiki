1D-RISM module in NWChem provides description of solvated systems
following one-dimensional reference interaction site of model of
Chandler and Anderson. Similar to ab-initio density-functional theory,
1D-RISM can be thought of as an approach where discrete particle
representation of solvent degrees of freedom is replaced by average
density field. Unlike traditional continuum solvation model, this
density based representation is inherently inhomogenous and incorporates
specific molecular features of the solvent. In the current
implementation, 1D-RISM is not directly coupled to QM calculations but
presumed to be used as a post processing step after QM calculations
which provide ESP point charges for a given solute geometry.

Then parameters for 1D-RISM calculations are defined in the rism input
block

`rism`  
`  solute configuration `<filename>  
`  vdw [rule <arithmetic|geometric> ] parameters `<filename>` `  
`  [temp <float default 298.15>]`  
`  [closure <hnc|kh>]`  
`end`

At this point energy task is supported, which is invoked using standard
directive

`task rism energy`

  - **solute configuration** - points to the file that contains
    information about the solute geometry. charges, and atom type
    mapping. The format is similar to xyz style with additional fields
    that specify charge and atom type. The atom type maps back to the
    vdw parameter file (see below). The example file is shown below

`7`  
  
`O1         -1.092111    0.733461    1.237573  -1.104415 O`  
`O2          0.758765   -0.201687    0.473908  -1.043019 O`  
`C1         -0.212954    1.568653   -0.833617  -0.474263 C1`  
`C2         -0.174205    0.630432    0.357135   1.276672 C2`  
`H1          0.360636    1.160405   -1.668859   0.102898 H`  
`H2          0.242419    2.521128   -0.531952   0.118979 H`  
`H3         -1.243967    1.772778   -1.139547   0.123148 H`

  - **vdw** - defines van der waals parameters
      - **rule** - optional setting that specifies combination rule,
        defaults to "arithmetic"
      - **parameters** - points to the file that contains vdw parameters
        for the system. Example file is shown below (note comments in
        the file)

`#Van der Waals parameters file for RISM `  
`# type   sigma(Angstrom) epsilon (kj/mol)`  
`C        0.3400E+01  0.3601E+00`  
`H        0.2600E+01  0.0628E-00`

  - **temp** - defines temperature of the system with default value of
    298.15
  - **closure** - specifies choice of closure

Upon completion of the run, the resulting radial distribution functions
are saved into rdf\_out.data file.

The computed chemical potentials in both HNC and gaussian approximations
are written in the output file.

Here is the complete example input file for solvated calculation of
acetic acid.

`echo`  
`start rism`  
  
`memory global 40 mb stack 23 mb heap 5 mb`  
  
`rism`  
`  closure kh`  
`  temp 298`  
`  vdw rule arithmetic parameters vdw.par`  
`  solute configuration solute2.data`  
`end`  
  
`task energy rism`

solute2.data
file

` 8`  
` `  
` O1         0.15566663    -0.86069508     1.9256322   -0.7323104568123959 O1`  
` O2         2.31302544    -0.61550520     1.32869265  -0.7721248369124809 O2`  
` C1         0.69252260    -1.26942616    -0.34814880  -0.4444201659837397 C1`  
` C2         1.15967680    -0.88531805     1.02642840   1.004561861052242  C2`  
` H1         0.22862001    -2.26160688    -0.31011132   0.1303963270585546 H`  
` H2        -0.08170478    -0.56654621    -0.67834692   0.1513209389506027 H`  
` H3         1.53138139    -1.28351200    -1.04644134   0.1454517042730594 H`  
` H4         0.48680931    -0.66362820     2.83551288   0.5171246283741536 H4`

vdw.par file

`O1  3.0660  0.8809`  
`O2  2.9600  0.8792`  
`C1  3.4000  0.4580`  
`C2  3.4000  0.3601`  
`H   2.1150  0.0657`  
`H4  0.8000  0.1926`
