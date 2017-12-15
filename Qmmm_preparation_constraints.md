\_\_NOTITLE\_\_ \_\_NOTOC\_\_

-----

{{template:QMMM_Restart_and_Topology_Files_Links}}

-----

Fixing atoms outside a certain distance from the QM region can also be
accomplished using prepare module. These constraints will then be
permanently embedded in the resulting restart file, which may be
advantageous for certain types of QM/MM simulations. The actual format
for the constraint directive to fix whole residues
is

`fix segments beyond  `<real radius>`  `<integer residue number>`:`<string atom name>

or to fix on atom
basis

`fix atoms beyond  `<real radius>`  `<integer residue number>`:`<string atom name>

{{:qmmm_prepare_fix_example}}
