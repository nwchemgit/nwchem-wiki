
Fixing atoms outside a certain distance from the QM region can also be
accomplished using prepare module. These constraints will then be
permanently embedded in the resulting restart file, which may be
advantageous for certain types of QM/MM simulations. The actual format
for the constraint directive to fix whole residues
is
```
fix segments beyond  <real radius>  <integer residue number>:<string atom name>
```
or to fix on atom
basis
```
fix atoms beyond  <real radius>  <integer residue number>:<string atom name>
```

This example illustrates the use of permanent fix directives during preparation stage  

```
start etl
prepare
source etl0.pdb
new_top new_seq
new_rst
center
orient
#solvation in 40 A cubic box
solvate cube 4.0
modify segment 1 quantum
#fix residues more than 20 A away from ethanol oxygen atom
fix segments beyond 2.0 1:_O
update lists
ignore
write etl_ref.rst
write etl_ref.pdb
end
task prepare
```
