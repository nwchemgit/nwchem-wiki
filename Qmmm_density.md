```
density  [espfit] [static] [dynamical] default dynamical
```
This directive controls the electrostatic representation of *fixed* QM
region during optimization/dynamics of classical regions. It has no
effect when position of QM atoms are changing.

  - **dynamical** is an option where QM region is treated the standard
    way, through the recalculation of the wavefunction calculated and
    the resulting electron density is used to compute electrostatic
    interactions with classical atoms. This option is the most expensive
    one and becomes impractical for large scale optimizations.


  - **static** option will not recalculate QM wavefunction but will
    still use full electron density in the computations of electrostatic
    interactions.


  - **espfit** option will not recalculate QM wavefunction nor it will
    use full electron density. Instead, a set of ESP charges for QM
    region will be calculated and used to compute electrostatic
    interactions with the MM regions. This option is the most efficient
    and is strongly recommended for large systems.

Note that both "static" and "espfit" options do require the presence of
the movecs file. It is typically available as part as part of
calculation process. Otherwise it can be generated by running qmmm
energy calculation.

In most calculations default value for **density** would **dynamical**,
with the exception of free energy calculations where default setting
**espfit** will be used.