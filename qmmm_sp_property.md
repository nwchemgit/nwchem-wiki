A number of electronic structure properties can be calculated with QM/MM
using capabilities provided by [property](Properties),
[esp](ESP), and [dplot modules](DPLOT).

The example below illustrates dipole property QM/MM DFT/B3LYP
calculation for quantum water molecule embedded into 20 angstrom box of
classical SPCE/E water molecules.

The preparation stage that involves definition of the QM region and
solvation is performed as part of the calculation. Note that water
fragment file [wtr.frg](media:WTR.frg) is required in this
calculation. Prepare run will generate restart file
([wtr\_ref.rst](media:wtr_ref.rst)) and topology file
([wtr.top](media:wtr.top))

In the QM/MM interface block the use of bq\_zone value of 3.0 Angstrom
is specified.

`  start wtr`

`  permanent_dir ./perm`  
`  scratch_dir ./data`

`  prepare`  
`  source wtr0.pdb`  
`  new_top new_seq`  
`  new_rst`  
`  modify segment 1  quantum`  
`  center`  
`  orient`  
`  solvate box 3.0`  
`  update lists`  
`  ignore`  
`  write wtr_ref.rst`  
`  write wtr_ref.pdb`  
`  end`

`  task prepare`

`  md`  
`  system wtr_ref`  
`  end`

`  basis`  
`  * library "6-31G"`  
`  end`

`  dft`  
`  xc b3lyp`  
`  end`

`  qmmm`  
`  bq_zone 3.0`  
`  end`

`  property`  
`   dipole`  
`  end`

`  task qmmm dft property`


  - Example QM/MM ESP Calculation:

The example below illustrates dipole property QM/MM DFT/B3LYP
calculation for quantum water molecule embedded into 20 angstrom box of
classical SPCE/E water molecules.

The preparation stage that involves definition of the QM region and
solvation is performed as part of the calculation. Note that water
fragment file [wtr.frg](media:WTR.frg) is required in this
calculation. Prepare run will generate restart file
([wtr\_ref.rst](media:wtr_ref.rst)) and topology file
([wtr.top](media:wtr.top))

In the QM/MM interface block the use of bq\_zone value of 3.0 Angstrom
is specified.

`  start wtr`

`  permanent_dir ./perm`  
`  scratch_dir ./data`

`  prepare`  
`  source wtr0.pdb`  
`  new_top new_seq`  
`  new_rst`  
`  modify segment 1  quantum`  
`  center`  
`  orient`  
`  solvate box 3.0`  
`  update lists`  
`  ignore`  
`  write wtr_ref.rst`  
`  write wtr_ref.pdb`  
`  end`

`  task prepare`

`  md`  
`  system wtr_ref`  
`  end`

`  basis`  
`  * library "6-31G"`  
`  end`

`  dft`  
`  xc b3lyp`  
`  end`

`  qmmm`  
`  bq_zone 3.0`  
`  end`

`  property`  
`   dipole`  
`  end`

`  task qmmm dft property`
