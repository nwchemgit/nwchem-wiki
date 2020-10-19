
One of major required pieces of information that has to be provided in
the prepare block for QM/MM simulations is the definition of the QM
region. This can be accomplished using *modify* directive used either
per atom
```
modify atom <integer isgm>:<string atomname> quantum
```
or per segment/residue basis
```
modify segment <integer isgm> quantum
```
Here *isgm* and *atomname* refer to the residue number and atom name
record as given in the PDB file. It is important to note that that the
leading blanks in atom name record should be indicated with underscores.
Per PDB format guidelines the atom name record starts at column 13. If,
for example, the atom name record "OW" starts in the 14th column in PDB
file, it will appear as "_OW" in the modify atom directive in the
prepare block.

In the current implementation only solute atoms can be declared as
quantum. If part of the solvent has to be treated quantum mechanically
then it has to redeclared to be solute. The definition of QM region
should be accompanied by *update lists* and *ignore* directives.
<span id="example"></span> Here is an example input file that will
generate QM/MM restart and topology files for the ethanol molecule:
```
title "Prepare QM/MM calculation of ethanol"  
start etl  
  
[prepare](Prepare)  
#--*name of the pdbfile*  
   source [etl0.pdb](etl0.pdb)                      
#--*generate new topology and sequence file*  
   new_top new_seq                      
#--*generate new restart file*  
   new_rst                              
#--*define quantum region (note the use of underscore)*  
   modify atom 1:_C1  quantum           
   modify atom 1:2H1  quantum           
   modify atom 1:3H1  quantum            
   modify atom 1:4H1  quantum           
   update lists  
   ignore  
#--*save restart file*     
   write etl_ref.rst  
#--*generate pdb file*  
   write [etl_ref.pdb](etl_ref.pdb)  
end   
task prepare
```
Running the input shown above will produce (among other things) the
topology file (etl.top), the restart file (etl_ref.rst), and the pdb
file [etl_ref.pdb](etl_ref.pdb). The prefix for the topology file follows after the
rtdb name specified in the start directive in the input (i.e. "start
etl"), while the names for the restart and pdb files were specified
explicitly in the input file. In the absence of the explicit write
statement for the restart file, it would be generated under the name
"etl_md.rst". The pdb file would only be written in the presence of the
explicit write statement.

<span id="tip"></span>**Tip**: *It is strongly recommended to check the
correctness of the generated pdb file versus the original "source" pdb
file to catch possible errors in the formatting of the pdb and fragment
files.*
