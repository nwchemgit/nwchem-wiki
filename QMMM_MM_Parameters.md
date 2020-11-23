The molecular mechanics parameters are given in the form of standard MD
input block as used by the [MD module](MD "wikilink"). At
the basic level the molecular mechanics input block specifies the
restart and topology file that were generated during QM/MM [preparation
stage](QMMM_Restart_and_Topology_Files "wikilink"). It also
contains information relevant to the calculation of the classical region
(e.g. cutoff distances, constraints, optimization and dynamics
parameters, etc) in the system. In this input block one can also set
fixed atom constraints on classical atoms. Continuing with our [prepare
example for ethanol
molecule](Qmmm_preparation_basic#example "wikilink") here is
a simple input block that may be used for this system.
```
 md  
# this specifies that etl_md.rst will be used as a restart file  
#  and etl.top will be a topology file  
  system etl_md  
# if we ever wanted to fix C1 atom   
  fix solute 1 _C1  
  noshake solute  
 end
```
The *noshake solute*, shown in the above example is a recommended
directive for QM/MM simulations that involve
[optimizations](qmmm_optimization "wikilink"). Otherwise
user has to ensure that the [optimization
method](qmmm_method "wikilink") for classical solute atoms
is a steepest descent
