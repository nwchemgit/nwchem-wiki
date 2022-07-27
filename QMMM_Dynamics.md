 Dynamical simulations within QM/MM framework can be
initiated using
```
task qmmm  <qmtheory>  dynamics 
```
directive. User has to specify the
[region](Qmmm_region.md) for which simulation will
performed. If dynamics is performed only for the classical parts of the
system (QM region is fixed) then ESP point charge representation
([density espfit](Qmmm_density.md)) is recommended to
speed up simulations. If this option is utilized then wavefunction file
(<system>.movecs) has to be available and present in the permanent
directory (this can be most easily achieved by running energy
calculation prior to dynamics).
