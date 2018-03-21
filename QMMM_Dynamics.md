 Dynamical simulations within QM/MM framework can be
initiated using

`task qmmm `<qmtheory>` dynamics`

directive. User has to specify the
[region](/Release66:qmmm_region "wikilink") for which simulation will
performed. If dynamics is performed only for the classical parts of the
system (QM region is fixed) then ESP point charge representation
([density espfit](/Release66:qmmm_density "wikilink")) is recommended to
speed up simulations. If this option is utilized then wavefunction file
(<system>.movecs) has to be available and present in the permanent
directory (this can be most easily achieved by running energy
calculation prior to dynamics).
