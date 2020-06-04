### Setup

QM/MM hessian and frequency calculations are invoked though the
following task directives

`task qmmm `<qmtheory>` hessian`

or

`task qmmm `<qmtheory>` freq`

Only numerical implementation are supported at this point and will be
used even in the absence of "numerical" keyword. Other than standard
QM/MM directives no additional QM/MM input is required for default
hessian/frequency for all the QM atoms. Using
[region](Qmmm_region) keyword(first region only),
hessian/frequency calculations can also be performed for classical
solute atoms. If only classical atoms are involved
[density](Qmmm_density) keyword can be utilized to enable
frozen density or ESP charge representation for fixed QM region.
Hessian/frequency calculations for solvent are not possible.

### Examples

#### Example of QM/MM frequency calculation for classical region

This example illustrates QM/MM frequency calculation for Ala-Ser-Ala
system. In this case instead of default QM region (see prepare block),
the calculation is performed on classical solute part of the system as
defined by region directive in QM/MM block. The electrostatic field from
fixed QM region is represented by point ESP charges (see density
directive). These ESP charges are calculated from wavefunction generated
as a result of energy calculation.

` memory total 800 Mb`  
  
` start asa`  
  
` permanent_dir ./perm`  
` scratch_dir ./data`  
  
` #this will generate topology file (`[`asa.top`](media:asa.top)`), restart (`[`asa_ref.rst`](media:asa_ref.rst)`), and pdb (`[`asa_ref.pdb`](media:asa_ref.pdb)`) files.`  
` prepare`  
`   source `[`asa.pdb`](media:asa.pdb)  
`   new_top new_seq`  
`   new_rst`  
`   modify atom 2:_CB quantum`  
`   modify atom 2:2HB quantum`  
`   modify atom 2:3HB quantum`  
`   modify atom 2:_OG quantum`  
`   modify atom 2:_HG quantum`  
`   center`  
`   orient`  
`   solvate`  
`   update lists`  
`   ignore`  
`   write `[`asa_ref.rst`](media:asa_ref.rst)  
`   write `[`asa_ref.pdb`](media:asa_ref.pdb)`   # Write out PDB file to check structure`  
` end`  
` task prepare`

` md`  
`   system asa_ref`  
` end`  
  
` basis "ao basis"`  
`   * library "6-31G*"`  
` end`  
  
` dft`  
`  print low`  
`  iterations 500`  
` end`  
  
` qmmm`  
` region mm_solute`  
` density espfit`  
` end`  
  
` # run energy calculation to generate wavefunction file for subsequent ESP charge generation`  
` task qmmm dft energy`  
` task qmmm dft freq`
