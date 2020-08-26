During the preparation stage of QM/MM calculations the system may also
be solvated using *solvate* directive of the prepare module. It is
recommended that solvation is performed in conjunction with *center* and
*orient* directives.

   Here is an example where the ethanol molecule is declared quantum and solvated in a box of spce waters:

```
title "Prepare QM/MM calculation of solvated ethanol"
start etl
prepare
source etl0.pdb
new_top new_seq
new_rst
#center and orient prior to solvation
center
orient
#solvation in 1 nm by 2 nm by 3 nm box
solvate box 1.0 2.0 3.0
#the whole ethanol is declared quantum now
modify segment 1 quantum
update lists
ignore
write etl_ref.rst
write etl_ref.pdb
end
task prepare
```
