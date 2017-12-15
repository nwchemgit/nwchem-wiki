\_\_NOTITLE\_\_

## QMMM Introduction

The combined quantum mechanical molecular mechanics (QM/MM) approach
provides a simple and effective tool to study localized molecular
transformations in large scale systems such as those encountered in
solution chemistry or enzyme catalysis. In this method an accurate but
computationally intensive quantum mechanical (QM) description is only
used for the regions where electronic structure transformations are
occurring (e.g. bond making and breaking). The rest of the system, whose
chemical identity remains essentially the same, is treated at the
approximate classical molecular mechanics (MM)
level.

`   The QM/MM module in NWChem is built as a top level interface between the classical MD module and various QM modules, managing initialization, data transfer, and various high level operations. The size of the system (10^3 - 10^5 atoms) and the need for classical force field parameters precludes description of the system through just the geometry input block as would be done in pure QM simulations. Instead a separate `[`preparation``
``stage`](QMMM_Restart_and_Topology_Files "wikilink")` is required. In a typical setting this `[`preparation``
``run`](QMMM_Restart_and_Topology_Files "wikilink")` will be done separately from the main QM/MM simulations resulting in the generation of topology and restart files. The topology file contains a list of all relevant force field interactions encountered in the system but has no information about the actual atom positions. Typically the topology file will be generated once and reused throughout the entire simulation. The actual structural information about the system is contained in the restart file, which will be changing as the system coordinates are updated during the course of the simulation.`

Once restart and topology files are generated, the QM/MM simulation can
be initiated by defining the specifics of the
[QM](QM_Parameters "wikilink") and [MM](MM_Parameters "wikilink")
descriptions, and if necessary [QM/MM](QMMM_Parameters "wikilink")
interface parameters.

The actual QM/MM calculation is invoked with the following task
directive.

` task qmmm `<string qmtheory>` `<string operation>` [numerical] [ignore]`

where qmtheory specifies quantum method for the calculation of the
quantum region. It is expected that most of QM/MM simulations will be
performed with with HF, DFT. or [CC](TCE "wikilink") theories, but any
other QM theory supported by NWChem should also work. NWChem supports
wide range of QM/MM tasks including

  - [single point energy/gradient
    calculations](qmmm_sp_energy "wikilink")
  - [properties](qmmm_sp_property "wikilink")
  - [ESP charge analysis](QMMM_ESP "wikilink")
  - [optimization and transition states](qmmm_optimization "wikilink")
  - [hessians and frequency](qmmm_freq "wikilink")
  - [reaction pathway calculations](qmmm_NEB_Calculations "wikilink")
  - [dynamics](QMMM_Dynamics "wikilink")
  - [free energy calculations](QMMM_Free_Energy "wikilink")
